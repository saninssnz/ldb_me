import 'package:flutter/material.dart';
import 'package:ldb_me/view/screens/speakers_screen.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';

class SpeakerDetailsScreen extends StatefulWidget {
  Speaker speakerData = Speaker();
  SpeakerDetailsScreen({super.key,required this.speakerData});

  @override
  State<SpeakerDetailsScreen> createState() => _SpeakerDetailsScreenState();
}

class _SpeakerDetailsScreenState extends State<SpeakerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          headerWidget(context,""),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0,0,16,0),
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
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              widget.speakerData.image.toString(),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              widget.speakerData.country.toString(),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Text(
                        widget.speakerData.role.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        widget.speakerData.name.toString(),
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
