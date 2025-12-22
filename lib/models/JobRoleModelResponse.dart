class JobRoleModelResponse {
  String? status;
  bool? success;
  List<JobRoleData>? data;
  String? message;

  JobRoleModelResponse({this.status, this.success, this.data, this.message});

  JobRoleModelResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <JobRoleData>[];
      json['data'].forEach((v) {
        data!.add(new JobRoleData.fromJson(v));
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

class JobRoleData {
  String? id;
  String? name;
  String? normalizedName;

  JobRoleData({this.id, this.name, this.normalizedName});

  JobRoleData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    normalizedName = json['NormalizedName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['NormalizedName'] = this.normalizedName;
    return data;
  }
}
