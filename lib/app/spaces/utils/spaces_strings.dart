abstract final class SpacesStrings {
  static const username = 'anya.r';
  static const defaultTimestamp = 'this afternoon';
  static String sharingWith(int count) => 'sharing with $count people';

  static String visibleTo(String spaceName) =>
      'VISIBLE TO ${spaceName.toUpperCase()}';
  static const notVisibleToAnyone = 'NOT YET VISIBLE TO ANYONE';

  static const captionText = 'centuries in the walls. i just passed through';

  static String postTo(String spaceName) => 'Post to $spaceName';
  static const shareToSpace = 'SHARE TO A SPACE';

  static String postedTo(String spaceName) => 'Posted to $spaceName';

  static const defaultHelperText =
      'Posts on ThisKrit are private until you assign them to a space.';
  static const helperTextPrefix = 'This post will be visible only to your ';
  static const helperTextSuffix = ' Space.';

  static const sheetTitle = 'Who can see this?';
  static const sheetSubtitle =
      'Every ThisKrit post is shared with exactly who you want. Nobody more';

  static String memberCount(int count) => '$count people';

  static const noSpace = 'NO SPACE';
}
