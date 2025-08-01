import 'dart:io';

class DocumentUploadModel {
  final String name;
  final List<File> images;


  DocumentUploadModel({required this.name, required this.images});

  Map<String, dynamic> toMap() {
    return {
      'documentName': name,
      'images': images.map((e) => e.path).toList(), // Adjust this as per API
    };
  }
}
