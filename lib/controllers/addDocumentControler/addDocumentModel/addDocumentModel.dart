import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../custom_widgets/CamImage.dart';
import '../../../custom_widgets/DocumentCamImage.dart';

class AdddocumentModel {
  final TextEditingController aiSourceController = TextEditingController();
  final TextEditingController aiIncomeController = TextEditingController(); // If needed
  // List<DocumentCamImage> selectedImages = [];
  RxList<DocumentCamImage> selectedImages = <DocumentCamImage>[].obs;

}