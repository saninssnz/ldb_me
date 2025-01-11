import 'package:flutter/material.dart';
import 'package:ldb_me/utils/navigation_service.dart';
import 'package:ldb_me/view/screens/spearker_details_screen.dart';
import 'package:ldb_me/view/widgets/custom_scaffold.dart';
import 'package:ldb_me/view/widgets/header_widget.dart';

class SpeakersScreen extends StatelessWidget {
  final List<Speaker> speakers = [
    Speaker(
      name: 'Prof. Reinhard Dummer, MD',
      role: 'Vice-Chairman, Department of Dermatology University Hospital of Zurich, Switzerland',
      image: 'assets/images/person1.png',
      country: 'assets/images/AE.png',
    ),
    Speaker(
      name: 'Christopher HSU, MD',
      role: 'Global Dermatologist (Switzerland)\nGlobal Dermatology, JEADV & JAAD Editorial Boards\nInternational Society of TeleDermatology (Secretary General& Member of the Board)\nSwitzerland',
      image: 'assets/images/person1.png',
      country: 'assets/images/BH.png',
    ),
    Speaker(
      name: 'Dr Abdullah Al Essa, MD',
      role: 'CEO and Consultant Dermatologist\nat Derma Clinic Saudi Arabia',
      image: 'assets/images/person1.png',
      country: 'assets/images/AE.png',
    ),
    Speaker(
      name: 'Dr Tarun Chopra, Ph.D.',
      role: "L'Oreal Research and Innovation,\nScalp Research Consultant and\nFormulation Scientist",
      image: 'assets/images/person1.png',
      country: 'assets/images/BH.png',
    ),
  ];

  SpeakersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          // Logo and Title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                headerWidget(context,"SPEAKERS"),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0,left: 8,right: 8),
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
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: speakers.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    navigateToScreen(context, SpeakerDetailsScreen(speakerData: speakers[index]));
                  },
                    child: _buildSpeakerCard(speakers[index]));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakerCard(Speaker speaker) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  speaker.image.toString(),
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  speaker.country.toString(),
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  speaker.name.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  speaker.role.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,size: 15,)
        ],
      ),
    );
  }
}

class Speaker {
  final String? name;
  final String? role;
  final String? image;
  final String? country;

  Speaker({
    this.name,
    this.role,
    this.image,
    this.country,
  });
}