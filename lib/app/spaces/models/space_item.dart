import 'package:flutter/material.dart';

class SpaceItem {
  const SpaceItem({
    required this.name,
    required this.description,
    required this.memberCount,
    required this.icon,
    required this.avatarSeeds,
  });

  final String name;
  final String description;
  final int memberCount;
  final Widget icon;
  final List<int> avatarSeeds;
}
