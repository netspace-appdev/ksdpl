class CheckPasswordResponseModel {
  final String status;
  final bool success;
  final String data;
  final String message;

  CheckPasswordResponseModel({
    this.status = '',
    this.success = false,
    this.data = '',
    this.message = '',
  });

  factory CheckPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckPasswordResponseModel(
      status: json['status']?.toString() ?? '',
      success: _parseBool(json['success']),
      data: json['data']?.toString() ?? '',
      message: json['message']?.toString() ?? '', // ✅ Fix here: fallback to empty string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'success': success,
      'data': data,
      'message': message,
    };
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    if (value is num) return value != 0;
    return false;
  }
}
