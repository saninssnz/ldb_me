import 'package:flutter/material.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Back', style: TextStyle(color: Colors.blue)),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Logo and Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/riyadh-loreal.png',
                  height: 80,
                ),
                SizedBox(height: 20,),
                Text(
                  'AGENDA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
          ),
          // Tab Bar
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              controller: _tabController,
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _tabController.index == 0? Colors.blue[900]:Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'DAY 1 - SATURDAY',
                          style: TextStyle(fontSize: 10,
                              color: _tabController.index == 0?Colors.white:Colors.blue[900]),
                        ),
                        Text(
                          'April 20, 2024',
                          style: TextStyle(fontSize: 10,
                              color: _tabController.index == 0?Colors.white:Colors.blue[900]),
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _tabController.index == 1? Colors.blue[900]:Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'DAY 2 - SUNDAY',
                          style: TextStyle(fontSize: 10,
                              color: _tabController.index == 1?Colors.white:Colors.blue[900]),
                        ),
                        Text(
                          'April 21, 2024',
                          style: TextStyle(fontSize: 10,
                              color: _tabController.index == 1?Colors.white:Colors.blue[900]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              indicator: BoxDecoration(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAgendaList(day1Sessions),
                _buildAgendaList(day2Sessions),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgendaList(List<AgendaSession> sessions) {
    return Column(
      children: [
        // Header
        Container(
          color: Colors.grey[400],
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Time",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Title",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // List of sessions
        Expanded(  // Wrap ListView with Expanded
          child: ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return Container(
                color: Colors.blue[50],  // Alternating colors
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          session.time,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              session.title,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            if (session.speakers.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  session.speakers,
                                  style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AgendaSession {
  final String time;
  final String title;
  final String speakers;

  AgendaSession({
    required this.time,
    required this.title,
    this.speakers = '',
  });
}

// Sample data
final day1Sessions = [
  AgendaSession(
    time: '09:00 - 10:30',
    title: 'Road of Innovations',
  ),
  AgendaSession(
    time: '10:30 - 10:40',
    title: 'Opening & Fight with Care',
    speakers: 'Mohamed El Araby',
  ),
  AgendaSession(
    time: '10:40 - 10:48',
    title: 'LDB medical introduction',
    speakers: 'Islam Ashour',
  ),
  // Add more sessions...
];

final day2Sessions = [
  AgendaSession(
    time: '10:00 - 10:30',
    title: 'Coffee Break',
  ),
  AgendaSession(
    time: '10:30 - 10:37',
    title: "L'Oreal for the future",
    speakers: 'Remi Nasser',
  ),
  AgendaSession(
    time: '10:37 - 11:10',
    title: 'Staying a step ahead in Social Media',
    speakers: 'Leila Al Samad, Dr Louai Salah, Dr Abdulhadi Jfri, Yasmin Yosry',
  ),
  // Add more sessions...
];