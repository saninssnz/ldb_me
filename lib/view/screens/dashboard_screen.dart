import 'package:flutter/material.dart';
import 'package:ldb_me/utils/navigation_service.dart';
import 'package:ldb_me/view/screens/agenda_screen.dart';
import 'package:ldb_me/view/screens/drawer_screen.dart';
import 'package:ldb_me/view/widgets/dashboard_tiles.dart';

class DashboardScreen extends StatelessWidget {
  List<DashboardItem> _getItems(BuildContext context) {
    return [
      DashboardItem(
        title: 'Agenda',
        icon: "assets/icons/agenda.png",
        color: Color(0xFF31B8FF),
        onTap: () => navigateToScreen(context, AgendaScreen()),
      ),
      DashboardItem(
        title: 'Speakers',
        icon: "assets/icons/speakers.png",
        color: Color(0xFF1C5D99),
        onTap: () {},
      ),
      DashboardItem(
        title: 'Badge',
        icon: "assets/icons/badge.png",
        color: Color(0xFF1C5D99),
        onTap: () {},
      ),
      DashboardItem(
        title: 'Venue',
        icon: "assets/icons/venue.png",
        color: Color(0xFF31B8FF),
        onTap: () {},
      ),
      DashboardItem(
        title: 'Brand\nInnovation',
        icon: "assets/icons/images.png",
        color: Color(0xFF31B8FF),
        onTap: () {},
      ),
      DashboardItem(
        title: 'Brand\nVideos',
        icon: "assets/icons/videos.png",
        color: Color(0xFF1C5D99),
        onTap: () {},
      ),
      DashboardItem(
        title: 'Ask\nQuestions',
        icon: "assets/icons/questions.png",
        color: Color(0xFF1C5D99),
        onTap: () {},
      ),
      DashboardItem(
        title: 'Voting',
        icon: "assets/icons/voting.png",
        color: Color(0xFF31B8FF),
        onTap: () {},
      ),
      DashboardItem(
        title: 'Social Media',
        icon: "assets/icons/social.png",
        color: Color(0xFF1C5D99),
        onTap: () {},
      ),
      DashboardItem(
        title: 'Survey',
        icon: "assets/icons/survey.png",
        color: Color(0xFF31B8FF),
        onTap: () {},
      ),
      DashboardItem(
        title: 'CME',
        icon: "assets/icons/cme.png",
        color: Color(0xFF1C5D99),
        onTap: () {},
      ),
      DashboardItem(
        title: 'More',
        icon: "assets/icons/more.png",
        color: Color(0xFF31B8FF),
        onTap: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _getItems(context); // Get items with context

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF1C5D99),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return buildDashboardItem(items[index]);
        },
      ),
    );
  }
}