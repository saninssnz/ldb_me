import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ldb_me/model/speaker_model.dart';
import 'package:ldb_me/view/screens/speakers_screen.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';

class SpeakerDetailsScreen extends StatefulWidget {
  Result speakerData = Result();
  SpeakerDetailsScreen({super.key, required this.speakerData});

  @override
  State<SpeakerDetailsScreen> createState() => _SpeakerDetailsScreenState();
}

class _SpeakerDetailsScreenState extends State<SpeakerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          headerWidget(context, ""),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
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
                        imageUrl: widget.speakerData.speakerImage.toString(),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey[200],
                          child: const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey[200],
                          child: const Icon(Icons.person,
                              size: 50, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Html(
                          data:
                              widget.speakerData.speakerDesignation.toString()),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.speakerData.speakerName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
