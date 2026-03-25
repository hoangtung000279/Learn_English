import 'dart:async';
import 'package:app_mobile/model/map_model.dart';
import 'package:app_mobile/presentation/pages/game_map/level_button.dart';
import 'package:flutter/material.dart';

class GameMapScreen extends StatefulWidget {
  const GameMapScreen({super.key});

  @override
  State<GameMapScreen> createState() => _GameMapScreenState();
}

class _GameMapScreenState extends State<GameMapScreen> {
  int currentMapIndex = 0;

  Future<Size> _getImageSize(String assetPath) {
    final completer = Completer<Size>();
    final image = AssetImage(assetPath);

    final stream = image.resolve(const ImageConfiguration());
    late final ImageStreamListener listener;

    listener = ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(
        Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ),
      );
      stream.removeListener(listener);
    });

    stream.addListener(listener);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final map = gameMaps[currentMapIndex];

    return Scaffold(
      body: FutureBuilder<Size>(
        future: _getImageSize(map.background),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final imageSize = snapshot.data!;

          return LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final mapHeight =
                  screenWidth * imageSize.height / imageSize.width;

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      width: screenWidth,
                      height: mapHeight,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              map.background,
                              fit: BoxFit.fill,
                            ),
                          ),

                          ...map.levels.map((level) {
                            return Positioned(
                                left: screenWidth * level.x - 32,
                                top: mapHeight * level.y - 32,
                                child: LevelButton(
                                    level: level,
                                ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: currentMapIndex > 0
                                ? () {
                                    setState(() {
                                      currentMapIndex--;
                                    });
                                  }
                                : null,
                            icon: const Icon(Icons.arrow_back),
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: currentMapIndex < gameMaps.length - 1
                                ? () {
                                    setState(() {
                                      currentMapIndex++;
                                    });
                                  }
                                : null,
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

