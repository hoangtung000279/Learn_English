import 'package:flutter/material.dart';

class ScanResultBottomSheet extends StatelessWidget {
  final String resultTitle;
  final String resultSubtitle;
  final VoidCallback onAddToList;
  final VoidCallback onFavorite;
  final VoidCallback onSpeak;

  const ScanResultBottomSheet({
    super.key,
    required this.resultTitle,
    required this.resultSubtitle,
    required this.onAddToList,
    required this.onFavorite,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      resultTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1C1C1C),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      resultSubtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.2,
                        color: Color(0xFF6A6A6A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _RoundIconButton(
                icon: Icons.folder_open_rounded,
                onTap: onAddToList,
              ),
              const SizedBox(width: 10),
              _RoundIconButton(
                icon: Icons.favorite_border_rounded,
                onTap: onFavorite,
              ),
              const SizedBox(width: 10),
              _RoundIconButton(
                icon: Icons.volume_up_rounded,
                onTap: onSpeak,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 26,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF2D6BFF), size: 22),
      ),
    );
  }
}