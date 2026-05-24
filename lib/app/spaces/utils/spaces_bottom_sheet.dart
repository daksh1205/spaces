import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/color_constants.dart';
import '../../../core/icon_constants.dart';
import '../../../core/text_styles.dart';
import '../models/space_item.dart';

class SpacesBottomSheet extends StatefulWidget {
  const SpacesBottomSheet({
    super.key,
    required this.spaces,
    this.initiallySelectedIndex,
    required this.onSpaceSelected,
  });

  final List<SpaceItem> spaces;
  final int? initiallySelectedIndex;
  final ValueChanged<int> onSpaceSelected;

  @override
  State<SpacesBottomSheet> createState() => _SpacesBottomSheetState();
}

class _SpacesBottomSheetState extends State<SpacesBottomSheet> {
  late int? _selectedIndex;
  int? _pressedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initiallySelectedIndex;
  }

  void _onItemTapDown(int index) => setState(() => _pressedIndex = index);

  void _onItemTapCancel() => setState(() => _pressedIndex = null);

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pressedIndex = null;
    });
    widget.onSpaceSelected(index);
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HandleBar(),
          _SheetHeader(onClose: () => Navigator.pop(context)),
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.grey100),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.spaces.length,
            itemBuilder: (_, index) => _SpaceListItem(
              space: widget.spaces[index],
              isSelected: _selectedIndex == index,
              isPressed: _pressedIndex == index,
              onTap: () => _onItemTap(index),
              onTapDown: () => _onItemTapDown(index),
              onTapCancel: _onItemTapCancel,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _HandleBar extends StatelessWidget {
  const _HandleBar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 32,
        height: 4,
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: AppColors.grey200,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Who can see this?', style: AppTextStyles.headingItalic),
                const SizedBox(height: 6),
                Text(
                  'Every Thiskrit post is shared with exactly who you want. Nobody more',
                  style: AppTextStyles.body.copyWith(color: AppColors.grey500),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onClose,
            child: SizedBox(
              height: 52,
              width: 52,
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.close,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    AppColors.grey500,
                    BlendMode.srcIn,
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

class _SpaceListItem extends StatelessWidget {
  const _SpaceListItem({
    required this.space,
    required this.isSelected,
    required this.isPressed,
    required this.onTap,
    required this.onTapDown,
    required this.onTapCancel,
  });

  final SpaceItem space;
  final bool isSelected;
  final bool isPressed;
  final VoidCallback onTap;
  final VoidCallback onTapDown;
  final VoidCallback onTapCancel;

  @override
  Widget build(BuildContext context) {
    final showWash = isSelected || isPressed;

    return GestureDetector(
      onTapDown: (_) => onTapDown(),
      onTapUp: (_) => onTap(),
      onTapCancel: onTapCancel,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: showWash ? AppColors.brandSubtle : AppColors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          child: Row(
            children: [
              _SpaceIcon(icon: space.icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(space.name, style: AppTextStyles.titleItalic),
                    Text(
                      space.description,
                      style: AppTextStyles.monoXs.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${space.memberCount} people',
                style: AppTextStyles.monoSm.copyWith(
                  fontSize: 13,
                  color: AppColors.grey500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpaceIcon extends StatelessWidget {
  const _SpaceIcon({required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: icon),
    );
  }
}

void showSpacesBottomSheet({
  required BuildContext context,
  required List<SpaceItem> spaces,
  int? initiallySelectedIndex,
  required ValueChanged<int> onSpaceSelected,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.transparent,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (ctx) => Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.pop(ctx),
            child: const ColoredBox(color: AppColors.transparent),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.5, sigmaY: 12.5),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SpacesBottomSheet(
                spaces: spaces,
                initiallySelectedIndex: initiallySelectedIndex,
                onSpaceSelected: onSpaceSelected,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
