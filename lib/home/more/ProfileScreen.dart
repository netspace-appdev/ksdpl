import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
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
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;



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
                      height: MediaQuery.of(context).size.height*0.80,
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
                                        controller: profileController.employeeNameController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.employeeName,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.dateOfBirth,
                                        isRequired: false,
                                        controller: profileController.dateOfBirthController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.dateOfBirth,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.emailNoStar,
                                        isRequired: false,
                                        controller: profileController.profileEmailController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterEA,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.phoneNumberNoStar,
                                        isRequired: false,
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

                                    /*  CustomLabeledTextField(
                                        label: AppText.EducationType,
                                        isRequired: false,
                                        controller: profileController.educationTypeController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.EducationType,
                                        validator: ValidationHelper.validateDescription,
                                      ),*/

                                      CustomLabeledTextField(
                                        label: AppText.JobRole,
                                        isRequired: false,
                                        controller: profileController.JobRoleController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.JobRole,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.WorkPlace,
                                        isRequired: true,
                                        controller: profileController.WorkPlaceController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.WorkPlace,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.ManagerName,
                                        isRequired: true,
                                        controller: profileController.managerNameController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.ManagerName,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.address,
                                        isRequired: true,
                                        controller: profileController.addressController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.address,
                                        validator: ValidationHelper.validateDescription,
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
                                      const SizedBox(height: 20),
                                      const Text(
                                        AppText.uploadImage,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.grey2,
                                        ),
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
                                              onTap: uploadCommonTaskController.pickImageFile,
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
                                      Align(
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
                                      ),
                                      const SizedBox(height: 10),

                                    ],
                                  ),


                                ],
                              ),
                              const SizedBox(height: 10),
                              ExpansionTile(
                                initiallyExpanded: false,
                                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                                title:const Text( AppText.Academics, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                                leading: Icon(Icons.list_alt, size: 20,),
                                children: [

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
                                            controller: academicFormController.qualificationController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.qualification,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.Specialization,
                                            isRequired: false,
                                            controller: academicFormController.specializationController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.Specialization,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.InstitutionName,
                                            isRequired: false,
                                            controller: academicFormController.institutionNameController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.InstitutionName,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.UniversityName,
                                            isRequired: false,
                                            controller: academicFormController.universityNameController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.UniversityName,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.YearofPassing,
                                            isRequired: false,
                                            controller: academicFormController.yearOfPassingController,
                                            inputType: TextInputType.number,
                                            hintText: AppText.YearofPassing,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.GradePercentage,
                                            isRequired: false,
                                            controller: academicFormController.gradeOrPercentageController,
                                            inputType: TextInputType.text,
                                            hintText: AppText.GradePercentage,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.EducationType,
                                            isRequired: false,
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
                                                  onTap: uploadCommonTaskController.pickImageFile,
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

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,

                                            children: [
                                              index== profileController.acadmicsFormApplList.length-1?
                                              Obx((){
                                                if(profileController.isLoading.value){
                                                  return const Align(
                                                    alignment: Alignment.centerRight,
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      // child: CircularProgressIndicator(
                                                      //   color: AppColor.primaryColor,
                                                      // ),
                                                    ),
                                                  );
                                                }
                                                return Align(
                                                  alignment: Alignment.centerRight,
                                                  child: IconButton(
                                                      onPressed: (){
                                                        profileController.addFamilyMember();
                                                      },
                                                      icon: Container(
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            color: AppColor.primaryColor,
                                                          ),
                                                          padding: EdgeInsets.all(10),
                                                          child: Icon(Icons.add, color: AppColor.appWhite,)
                                                      )
                                                  ),
                                                );
                                              }):
                                              Container(),

                                              SizedBox(height: 20),

                                              Obx((){
                                                if(profileController.isLoading.value){
                                                  return const Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      // child: CircularProgressIndicator(
                                                      //   color: AppColor.primaryColor,
                                                      // ),
                                                    ),
                                                  );
                                                }
                                                return Align(
                                                  alignment: Alignment.centerRight,
                                                  child: IconButton(
                                                      onPressed: profileController.acadmicsFormApplList.length <= 1?(){}: (){
                                                        profileController.removeAdditionalSrcDocument(index);
                                                      },
                                                      icon: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                            color: profileController.acadmicsFormApplList.length <= 1?AppColor.lightRed: AppColor.redColor,
                                                          ),
                                                          padding: EdgeInsets.all(10),
                                                          child: Icon(Icons.remove, color: AppColor.appWhite,)
                                                      )
                                                  ),
                                                );
                                              }),
                                              //    ),
                                              // Submit button per document

                                            ],
                                          )
                                          // const Divider(thickness: 1, color: Colors.grey),
                                        ],
                                      );
                                    }),

                                  )),

                                ],
                              ),
                              SizedBox(height: 10,),
                              ExpansionTile(
                                initiallyExpanded: false,
                                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                                title:const Text( AppText.workExperience, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                                leading: Icon(Icons.list_alt, size: 20,),
                                children: [
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
                                            hintText: AppText.enterCompanyName,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.jobTitle,
                                            controller: employment.jobTitleController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.enterJobTitle,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.department,
                                            controller: employment.departmentController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.enterDepartment,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledPickerTextField(
                                            label: AppText.startDate,
                                            controller: employment.startDateController,
                                            inputType: TextInputType.datetime,
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
                                            validator: ValidationHelper.validateToDateNew,
                                          ),

                                          CustomLabeledTextField(
                                            label: AppText.employmentType,
                                            controller: employment.employmentTypeController,
                                            inputType: TextInputType.text,
                                            hintText: AppText.employmentType,
                                            validator: ValidationHelper.validateDescription,
                                          ),

                                          CustomLabeledTextField(
                                            label: AppText.companyAddress,
                                            controller: employment.companyAddressController,
                                            inputType: TextInputType.text,
                                            hintText: AppText.enterCompanyAddress,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.reasonForLeaving,
                                            controller: employment.reasonForLeavingController,
                                            inputType: TextInputType.text,
                                            hintText: AppText.enterReasonForLeaving,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.lastDrawnSalary,
                                            controller: employment.lastDrawnSalaryController,
                                            inputType: TextInputType.number,
                                            hintText: AppText.enterLastDrawnSalary,
                                            validator: ValidationHelper.validateDescription,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.responsibilities,
                                            controller: employment.responsibilitiesController,
                                            inputType: TextInputType.text,
                                            hintText: AppText.enterResponsibilities,
                                            validator: ValidationHelper.validateDescription,
                                          ),

                                          const SizedBox(height: 10),

                                          // Add / Remove Buttons
                                          Row(
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
                                ],
                              ),
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
}



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

