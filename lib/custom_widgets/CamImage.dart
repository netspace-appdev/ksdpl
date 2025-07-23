import 'dart:io';

class CamImage {
  final File? file;
  final String? url;

  CamImage.file(this.file) : url = null;
  CamImage.network(this.url) : file = null;

  bool get isLocal => file != null;
  bool get isNetwork => url != null;
}