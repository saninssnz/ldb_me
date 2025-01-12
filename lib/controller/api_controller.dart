import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:ldb_me/model/agenda_model.dart';
import 'package:ldb_me/model/login_model.dart';
import 'package:ldb_me/model/register_model.dart';
import 'package:ldb_me/model/speaker_model.dart';
import 'package:ldb_me/services/api_services.dart';
import 'package:ldb_me/services/end_points.dart';
import 'package:ldb_me/utils/data/shared_preference.dart';

class ApiController extends GetxController {
  final ApiServices _apiService = ApiServices();
  RxBool isLoginLoading = false.obs;
  RxBool isAgendaLoading = false.obs;
  RxBool isSpeakersLoading = false.obs;
  RxBool isQuestionLoading = false.obs;
  RxString message = ''.obs;
  Rx<RegisterModel> registerModel = RegisterModel().obs;
  Rx<LoginModel> loginModel = LoginModel().obs;
  Rx<AgendaModel> agendaModel = AgendaModel().obs;
  Rx<SpeakerModel> speakerModel = SpeakerModel().obs;
  RxSet<String> daysData = <String>{}.obs;

  Future<bool> userLogin({String? email = "", String? password = ""}) async {
    try {
      isLoginLoading.value = true;
      message.value = "";

      var response = await _apiService.post(EndPoints.loginUser, body: {
        "Email": email,
        "Password": password,
      });

      message.value = response['Message'];
      if (response != null && response['Status'] == true) {
        loginModel(LoginModel.fromJson(response));
        await PreferenceUtils.storeLoginModel(loginModel.value);
        return true;
      }
      return false;
    } catch (e) {
      message.value = e.toString();
      return false;
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future<bool> registerUser({
    String? email = "",
    String? password = "",
    String? userName = "",
    String? mobile = "",
    String? speciality = "",
    String? country = "",
    String? instagram = "",
    String? tiktok = "",
  }) async {
    try {
      isLoginLoading.value = true;
      message.value = "";

      var response = await _apiService.post(EndPoints.registerUser, body: {
        "UserName": userName,
        'Email': email,
        'Mobile': mobile,
        'Password': password,
        'Speciality': speciality,
        'Country': country,
        'InstagramLink': instagram,
        'TikTokLink': tiktok,
        'Userconsent': "true"
      });

      message.value = response['Message'];
      if (response != null && response['Status'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      message.value = e.toString();
      return false;
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future<bool> getAgenda() async {
    try {
      isAgendaLoading.value = true;
      message.value = "";
      agendaModel.value = AgendaModel();

      var response = await _apiService.post(EndPoints.loadAgenda);

      message.value = response['Message'] ?? "";
      if (response != null) {
        agendaModel(AgendaModel.fromJson(response));

        if (agendaModel.value.data != null &&
            agendaModel.value.data?.result != null) {
          for (var i in agendaModel.value.data!.result!) {
            daysData.add(i.title.toString());
          }
        }
        return true;
      }
      return false;
    } catch (e) {
      message.value = e.toString();
      return false;
    } finally {
      isAgendaLoading.value = false;
    }
  }

  Future<bool> loadSpeakers() async {
    try {
      isSpeakersLoading.value = true;
      message.value = "";
      speakerModel.value = SpeakerModel();

      var response = await _apiService.post(EndPoints.loadSpeakers);

      message.value = response['Message'] ?? "";
      if (response != null) {
        speakerModel(SpeakerModel.fromJson(response));

        return true;
      }
      return false;
    } catch (e) {
      message.value = e.toString();
      return false;
    } finally {
      isSpeakersLoading.value = false;
    }
  }

  Future<bool> askQuestion(
      {String? speaker = "",
      String? userName = "",
      String? question = ""}) async {
    try {
      isQuestionLoading.value = true;
      message.value = "";
      agendaModel.value = AgendaModel();

      var response = await _apiService.post(EndPoints.askQuestions, body: {
        "SpeakerName": speaker,
        "AskedBy": userName,
        "QuestionDetail": question,
        "EventId": 1
      });

      message.value = response['Message'] ?? "";
      if (response != null) {
        // agendaModel(AgendaModel.fromJson(response));

        return true;
      }
      return false;
    } catch (e) {
      message.value = e.toString();
      return false;
    } finally {
      isQuestionLoading.value = false;
    }
  }
}
