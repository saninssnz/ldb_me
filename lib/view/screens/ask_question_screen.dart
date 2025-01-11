import 'package:flutter/material.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';

class AskQuestionScreen extends StatefulWidget {
  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  String? selectedSession;
  final List<String> sessions = [
    'Opening & Fight with Care',
    'Road of Innovations',
    'LDB medical introduction',
    'New MELA B3',
  ];

  final _nameController = TextEditingController();
  final _questionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
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
                ],
              ),
            ),
          ],
        ),
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
              minWidth: constraints.maxWidth,  // Make popup width same as field
              maxWidth: constraints.maxWidth,
            ),
            position: PopupMenuPosition.under,  // Position directly under the field
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
                        color: selectedSession != null ? Colors.black87 : Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            itemBuilder: (BuildContext context) {
              return sessions.map((String value) {
                return PopupMenuItem<String>(
                  value: value,
                  child: SizedBox(
                    width: double.infinity,  // Make menu item take full width
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList();
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
}