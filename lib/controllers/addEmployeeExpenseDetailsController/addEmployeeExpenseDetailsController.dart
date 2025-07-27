import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ksdpl/controllers/viewExpenseController/viewExpenseController.dart';

import 'package:ksdpl/custom_widgets/CamImage.dart';
import 'package:ksdpl/services/generate_cibil_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/helper.dart';
import '../../common/storage_service.dart';
import '../../custom_widgets/ImagePickerMixin.dart';
import '../../models/AddEmployeeExpenseDetails/addEmployeeExpenseDetailsModel.dart';
import '../../models/AddEmployeeExpenseDetails/getExpenseDetailById.dart';
import '../../models/GenerateCibilResponseModel.dart';
import '../FilePickerController.dart';

class AddEmployeeExpenseDetailsController extends GetxController with ImagePickerMixin {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController camExpenseDateController = TextEditingController();
  final TextEditingController camTotalOverdueAmountController = TextEditingController();
  final TextEditingController camDescriptionController = TextEditingController();

  final filePickerController = Get.put(FilePickerController());

  var isLoading=false.obs;
  var getExpenseDetailById = Rxn<GetExpenseDetailByIdModel>(); //
  var photosPropEnabled =true.obs;
  var photosResEnabled =true.obs;
  var photosOffEnabled =true.obs;


  Future<void> addEmployeeExpenseDetailsApi() async {
    try {
      isLoading(true);
      String? empId = StorageService.get(StorageService.EMPLOYEE_ID);

      // Prepare file list
      List<http.MultipartFile> fileList = [];
      var pickedFiles = filePickerController.getFiles("docs");
      for (var file in pickedFiles) {
        fileList.add(await http.MultipartFile.fromPath('Documents', file.file.path));
      }

      var data = await GenerateCibilServices.addEmployeeExpenseRequestApi(
        employeeId: empId ?? '',
        entryDate: camExpenseDateController.text.trim(),     // Add this controller
        expenseDate: camExpenseDateController.text.trim(), // Add this controller
        description: camDescriptionController.text.trim(), // Add this controller
        documents: fileList,
      );

      if (data['success'] == true) {
        ToastMessage.msg(data['message']);
        clearFormFields();
        Get.back();
        // Do something (e.g. clear form, refresh)
      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in addEmployeeExpenseDetailsApi: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }


  //getProductListByIdApi
  Future<void> getEmployeeExpenseByIDRequest({
    required String ExpenseId
  }) async {
    try {
      isLoading(true);


      var data = await GenerateCibilServices.getEmployeeExpenseByIDRequest(
        ExpenseId: ExpenseId ?? '',
      );

      if (data['success'] == true) {
        //ToastMessage.msg(data['message']);
        getExpenseDetailById.value = GetExpenseDetailByIdModel.fromJson(data);

        camDescriptionController.text=getExpenseDetailById.value?.data?.description.toString()??'';
        camExpenseDateController.text=formatDate(getExpenseDetailById.value?.data?.expenseDate.toString()??'');

      } else {
        ToastMessage.msg(data['message'] ?? AppText.somethingWentWrong);
      }
    } catch (e) {
      print("Error in getEmployeeExpenseByIDRequest: $e");
      ToastMessage.msg(AppText.somethingWentWrong);
    } finally {
      isLoading(false);
    }
  }


  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yy').format(parsedDate);
    } catch (e) {
      return '';
    }
  }


  void clearFormFields() {
    camDescriptionController.clear();
    camExpenseDateController.clear();
    //filePickerController.getFiles('docs').clear();

  }
  @override
  // TODO: implement imageMap
  Map<String, RxList<CamImage>> get imageMap => throw UnimplementedError();



}

