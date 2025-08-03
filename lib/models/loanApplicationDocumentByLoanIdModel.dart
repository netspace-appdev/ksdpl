class LoanApplicationDocumentByLoanIdModel {
  String? status;
  bool? success;
  List<LoanUploadData>? data;
  String? message;

  LoanApplicationDocumentByLoanIdModel(
      {this.status, this.success, this.data, this.message});

  LoanApplicationDocumentByLoanIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <LoanUploadData>[];
      json['data'].forEach((v) {
        data!.add(new LoanUploadData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class LoanUploadData {
  int? id;
  int? loanId;
  String? imageName;
  String? imagePath;

  LoanUploadData({this.id, this.loanId, this.imageName, this.imagePath});

  LoanUploadData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanId = json['loanId'];
    imageName = json['imageName'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loanId'] = this.loanId;
    data['imageName'] = this.imageName;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
