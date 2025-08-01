import 'dart:io';

class DocumentCamImage {
  final File? file;
  final String? url;
  final bool isLocal;

  DocumentCamImage({
    this.file,
    this.url,
    this.isLocal = true,
  });

  factory DocumentCamImage.fromFile(File file) {
    return DocumentCamImage(file: file, isLocal: true);
  }

  factory DocumentCamImage.fromUrl(String url) {
    return DocumentCamImage(url: url, isLocal: false);
  }
}
