import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ldb_me/controller/api_controller.dart';
import 'package:ldb_me/model/agenda_model.dart';
import 'package:ldb_me/view/screens/drawer_screen.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiController apiController = Get.put(ApiController());

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    await apiController.getAgenda();

    if (mounted) {
      if (apiController.message.value.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(apiController.message.value))
        );
      }
      _tabController = TabController(
        length: apiController.daysData.value.length,
        vsync: this,
      );
      _tabController.addListener(() {
        setState(() {});
      });

      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Obx(() {
        return apiController.isAgendaLoading.value
            ? Center(
                child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Color(0xFFA0C5FF),
                    )),
              )
            : Column(
                children: [
                  headerWidget(context, "AGENDA"),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 8, right: 8, bottom: 8),
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
                    tabs: List.generate(
                      apiController.daysData.length,
                          (index) => Tab(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                color: _tabController.index == index
                                    ? Color(0xFF0868A3)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "DAY ${index + 1} - ${apiController.daysData.value.elementAt(index)}",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 8,
                                    height: 1.2,
                                    color: _tabController.index == index
                                        ? Colors.white
                                        : Color(0xFF0868A3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ),
                    indicator: BoxDecoration(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(
                        apiController.daysData.value.length,
                            (index) => _buildAgendaList(),
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Widget _buildAgendaList() {
    return Obx(() {
      return Column(
        children: [
          // Header
          Container(
            color: Colors.grey[500],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
          Expanded(
            child: ListView.builder(
              itemCount: apiController.agendaModel.value.data?.result
                  ?.where((item) => item.title == apiController.daysData.value.elementAt(_tabController.index))
                  .toList()
                  .length ?? 0,
              itemBuilder: (context, index) {
                final currentDayTitle = apiController.daysData.value.elementAt(_tabController.index);
                final filteredList = apiController.agendaModel.value.data?.result
                    ?.where((item) => item.title == currentDayTitle)
                    .toList();

                if (filteredList == null || filteredList.isEmpty) {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No data available"),
                  ));
                }

                final session = filteredList[index];

                return Column(
                  children: [
                    Container(
                      color: Colors.blue[50],
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                session.time ?? "",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    session.topic ?? "",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  if (session.speakerName?.isNotEmpty ?? false)
                                    Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        session.speakerName ?? "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
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
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
