import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/color_constants.dart';
import '../../../core/icon_constants.dart';
import '../../../core/text_styles.dart';
import '../models/space_item.dart';
import '../utils/spaces_bottom_sheet.dart';
import '../widgets/pill_button.dart';
import '../widgets/post_card.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({super.key});

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  static final _rng = Random();

  static List<int> _seeds() => List.generate(3, (_) => _rng.nextInt(70) + 1);

  static final List<SpaceItem> _spaces = [
    SpaceItem(
      name: 'Friends',
      description: 'Close circle. Daily life, no filter.',
      memberCount: 12,
      icon: SvgPicture.asset(AppIcons.friends, height: 20),
      avatarSeeds: _seeds(),
    ),
    SpaceItem(
      name: 'Family',
      description: 'Parents, siblings, in-laws.',
      memberCount: 7,
      icon: SvgPicture.asset(AppIcons.family, height: 20),
      avatarSeeds: _seeds(),
    ),
    SpaceItem(
      name: 'Work',
      description: 'Colleagues. Professional context only.',
      memberCount: 24,
      icon: SvgPicture.asset(AppIcons.work, height: 20),
      avatarSeeds: _seeds(),
    ),
  ];

  SpaceItem? _selectedSpace;

  void _onSpaceSelected(int index) {
    setState(() => _selectedSpace = _spaces[index]);
  }

  void _openSpacesSheet() {
    showSpacesBottomSheet(
      context: context,
      spaces: _spaces,
      initiallySelectedIndex: _selectedSpace == null
          ? null
          : _spaces.indexOf(_selectedSpace!),
      onSpaceSelected: _onSpaceSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey75,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _TopBar(),
              const SizedBox(height: 24),
              PostCard(
                selectedSpace: _selectedSpace,
                onShareTap: _openSpacesSheet,
              ),
              const SizedBox(height: 16),
              _HelperText(selectedSpace: _selectedSpace),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('ThisKrit', style: AppTextStyles.brandTitle),
        PillButton(
          child: Row(
            children: [
              SvgPicture.asset(AppIcons.create, height: 12, width: 12),
              const SizedBox(width: 8),
              Text('NEW POST', style: AppTextStyles.monoSm),
            ],
          ),
        ),
      ],
    );
  }
}

class _HelperText extends StatelessWidget {
  const _HelperText({required this.selectedSpace});

  final SpaceItem? selectedSpace;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: selectedSpace == null
          ? Text(
              key: const ValueKey('default'),
              'Posts on ThisKrit are private until you assign them to a space.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            )
          : RichText(
              key: ValueKey(selectedSpace!.name),
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTextStyles.body,
                children: [
                  const TextSpan(
                    text: 'This post will be visible only to your ',
                  ),
                  TextSpan(
                    text: selectedSpace!.name,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: ' Space.'),
                ],
              ),
            ),
    );
  }
}
