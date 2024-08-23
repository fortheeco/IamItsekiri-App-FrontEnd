import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/screens/community/join_community_screen.dart';
import 'package:oneitsekiri_flutter/screens/events/events_screen.dart';
import 'package:oneitsekiri_flutter/screens/home/home_feed_screen.dart';
import 'package:oneitsekiri_flutter/screens/messages/messages_screen.dart';

/// The state notifier provider for controlling the state of the base nav wrapper
final baseNavControllerProvider =
    StateNotifierProvider<BaseNavController, int>((ref) {
  return BaseNavController();
});

/// The state notifier class for controlling the state of the base nav wrapper
class BaseNavController extends StateNotifier<int> {
  BaseNavController() : super(0);

  //! move to page
  void moveToPage({required int index}) {
    state = index;
  }
}

/// function to move to a page
void moveToPage({
  required BuildContext context,
  required WidgetRef ref,
  required int index,
}) {
  ref.read(baseNavControllerProvider.notifier).moveToPage(index: index);
}

/// List of pages
List<Widget> pages = [
  const HomeFeedScreen(),
  const JoinCommunityScreen(),
  const EventsScreen(),
  const MessagesScreen()
];

/// nav widget enums
enum Nav {
  home('lib/assets/images/home-2.svg', 'Home'),
  community('lib/assets/images/people.svg', 'Community'),
  event('lib/assets/images/calendar.svg', 'Events'),
  messages('lib/assets/images/messages-2.svg', 'Messages');

  const Nav(
    this.icon,
    this.iconName,
  );
  final String icon;
  final String iconName;
}

List<Nav> nav = [
  Nav.home,
  Nav.community,
  Nav.event,
  Nav.messages,
];
