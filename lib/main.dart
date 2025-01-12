import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ldb_me/controller/api_controller.dart';
import 'package:ldb_me/model/login_model.dart';
import 'package:ldb_me/utils/data/shared_preference.dart';
import 'package:ldb_me/view/screens/dashboard_screen.dart';
import 'package:ldb_me/view/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ApiController authController = Get.put(ApiController());


  @override
  void initState() {
    authController.loginModel.value =
        PreferenceUtils.getLoginModel() ?? LoginModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}