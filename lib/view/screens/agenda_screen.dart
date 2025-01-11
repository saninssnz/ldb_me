import 'package:flutter/material.dart';
import 'package:ldb_me/view/screens/drawer_screen.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';

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
    return CustomScaffold(
      body: Column(
        children: [
          headerWidget(context,"AGENDA"),
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left: 8,right: 8),
            child: Container(
              height: 0.5,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.grey,
            ),
          ),
          TabBar(
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
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    color: _tabController.index == 0? Color(0xFF0868A3):Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'DAY 1 - SATURDAY',
                        style: TextStyle(fontSize: 10,
                            color: _tabController.index == 0?Colors.white:Color(0xFF0868A3)),
                      ),
                      Text(
                        'April 20, 2024',
                        style: TextStyle(fontSize: 10,
                            color: _tabController.index == 0?Colors.white:Color(0xFF0868A3)),
                      ),
                    ],
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    color: _tabController.index == 1? Color(0xFF0868A3):Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'DAY 2 - SUNDAY',
                        style: TextStyle(fontSize: 10,
                            color: _tabController.index == 1?Colors.white:Color(0xFF0868A3)),
                      ),
                      Text(
                        'April 21, 2024',
                        style: TextStyle(fontSize: 10,
                            color: _tabController.index == 1?Colors.white:Color(0xFF0868A3)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            indicator: BoxDecoration(),
          ),
          SizedBox(height: 8,),
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
          color: Colors.grey[500],
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
                    "Details",
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
              return Column(
                children: [
                  Container(
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
                                        color: Colors.black,fontWeight: FontWeight.w600,
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
                  ),
                  Container(
                    height: 0.5,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.blue,
                  )
                ],
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