import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:ksdpl/controllers/more/profileMultiFormController/employmentFormController .dart';
import 'package:ksdpl/custom_widgets/CustomDropdown.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/enforcement_panel/upload_common_task_controller.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/more/ProfileController.dart';
import '../../controllers/more/profileMultiFormController/educationFormController.dart';
import '../../custom_widgets/CustomElevatedButton.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;

import '../InsuranceIllustrations/InsuranceIllustrationDetailLeads.dart';



class ProfileScreen extends StatelessWidget {
  // const ProfileScreen({super.key});

  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  ProfileController profileController = Get.put(ProfileController());
  EducationFormController educationFormController = Get.put(EducationFormController());
  EmploymentFormController  workExperienceFormController = Get.put(EmploymentFormController ());



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());
  LeadDDController leadDDController = Get.put(LeadDDController());
  UploadCommonTaskController uploadCommonTaskController=Get.put(UploadCommonTaskController());


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        key:_scaffoldKey,
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Gradient Background
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child:Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        header(context),
                      ],
                    ),
                  ),

                  // White Container
                  Align(
                    alignment: Alignment.topCenter,  // Centers it
                    child: Container(
                      margin:  EdgeInsets.only(
                          top:90 // MediaQuery.of(context).size.height * 0.22
                      ), // <-- Moves it 30px from top
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height*0.80,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: const BoxDecoration(
                        color: AppColor.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child:  SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                              ExpansionTile(
                                initiallyExpanded: true,
                                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                                title:const Text( AppText.Profile, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                                leading: Icon(Icons.list_alt, size: 20,),
                                children: [

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomLabeledTextField(
                                        label: AppText.employeeName,
                                        isRequired: false,
                                        isInputEnabled: false,
                                        controller: profileController.employeeNameController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.employeeName,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.dateOfBirth,
                                        isRequired: false,
                                        isInputEnabled: false,
                                        controller: profileController.dateOfBirthController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.dateOfBirth,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.emailNoStar,
                                        isRequired: false,
                                        isInputEnabled: false,
                                        controller: profileController.profileEmailController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterEA,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.phoneNumberNoStar,
                                        isRequired: false,
                                        isInputEnabled: false,
                                        controller: profileController.phoneNumberController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterPhNumber,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.whatsappNoNoStar,
                                        isRequired: false,
                                        controller: profileController.whatsappNoController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.whatsappNoNoStar,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.HireDate,
                                        isRequired: false,
                                        isInputEnabled: false,
                                        controller: profileController.hireDate,
                                        inputType: TextInputType.name,
                                        hintText: AppText.TypeHireDate,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.JobRole,
                                        isRequired: false,
                                        isInputEnabled: false,
                                        controller: profileController.JobRoleController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.JobRole,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.WorkPlace,
                                        isRequired: true,
                                        isInputEnabled: false,
                                        controller: profileController.WorkPlaceController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.WorkPlace,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      const Row(
                                        children: [
                                          Text(
                                            AppText.gender,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.grey2,
                                            ),
                                          ),
                                          Text(
                                            " *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.redColor,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Obx(()=>  Row(
                                        children: [
                                          _buildRadioOption("Male", "M"),
                                          _buildRadioOption("Female", "F"),
                                          _buildRadioOption("Other", "O"),
                                        ],
                                      ),
                                      ),
                                      const SizedBox(height: 10),
                                      CustomLabeledTextField(
                                        label: AppText.ManagerName,
                                        isRequired: true,
                                        isInputEnabled: false,
                                        controller: profileController.managerNameController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.ManagerName,
                                        validator: ValidationHelper.validateDescription,
                                      ),
/*
                                      CustomLabeledTextField(
                                        label: AppText.address,
                                        isRequired: true,
                                        controller: profileController.addressController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.address,
                                        validator: ValidationHelper.validateDescription,
                                      ),
*/

                                      CustomLabeledTextField(
                                        label: AppText.address,
                                        isRequired: true,
                                        controller: profileController.addressController,
                                        inputType: TextInputType.multiline, // 👈 allows multi-line text
                                        hintText: AppText.address,
                                        validator: ValidationHelper.validateDescription,
                                        isInputEnabled: false, // 👈 field disabled (read-only)
                                        isTextArea: true,      // 👈 enables multi-line mode
                                       // maxLines: 3,           // 👈 optional, visible lines count
                                      ),

                                      const Text(
                                        AppText.state,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.grey2,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Obx((){
                                        if (leadDDController.isStateLoading.value) {
                                          return  Center(child:CustomSkelton.leadShimmerList(context));
                                        }
                                        return CustomDropdown<Data>(
                                          items: leadDDController.getAllStateModel.value?.data ?? [],
                                          getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                          getName: (item) => item.stateName.toString(),
                                          selectedValue: leadDDController.getAllStateModel.value?.data?.firstWhereOrNull(
                                                (item) => item.id.toString() == leadDDController.selectedState.value,
                                          ),
                                          onChanged: (value) {
                                            leadDDController.selectedState.value =  value?.id?.toString();
                                            leadDDController.getDistrictByStateIdApi(stateId: leadDDController.selectedState.value);
                                          },
                                        );
                                      }),
                                      const SizedBox(height: 20),
                                      const Text(
                                        AppText.district,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.grey2,
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      Obx((){
                                        if (leadDDController.isDistrictLoading.value) {
                                          return  Center(child:CustomSkelton.leadShimmerList(context));
                                        }

                                        return CustomDropdown<dist.Data>(
                                          items: leadDDController.getDistrictByStateModel.value?.data ?? [],
                                          getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                          getName: (item) => item.districtName.toString(),
                                          selectedValue: leadDDController.getDistrictByStateModel.value?.data?.firstWhereOrNull(
                                                (item) => item.id.toString() == leadDDController.selectedDistrict.value,
                                          ),
                                          onChanged: (value) {
                                            leadDDController.selectedDistrict.value =  value?.id?.toString();
                                            leadDDController.getCityByDistrictIdApi(districtId: leadDDController.selectedDistrict.value);
                                          },
                                        );
                                      }),
                                      const SizedBox(height: 20),
                                      const Text(
                                        AppText.city,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.grey2,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Obx((){
                                        if (leadDDController.isCityLoading.value) {
                                          return  Center(child:CustomSkelton.leadShimmerList(context));
                                        }
                                        return CustomDropdown<city.Data>(
                                          items: leadDDController.getCityByDistrictIdModel.value?.data ?? [],
                                          getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                          getName: (item) => item.cityName.toString(),
                                          selectedValue: leadDDController.getCityByDistrictIdModel.value?.data?.firstWhereOrNull(
                                                (item) => item.id.toString() == leadDDController.selectedCity.value,
                                          ),
                                          onChanged: (value) {
                                            leadDDController.selectedCity.value =  value?.id?.toString();
                                          },
                                        );
                                      }),
                                      const SizedBox(height: 10),

                                      CustomLabeledTextField(
                                        label: AppText.pinCode,
                                        isRequired: true,
                                        maxLength: 6,
                                        controller: profileController.postalCodeController,
                                        inputType: TextInputType.number,
                                        hintText: AppText.enterPinCode,
                                        validator: ValidationHelper.validatePostalCode,
                                      ),

                                      const SizedBox(height: 20),
                                      const Row(
                                        children: [
                                           Text(
                                            AppText.uploadEmployeeImage,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.grey2,
                                            ),
                                          ),
                                          Text(
                                            " *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.redColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Obx(() => Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.black1,),
                                          borderRadius: BorderRadius.circular(4.0),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                await uploadCommonTaskController.pickFiles(allowMultiple: true);
                                              },
                                           //   onTap: uploadCommonTaskController.pickImageFile,
                                              child: Container(
                                                height: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(color: AppColor.black1),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    AppText.chooseFile,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColor.black1,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                uploadCommonTaskController.selectedFileName.value.isEmpty?'No file Choosen':
                                                uploadCommonTaskController.selectedFileName.value,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black87,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      const SizedBox(height: 20),
                                      CustomLabeledTextField(
                                        label: AppText.EmployeeadharNo,
                                        isRequired: true,
                                        controller: profileController.adharCardController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterEmployeeadharNo,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.addressEmployeeadharNo,
                                        isRequired: true,
                                        controller: profileController.addressAdharCardController,
                                        inputType: TextInputType.multiline, // 👈 allows multi-line text
                                        hintText: AppText.enterAddressEmployeeadharNo,
                                        validator: ValidationHelper.validateDescription,
                                        isInputEnabled: false, // 👈 field disabled (read-only)
                                        isTextArea: true,      // 👈 enables multi-line mode
                                     //   maxLines: 3,           // 👈 optional, visible lines count
                                      ),

                                  /*    Align(
                                        alignment: AlignmentDirectional.topEnd,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width*0.44,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColor.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                            //  Get.dialog(AadhaarVerificationDialog());

                                            }, child: const Text(
                                            AppText.adharVarify,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          ),
                                        ),
                                      ),*/
                                      const SizedBox(height: 10),
                                      Obx(() {
                                        if (profileController.isLoading.value) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return Align(
                                            alignment: Alignment.bottomRight, // ✅ Move button to right side
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 20, bottom: 20), // spacing
                                              child: SizedBox(
                                                width: Get.width * 0.5, // ✅ half of the screen width
                                                height: 50,
                                                child: CustomElevatedButton(
                                                  text: AppText.submit,
                                                  color: AppColor.primaryColor,
                                                  onPressed: () {
                                                    profileController.editEmployeeDetailRequest();
                                                  },
                                                  textStyle: const TextStyle(
                                                    color: AppColor.appWhite,
                                                    fontSize: AppFSize.mediumFont,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                      const SizedBox(height: 10),

                                    ],
                                  ),


                                ],
                              ),
                              const SizedBox(height: 10),
                               ExpansionTile(
                                initiallyExpanded: false,
                                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                                title:Text( AppText.Academics, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                                leading: Icon(Icons.list_alt, size: 20,),
                                children: [
                                  Column(
                                  children: [
                                  leadSection(context)

                                  ],
                              )
                                 // leadSection(context);


/*
                                  Obx(() => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                        profileController.acadmicsFormApplList.length,
                                            (index) {
                                          final academicFormController = profileController.acadmicsFormApplList[index];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabeledTextField(
                                            label: AppText.qualification,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: academicFormController.qualificationController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.qualification,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.Specialization,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: academicFormController.specializationController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.Specialization,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.InstitutionName,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: academicFormController.institutionNameController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.InstitutionName,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.UniversityName,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: academicFormController.universityNameController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.UniversityName,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.YearofPassing,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: academicFormController.yearOfPassingController,
                                            inputType: TextInputType.number,
                                            hintText: AppText.YearofPassing,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.GradePercentage,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: academicFormController.gradeOrPercentageController,
                                            inputType: TextInputType.text,
                                            hintText: AppText.GradePercentage,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.EducationType,
                                            isRequired: false,
                                            isInputEnabled: false,
                                            controller: academicFormController.educationtypeController,
                                            inputType: TextInputType.text,
                                            hintText: AppText.EducationType,
                                            validator: ValidationHelper.validateDescription,
                                          ),

                                          // Upload file
                                          const Text(AppText.UploadDoc,
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.grey2)),
                                          const Text('Only PDF files. Max 2 MB',
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColor.grey2)),
                                          const SizedBox(height: 5),
                                          Obx(() => Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColor.black1),
                                              borderRadius: BorderRadius.circular(4.0),
                                              color: Colors.grey.shade100,
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                //  onTap: uploadCommonTaskController.pickImageFile,
                                                  onTap: () async {
                                                    await uploadCommonTaskController.pickFiles(allowMultiple: true);
                                                  },
                                                  child: Container(
                                                    height: double.infinity,
                                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                                    decoration: const BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(color: AppColor.black1),
                                                      ),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        AppText.chooseFile,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: AppColor.black1,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    uploadCommonTaskController.selectedFileName.value,
                                                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                          const SizedBox(height: 10),
                                          // const Divider(thickness: 1, color: Colors.grey),
                                        ],
                                      );
                                    }),

                                  )),*/

                                ],
                              ),
                              SizedBox(height: 10,),
                              ExpansionTile(
                                initiallyExpanded: false,
                                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                                title:const Text( AppText.workExperience, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                                leading: Icon(Icons.list_alt, size: 20,),
                                children: [
                                  Column(
                                    children: [
                                      leadSection2(context)
                                    ],
                                  )
/*
                                  Obx(() => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(profileController.employmentFormList.length, (index) {
                                      final employment = profileController.employmentFormList[index];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabeledTextField(
                                            label: AppText.companyName,
                                            controller: employment.companyNameController,
                                            inputType: TextInputType.name,
                                            isInputEnabled: false,
                                            hintText: AppText.enterCompanyName,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.jobTitle,
                                            controller: employment.jobTitleController,
                                            inputType: TextInputType.name,
                                            isInputEnabled: false,
                                            hintText: AppText.enterJobTitle,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.department,
                                            controller: employment.departmentController,
                                            inputType: TextInputType.name,
                                            isInputEnabled: false,
                                            hintText: AppText.enterDepartment,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledPickerTextField(
                                            label: AppText.startDate,
                                            controller: employment.startDateController,
                                            inputType: TextInputType.datetime,
                                           // isInputEnabled: false,
                                            hintText: AppText.mmddyyyy,
                                            isDateField: true,
                                            validator: ValidationHelper.validateFromDate,
                                          ),
                                          CustomLabeledPickerTextField(
                                            label: AppText.endDate,
                                            controller: employment.endDateController,
                                            inputType: TextInputType.datetime,
                                            hintText: AppText.mmddyyyy,
                                            isDateField: true,
                                          //  isInputEnabled: false,
                                            validator: ValidationHelper.validateToDateNew,
                                          ),

                                          CustomLabeledTextField(
                                            label: AppText.employmentType,
                                            controller: employment.employmentTypeController,
                                            inputType: TextInputType.text,
                                            isInputEnabled: false,
                                            hintText: AppText.employmentType,
                                            validator: ValidationHelper.validateDescription,
                                          ),

                                          CustomLabeledTextField(
                                            label: AppText.companyAddress,
                                            controller: employment.companyAddressController,
                                            inputType: TextInputType.text,
                                            isInputEnabled: false,
                                            hintText: AppText.enterCompanyAddress,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.reasonForLeaving,
                                            controller: employment.reasonForLeavingController,
                                            inputType: TextInputType.text,
                                            isInputEnabled: false,
                                            hintText: AppText.enterReasonForLeaving,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.lastDrawnSalary,
                                            controller: employment.lastDrawnSalaryController,
                                            inputType: TextInputType.number,
                                            isInputEnabled: false,
                                            hintText: AppText.enterLastDrawnSalary,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.responsibilities,
                                            controller: employment.responsibilitiesController,
                                            inputType: TextInputType.text,
                                            isInputEnabled: false,
                                            hintText: AppText.enterResponsibilities,
                                            validator: ValidationHelper.validateDescription,
                                          ),

                                          const SizedBox(height: 10),

                                          // Add / Remove Buttons
                                        */
/*  Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              if (index == profileController.employmentFormList.length - 1)
                                                IconButton(
                                                  onPressed: () => profileController.addEmploymentDetail(),
                                                  icon: Container(
                                                    padding: const EdgeInsets.all(10),
                                                    decoration: const BoxDecoration(
                                                      color: AppColor.primaryColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                    child: const Icon(Icons.add, color: Colors.white),
                                                  ),
                                                ),
                                              IconButton(
                                                onPressed: () => profileController.removeEmploymentDetail(index),
                                                icon: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: profileController.employmentFormList.length <= 1
                                                        ? AppColor.lightRed
                                                        : AppColor.redColor,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: const Icon(Icons.remove, color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const Divider(thickness: 1, color: Colors.grey),
                                        ],
                                      );
                                    }),
                                  ))
*/
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }

  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8), // for ripple effect
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12), // optional internal padding
              alignment: Alignment.center,
              child: Image.asset(
                AppImage.arrowLeft,
                height: 24,
              ),
            ),
          ),

          const Text(
            AppText.myProfile,
            style: TextStyle(
                fontSize: 20,
                color: AppColor.grey3,
                fontWeight: FontWeight.w700
            ),
          ),

          InkWell(
            onTap: (){

            },
            child: Container(
              width: 40,
              height:40,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration:  const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label, String value) {
    return Row(
      children: [
        Radio<String>(
          value: value, // ✅ actual stored value ("M", "F", "O")
          groupValue: profileController.selectedGender.value,
          onChanged: (val) {
            profileController.selectedGender.value = val!;
          },
        ),
        Text(label), // ✅ displayed text ("Male", "Female", "Other")
      ],
    );
  }

  Widget leadSection(BuildContext context) {
    return Obx(() {
      if (profileController.isLoading.value) {
        return Center(child: CustomSkelton.productShimmerList(context));
      }

      final model = profileController.getEducationDetailModel.value;

      if (model!.data!.isEmpty) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.50,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey200),
            color: AppColor.appWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: const Center(
            child: Text(
              "No data found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.grey700,
              ),
            ),
          ),
        );
      }

      final dataList = model.data;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList!.length,
        itemBuilder: (context, index) {
          final data = dataList[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Basic Info
              /// Basic Info
              buildCard("${index + 1}", [
                DetailRow(label: "ID", value: data.id?.toString() ?? AppText.customdash),
                DetailRow(label: "Qualification", value: data.qualification?.toString() ?? AppText.customdash),
                DetailRow(label: "Specialization", value: data.specialization?.toString() ?? AppText.customdash),
                DetailRow(label: "Institution Name", value: data.institutionName?.toString() ?? AppText.customdash),
                DetailRow(label: "University Name", value: data.universityName?.toString() ?? AppText.customdash),
                DetailRow(label: "Year of Passing", value: data.yearOfPassing?.toString() ?? AppText.customdash),
                DetailRow(label: "Grade/Percentage", value: data.gradeOrPercentage?.toString() ?? AppText.customdash),
                DetailRow(label: "Education Type", value: data.educationType?.toString() ?? AppText.customdash),
                DetailRow(label: "Unique Lead Number", value: data.universityName?.toString() ?? AppText.customdash),
             //   DetailRow(label: "Date", value: data.date?.toString() ?? AppText.customdash),
             //   DetailRow(label: "Amount", value: data.amount?.toString() ?? AppText.customdash),
             //   DetailRow(label: "Actual Date", value: data.actualDate?.toString() ?? AppText.customdash),
            //    DetailRow(label: "Actual Amount", value: data.actualAmount?.toString() ?? AppText.customdash),
            //    DetailRow(label: "Transaction Details", value: data.transactionDetails?.toString() ?? AppText.customdash),
           //     DetailRow(label: "Disbursed By", value: data.disbursedBy?.toString() ?? AppText.customdash),
            //    DetailRow(label: "Contact No", value: data.contactNo?.toString() ?? AppText.customdash),
             //   DetailRow(label: "Loan Account No", value: data.loanAccountNo?.toString() ?? AppText.customdash),
             //   DetailRow(label: "Invoice Date", value: data.invoiceDate?.toString() ?? AppText.customdash),
             //   DetailRow(label: "Receipt Date", value: data.receiptDate?.toString() ?? AppText.customdash),
            //  ], Icons.numbers),

            ], Icons.numbers),


              const SizedBox(height: 0),

            ],
          );
        },
      );
    });
  }
  Widget buildCard(String title, List<Widget> children, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: Border.all(color: AppColor.grey4, width: 1),


      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColor.primaryColor, // Blue background
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white,),
                SizedBox(width: 5,),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

 Widget leadSection2(BuildContext context) {
   return Obx(() {
     if (profileController.isLoading.value) {
       return Center(child: CustomSkelton.productShimmerList(context));
     }

     final model = profileController.getProfessionalDetailModel.value;

     if (model!.data!.isEmpty) {
       return Container(
         height: MediaQuery.of(context).size.height * 0.50,
         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
         margin: const EdgeInsets.symmetric(vertical: 10),
         decoration: BoxDecoration(
           border: Border.all(color: AppColor.grey200),
           color: AppColor.appWhite,
           borderRadius: const BorderRadius.all(Radius.circular(10)),
         ),
         child: const Center(
           child: Text(
             "No data found",
             style: TextStyle(
               fontSize: 16,
               fontWeight: FontWeight.bold,
               color: AppColor.grey700,
             ),
           ),
         ),
       );
     }

     final dataList = model.data;

     return ListView.builder(
       shrinkWrap: true,
       physics: const NeverScrollableScrollPhysics(),
       itemCount: dataList!.length,
       itemBuilder: (context, index) {
         final data = dataList[index];

         return Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             buildCard("${index + 1}", [
               DetailRow(label: "ID", value: data.id?.toString() ?? AppText.customdash),
               DetailRow(label: "Employee ID", value: data.employeeId?.toString() ?? AppText.customdash),
               DetailRow(label: "Company Name", value: data.companyName ?? AppText.customdash),
               DetailRow(label: "Job Title", value: data.jobTitle ?? AppText.customdash),
               DetailRow(label: "Department", value: data.department ?? AppText.customdash),
               DetailRow(label: "Start Date", value: formatDate(data.startDate)),
               DetailRow(label: "End Date", value: formatDate(data.endDate)),
               DetailRow(label: "Employment Type", value: data.employmentType ?? AppText.customdash),
               DetailRow(label: "Company Address", value: data.companyAddress ?? AppText.customdash),
               DetailRow(label: "Responsibilities", value: data.responsibilities ?? AppText.customdash),
               DetailRow(label: "Last Drawn Salary", value: data.lastDrawnSalary?.toString() ?? AppText.customdash),
               DetailRow(label: "Reason For Leaving", value: data.reasonForLeaving ?? AppText.customdash),
               DetailRow(label: "Documents", value: data.documents ?? AppText.customdash),
              // DetailRow(label: "Approved By HR", value: data.approvedByHR ?? AppText.customdash),
               DetailRow(label: "Is Fresher", value: (data.isFresher == 1) ? "Yes" : "No"),

             ], Icons.numbers),


             const SizedBox(height: 0),

           ],
         );
       },
     );
   });

 }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return AppText.customdash;
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      return date; // return as-is if parsing fails
    }
  }

}
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: AppColor.primaryColor
            ),
          ),
          const SizedBox(height: 4),
          value=="null" || value==AppText.customdash?
          Row(


            children: [
              Icon(Icons.horizontal_rule, size: 15,),
            ],):
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Widget for Icon Buttons
class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  IconButtonWidget({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
        height: 27,
        width: 27,
        // color: color.withOpacity(0.2),
        decoration: BoxDecoration(

        ),
        child: Center(child: Icon(icon, color: color,size: 16,)),
      ),
    );
  }
}




/*
class AadhaarVerificationDialog extends StatelessWidget {
  final TextEditingController captchaController = TextEditingController();
  final RxString captchaImage = ''.obs; // holds captcha base64
  final RxString captchaTxnId = ''.obs; // holds captcha txn id from API

  AadhaarVerificationDialog({super.key});

  // Simulated API: Generate captcha
  Future<void> generateCaptcha() async {
    // TODO: Replace with your Aadhaar API call
    // Example API Response: { "captchaBase64": "...", "captchaTxnId": "12345" }

    // Mock captcha response
    const mockBase64 =
        "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAQAAACoWZ8PAAAADElEQVR42mNkYGBgAAAABAABJzQnCgAAAABJRU5ErkJggg==";
    captchaImage.value = mockBase64;
    captchaTxnId.value = "txn123456"; // example txn id
  }

  // Simulated API: Validate Captcha + Send OTP
  Future<void> validateCaptchaAndSendOtp(String captchaValue) async {
    // TODO: Replace with actual Aadhaar OTP API
    // Request: { aadhaarNo, captchaTxnId, captchaValue }
    // Response: { success: true/false, message: "..." }

    if (captchaValue == "12345") {
      // ✅ Suppose correct captcha
      Get.snackbar("Success", "Captcha valid. OTP sent to your Aadhaar-linked mobile!");
    } else {
      // ❌ Invalid captcha
      Get.snackbar("Error", "Invalid captcha. Please try again.");
      generateCaptcha(); // Refresh captcha after failure
      captchaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (captchaImage.value.isEmpty) {
      generateCaptcha(); // Load first captcha
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Aadhaar Verification Process",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Captcha + Refresh
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  if (captchaImage.value.isEmpty) {
                    return const SizedBox(height: 50, width: 120);
                  }
                  return Image.memory(
                    base64Decode(captchaImage.value),
                    width: 120,
                    height: 50,
                    fit: BoxFit.fill,
                  );
                }),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: generateCaptcha,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Captcha Input
            TextField(
              controller: captchaController,
              decoration: const InputDecoration(
                labelText: "Enter Captcha Code",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Send OTP
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  if (captchaController.text.isEmpty) {
                    Get.snackbar("Error", "Please enter captcha");
                    return;
                  }
                  validateCaptchaAndSendOtp(captchaController.text);
                },
                child: const Text("Send OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
*/

