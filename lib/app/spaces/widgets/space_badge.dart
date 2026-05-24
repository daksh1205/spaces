import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/color_constants.dart';
import '../../../core/text_styles.dart';

class SpaceBadge extends StatelessWidget {
  const SpaceBadge({
    super.key,
    required this.spaceName,
    required this.avatarSeeds,
  });

  final String spaceName;
  final List<int> avatarSeeds;

  static const double _avatarSize = 20;
  static const double _overlap = 6;

  @override
  Widget build(BuildContext context) {
    final stackWidth =
        _avatarSize + (avatarSeeds.length - 1) * (_avatarSize - _overlap);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.brandSubtle,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StackedAvatars(seeds: avatarSeeds, stackWidth: stackWidth),
          const SizedBox(width: 6),
          Text(
            spaceName,
            style: AppTextStyles.monoSm.copyWith(color: AppColors.brand),
          ),
        ],
      ),
    );
  }
}

class _StackedAvatars extends StatelessWidget {
  const _StackedAvatars({required this.seeds, required this.stackWidth});

  final List<int> seeds;
  final double stackWidth;

  static const double _avatarSize = SpaceBadge._avatarSize;
  static const double _overlap = SpaceBadge._overlap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: stackWidth,
      height: _avatarSize,
      child: Stack(
        children: List.generate(seeds.length, (i) {
          return Positioned(
            left: i * (_avatarSize - _overlap),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://i.pravatar.cc/${_avatarSize.toInt()}?img=${seeds[i]}',
                  width: _avatarSize,
                  height: _avatarSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
