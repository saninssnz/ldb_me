import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ldb_me/controller/api_controller.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';

class AskQuestionScreen extends StatefulWidget {
  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final ApiController apiController = Get.put(ApiController());

  String? selectedSession;
  bool _isButtonEnabled = false;

  final _nameController = TextEditingController();
  final _questionController = TextEditingController();

  @override
  void initState() {
    apiController.loadSpeakers();
    _nameController.addListener(_updateButtonState);
    _questionController.addListener(_updateButtonState);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Obx(() {
          return apiController.isSpeakersLoading.value
              ? Center(
            child: const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Color(0xFFA0C5FF),
                )),
          )
              : SingleChildScrollView(
            child: Column(
              children: [
                headerWidget(context, "AGENDA"),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 8, right: 8),
                  child: Container(
                    height: 0.5,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Select Session'),
                      _buildCustomDropdown(),
                      SizedBox(height: 24),
                      _buildLabel('Your Name'),
                      _buildTextField(_nameController),
                      SizedBox(height: 24),
                      _buildLabel('Ask Question'),
                      _buildTextField(_questionController, maxLines: 4),
                      SizedBox(height: 32),
                      apiController.isQuestionLoading.value
                          ? Center(
                              child: const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFA0C5FF),
                                  )),
                            )
                          : IgnorePointer(
                              ignoring: !_isButtonEnabled || selectedSession == null,
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    apiController
                                        .askQuestion(
                                            question: _questionController.text,
                                            speaker: selectedSession,
                                            userName: _nameController.text)
                                        .then((value) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    apiController.message.value)));
                                        if (value) {
                                          setState(() {
                                            _questionController.clear();
                                            selectedSession = null;
                                            _nameController.clear();
                                          });
                                        }
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedSession != null &&
                                           _isButtonEnabled
                                        ? Color(0xFFA0C5FF)
                                        : Colors.lightBlue[100],
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Send',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.star, size: 8, color: Colors.blue),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDropdown() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(3),
          ),
          child: PopupMenuButton<String>(
            color: Colors.white,
            offset: Offset(0, 0),
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth, // Make popup width same as field
              maxWidth: constraints.maxWidth,
            ),
            position:
                PopupMenuPosition.under, // Position directly under the field
            onSelected: (String value) {
              setState(() {
                selectedSession = value;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.grey[600],
                        size: 12,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey[600],
                        size: 12,
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      selectedSession ?? '',
                      style: TextStyle(
                        color: selectedSession != null
                            ? Colors.black87
                            : Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            itemBuilder: (BuildContext context) {
              return apiController.speakerModel.value.data?.result?.map((speaker) {
                return PopupMenuItem<String>(
                  value: speaker.speakerName ?? '',
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      speaker.speakerName ?? '',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList() ?? [];
            },
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty && _questionController.text.isNotEmpty;
    });
  }
}
