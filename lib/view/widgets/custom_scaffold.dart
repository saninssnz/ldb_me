import 'package:flutter/material.dart';
import 'package:ldb_me/view/screens/drawer_screen.dart';

class CustomScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? endDrawer;
  final VoidCallback? onBackPressed;

  const CustomScaffold({
    Key? key,
    this.title,
    required this.body,
    this.endDrawer,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5
          )
        ),
        iconTheme: const IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue, size: 18),
          onPressed: onBackPressed ?? () => Navigator.pop(context),
        ),
        title: InkWell(
          onTap: onBackPressed ?? () => Navigator.pop(context),
          child: Text(title??"Back", style: const TextStyle(color: Colors.blue, fontSize: 15)),
        ),
        titleSpacing: 0,
      ),
      body: body,
    );
  }
}
