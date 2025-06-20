class SendMailToBankerCamNoteModel {
  final String? message;

  SendMailToBankerCamNoteModel({this.message});

  factory SendMailToBankerCamNoteModel.fromJson(Map<String, dynamic> json) {
    return SendMailToBankerCamNoteModel(
      message: json['message'],
    );
  }
}