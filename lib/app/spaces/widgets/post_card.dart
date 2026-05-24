import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/color_constants.dart';
import '../../../core/icon_constants.dart';
import '../../../core/text_styles.dart';
import '../models/space_item.dart';
import '../utils/spaces_strings.dart';
import 'pill_button.dart';
import 'space_badge.dart';

const _kSwitchDuration = Duration(milliseconds: 250);

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.selectedSpace,
    required this.onShareTap,
    required this.isPosting,
    required this.onPost,
  });

  final SpaceItem? selectedSpace;
  final VoidCallback onShareTap;
  final bool isPosting;
  final VoidCallback onPost;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey100,
        border: Border.all(color: AppColors.grey200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostCardHeader(selectedSpace: selectedSpace, onShareTap: onShareTap),
          _PostImage(selectedSpace: selectedSpace),
          const _PostActions(),
          const _PostCaption(),
          const SizedBox(height: 16),
          _ShareButton(
            selectedSpace: selectedSpace,
            onShareTap: onShareTap,
            isPosting: isPosting,
            onPost: onPost,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _PostCardHeader extends StatelessWidget {
  const _PostCardHeader({
    required this.selectedSpace,
    required this.onShareTap,
  });

  final SpaceItem? selectedSpace;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: CachedNetworkImage(
              height: 44,
              width: 44,
              imageUrl:
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=1364&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(SpacesStrings.username, style: AppTextStyles.username),
                AnimatedSwitcher(
                  duration: _kSwitchDuration,
                  child: Text(
                    key: ValueKey(selectedSpace?.name),
                    selectedSpace != null
                        ? SpacesStrings.sharingWith(selectedSpace!.memberCount)
                        : SpacesStrings.defaultTimestamp,
                    style: AppTextStyles.monoSm,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onShareTap,
            child: AnimatedSwitcher(
              duration: _kSwitchDuration,
              child: selectedSpace != null
                  ? SpaceBadge(
                      key: ValueKey(selectedSpace!.name),
                      spaceName: selectedSpace!.name,
                      avatarSeeds: selectedSpace!.avatarSeeds,
                    )
                  : PillButton(
                      key: const ValueKey('no-space'),
                      child: const Text(
                        SpacesStrings.noSpace,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'JetBrainsMono',
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({required this.selectedSpace});

  final SpaceItem? selectedSpace;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxrZjhZ2WGE1zOfv2ikZR45MpfBzT5E-lrzg&s',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              selectedSpace != null
                  ? SpacesStrings.visibleTo(selectedSpace!.name)
                  : SpacesStrings.notVisibleToAnyone,
              style: AppTextStyles.monoSm.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _PostActions extends StatelessWidget {
  const _PostActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(AppIcons.heart, height: 24, width: 24),
          SvgPicture.asset(AppIcons.comment, height: 24, width: 24),
          SvgPicture.asset(AppIcons.share, height: 24, width: 24),
        ],
      ),
    );
  }
}

class _PostCaption extends StatelessWidget {
  const _PostCaption();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: RichText(
        text: TextSpan(
          text: '${SpacesStrings.username}\t',
          style: AppTextStyles.username,
          children: [
            TextSpan(
              text: SpacesStrings.captionText,
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    required this.selectedSpace,
    required this.onShareTap,
    required this.isPosting,
    required this.onPost,
  });

  final SpaceItem? selectedSpace;
  final VoidCallback onShareTap;
  final bool isPosting;
  final VoidCallback onPost;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedSpace != null;

    return GestureDetector(
      onTap: isPosting ? null : (isSelected ? onPost : onShareTap),
      child: AnimatedContainer(
        duration: _kSwitchDuration,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AppColors.brand : AppColors.transparent,
          border: isSelected ? null : Border.all(color: AppColors.brand),
        ),
        child: AnimatedSwitcher(
          duration: _kSwitchDuration,
          child: isPosting
              ? SizedBox(
                  key: const ValueKey('loader'),
                  height: 20,
                  child: Center(
                    child: SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : Row(
                  key: ValueKey(selectedSpace?.name),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isSelected
                          ? SpacesStrings.postTo(selectedSpace!.name)
                          : SpacesStrings.shareToSpace,
                      style: AppTextStyles.monoMd.copyWith(
                        color: isSelected ? AppColors.white : AppColors.brand,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      AppIcons.arrow,
                      height: 16,
                      width: 16,
                      colorFilter: ColorFilter.mode(
                        isSelected ? AppColors.white : AppColors.brand,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
