import 'dart:async';
import 'package:app_mobile/presentation/pages/game_map/level_button.dart';
import 'package:app_mobile/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameMapScreen extends StatefulWidget {
  const GameMapScreen({super.key});

  @override
  State<GameMapScreen> createState() => _GameMapScreenState();
}

class _GameMapScreenState extends State<GameMapScreen> {
  int currentMapIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapProvider>().getMapData(mapId: currentMapIndex + 1);
    });
  }

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

  void _changeMap(int newIndex) {
    setState(() {
      currentMapIndex = newIndex;
    });

    context.read<MapProvider>().getMapData(
          mapId: currentMapIndex + 1,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading && provider.gameMapData == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.error != null && provider.gameMapData == null) {
          return Scaffold(
            body: Center(
              child: Text(provider.error!),
            ),
          );
        }

        final map = provider.gameMapData;

        if (map == null) {
          return const Scaffold(
            body: Center(child: Text('No map data')),
          );
        }

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
                                  left: screenWidth * level.x - (level.size / 2),
                                  top: mapHeight * level.y - (level.size / 2),
                                  child: LevelButton(level: level),
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
                                    ? () => _changeMap(currentMapIndex - 1)
                                    : null,
                                icon: const Icon(Icons.arrow_back),
                              ),
                              IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: currentMapIndex < 6
                                    ? () => _changeMap(currentMapIndex + 1)
                                    : null,
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (provider.isLoading)
                        const Positioned(
                          top: 60,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}