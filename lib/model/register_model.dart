// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String? message;
  dynamic eventid;
  bool? status;
  int? id;
  String? useruniqueid;
  String? qrCode;
  String? doctorName;
  String? email;
  dynamic eventIds;

  RegisterModel({
    this.message,
    this.eventid,
    this.status,
    this.id,
    this.useruniqueid,
    this.qrCode,
    this.doctorName,
    this.email,
    this.eventIds,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json["Message"],
    eventid: json["eventid"],
    status: json["Status"],
    id: json["id"],
    useruniqueid: json["Useruniqueid"],
    qrCode: json["QrCode"],
    doctorName: json["DoctorName"],
    email: json["Email"],
    eventIds: json["EventIds"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "eventid": eventid,
    "Status": status,
    "id": id,
    "Useruniqueid": useruniqueid,
    "QrCode": qrCode,
    "DoctorName": doctorName,
    "Email": email,
    "EventIds": eventIds,
  };
}
