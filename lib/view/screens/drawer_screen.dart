import 'package:flutter/material.dart';
import 'package:ldb_me/utils/navigation_service.dart';
import 'package:ldb_me/view/screens/agenda_screen.dart';
import 'package:ldb_me/view/screens/ask_question_screen.dart';
import 'package:ldb_me/view/screens/badge_screen.dart';
import 'package:ldb_me/view/screens/speakers_screen.dart';

class CustomDrawer extends StatelessWidget {
  List<DrawerItem> getMenuItems(BuildContext context) {
    return [
      DrawerItem(
        title: 'All Events Menu',
        icon: Icons.list,
      ),
      DrawerItem(
        title: 'Home',
        icon: Icons.home_outlined,
      ),
      DrawerItem(
          title: 'Agenda',
          icon: Icons.calendar_today_outlined,
          onTap: () {
            navigateToScreen(context, AgendaScreen());
          }),
      DrawerItem(
          title: 'Speakers',
          icon: Icons.people_outline,
          onTap: () {
            navigateToScreen(context, SpeakersScreen());
          }),
      DrawerItem(
          title: 'Badge',
          icon: Icons.verified_outlined,
          onTap: () {
            navigateToScreen(context, BadgeScreen());
          }),
      DrawerItem(
        title: 'Venue',
        icon: Icons.map_outlined,
      ),
      DrawerItem(
        title: 'Brand Videos',
        icon: Icons.videocam_outlined,
      ),
      DrawerItem(
        title: 'Brand Images',
        icon: Icons.image_outlined,
      ),
      DrawerItem(
          title: 'Ask Questions',
          icon: Icons.help_outline,
          onTap: () {
            navigateToScreen(context, AskQuestionScreen());
          }),
      DrawerItem(
        title: 'Social Media',
        icon: Icons.send_outlined,
      ),
      DrawerItem(
        title: 'Survey',
        icon: Icons.assignment_outlined,
      ),
      DrawerItem(
        title: 'CME',
        icon: Icons.edit_outlined,
      ),
      DrawerItem(
        title: 'Voting',
        icon: Icons.how_to_vote_outlined,
      ),
    ];
  }

  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = getMenuItems(context);
    return Theme(
      data: Theme.of(context).copyWith(
        drawerTheme: DrawerThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return _buildMenuItem(menuItems[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(DrawerItem item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(
        item.icon,
        color: Colors.grey[800],
        size: 24,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: item.onTap,
      tileColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      selectedTileColor: Colors.transparent,
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  DrawerItem({
    required this.title,
    required this.icon,
    this.onTap,
  });
}
