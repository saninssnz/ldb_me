import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ldb_me/controller/api_controller.dart';
import 'package:ldb_me/model/speaker_model.dart';
import 'package:ldb_me/utils/navigation_service.dart';
import 'package:ldb_me/view/screens/spearker_details_screen.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';


class SpeakersScreen extends StatefulWidget {
  const SpeakersScreen({super.key});

  @override
  State<SpeakersScreen> createState() => _SpeakersScreenState();
}

class _SpeakersScreenState extends State<SpeakersScreen> {
  final ApiController apiController = Get.put(ApiController());

  @override
  void initState() {
    apiController.loadSpeakers();
    super.initState();
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
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        headerWidget(context, "SPEAKERS"),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 8, right: 8),
                          child: Container(
                            height: 0.5,
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Speakers List
                  Expanded(
                    child: apiController.speakerModel.value.data != null &&
                            apiController.speakerModel.value.data?.result !=
                                null
                        ? ListView.builder(
                            padding: EdgeInsets.all(16),
                            itemCount: apiController
                                .speakerModel.value.data?.result?.length,
                            itemBuilder: (context, index) {
                              final speaker = apiController
                                  .speakerModel.value.data!.result?[index];
                              return InkWell(
                                  onTap: () {
                                    navigateToScreen(
                                        context,
                                        SpeakerDetailsScreen(
                                            speakerData: speaker ?? Result()));
                                  },
                                  child:
                                      _buildSpeakerCard(speaker ?? Result()));
                            },
                          ):Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No data available"),
                        )),
                  ),
                ],
              );
      }),
    );
  }

  Widget _buildSpeakerCard(Result speaker) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: speaker.speakerImage.toString(),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  speaker.speakerName.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Html(data: speaker.speakerDesignation.toString(),
                  style: {
                    "body": Style(
                      fontSize: FontSize(12),
                      color: Colors.grey[600],
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                    ),
                    "p": Style(
                      margin: Margins.only(bottom: 4),
                    ),
                    "i": Style(
                      fontStyle: FontStyle.italic,
                    ),
                    "a": Style(
                      color: Colors.blue,
                      textDecoration: TextDecoration.underline,
                    ),
                  },)
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 15,
          )
        ],
      ),
    );
  }
}
