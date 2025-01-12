import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ldb_me/controller/api_controller.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          headerWidget(context,""),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0,0,16,0),
            child: Material(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: apiController.loginModel.value.qrCode.toString(),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFA0C5FF),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      fadeInDuration: Duration(milliseconds: 300),
                    ),
                    Text("SCAN THIS QR CODE FOR ATTENDANCE",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,fontWeight: FontWeight.w500
                    ),),
                    Text("\"${apiController.loginModel.value.doctorName}\"",style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.blue[800]
                    ),)
                  ],
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
