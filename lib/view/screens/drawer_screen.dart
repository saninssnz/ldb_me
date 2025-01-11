import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<DrawerItem> menuItems = [
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
    ),
    DrawerItem(
      title: 'Speakers',
      icon: Icons.people_outline,
    ),
    DrawerItem(
      title: 'Badge',
      icon: Icons.verified_outlined,
    ),
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
    ),
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

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Remove the rounded corners from drawer
        drawerTheme: DrawerThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(16),
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
                    color: Colors.blue[900],  // Darker blue for Menu text
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
        color: Colors.grey[800],  // Darker grey for icons
        size: 24,
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: Colors.grey[800],  // Matching text color with icons
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        // Handle navigation here
      },
      // Remove the default ListTile hover effect
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

  DrawerItem({
    required this.title,
    required this.icon,
  });
}