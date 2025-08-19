import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;



class ProfileScreen extends StatelessWidget {
  // const ProfileScreen({super.key});

  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  final TextEditingController _searchController = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());
  LeadDDController leadDDController = Get.put(LeadDDController());
  UploadCommonTaskController uploadCommonTaskController=Get.put(UploadCommonTaskController());
  final List<EmploymentType> employmentTypes = [
    EmploymentType(id: "1", name: "Full-Time"),
    EmploymentType(id: "2", name: "Part-Time"),
    EmploymentType(id: "3", name: "Internship"),
    EmploymentType(id: "4", name: "Contract"),
  ];



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

                                      CustomLabeledTextField(
                                        label: AppText.EducationType,
                                        isRequired: false,
                                        controller: profileController.HireDateController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.EducationType,
                                        validator: ValidationHelper.validateDescription,
                                      ),

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
                                        controller: profileController.mobileController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.ManagerName,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.address,
                                        isRequired: true,
                                        controller: profileController.mobileController,
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
                                        controller: profileController.mobileController,
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
                                initiallyExpanded: true,
                                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                                title:const Text( AppText.Academics, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                                leading: Icon(Icons.list_alt, size: 20,),
                                children: [

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomLabeledTextField(
                                        label: AppText.qualification,
                                        isRequired: false,
                                        controller: profileController.employeeNameController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.qualification,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.Specialization,
                                        isRequired: false,
                                        controller: profileController.dateOfBirthController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.Specialization,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.InstitutionName,
                                        isRequired: false,
                                        controller: profileController.profileEmailController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.InstitutionName,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.UniversityName,
                                        isRequired: false,
                                        controller: profileController.phoneNumberController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.UniversityName,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.YearofPassing,
                                        isRequired: false,
                                        controller: profileController.whatsappNoController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.whatsappNoNoStar,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.GradePercentage,
                                        isRequired: false,
                                        controller: profileController.HireDateController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.GradePercentage,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.EducationType,
                                        isRequired: false,
                                        controller: profileController.JobRoleController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.EducationType,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      const Text(
                                        AppText.UploadDoc,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.grey2,
                                        ),
                                      ),const Text(
                                        'Only PDF files. Max 2 MB',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: AppColor.grey2,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
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
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              ExpansionTile(
                                initiallyExpanded: true,
                                childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                                title:const Text( AppText.workExperience, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                                leading: Icon(Icons.list_alt, size: 20,),
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomLabeledTextField(
                                        label: AppText.companyName,
                                        isRequired: false,
                                        controller: profileController.employeeNameController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterCompanyName,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.jobTitle,
                                        isRequired: false,
                                        controller: profileController.dateOfBirthController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterJobTitle,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.department,
                                        isRequired: false,
                                        controller: profileController.profileEmailController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterDepartment,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledPickerTextField(
                                        label: AppText.startDate,

                                        controller: profileController.atStartDateController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.mmddyyyy,
                                        isDateField: true,
                                        validator: ValidationHelper.validateFromDate,
                                        onDateSelected: () {
                                          //     profileController.calculateTotalDays();
                                        },
                                      ),

                                      CustomLabeledPickerTextField(
                                        label: AppText.endDate,
                                        controller: profileController.atEndDateController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.mmddyyyy,
                                        isDateField: true,
                                        validator: ValidationHelper.validateToDateNew,
                                        onDateSelected: () {
                                          //   profileController.calculateTotalDays();
                                        },
                                      ),

                                      CustomDropdown<EmploymentType>(
                                        items: employmentTypes,
                                        getId: (EmploymentType type) => type.id,
                                        getName: (EmploymentType type) => type.name,
                                        hintText: "Select Employment Type",
                                        selectedValue: null, // you can pass a default value here if you want
                                        onChanged: (value) {
                                          if (value != null) {
                                            print("Selected: ${value.id} - ${value.name}");
                                          }
                                        },
                                        onClear: () {
                                          print("Selection cleared");
                                        },
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.employmentType,
                                        isRequired: false,
                                        controller: profileController.whatsappNoController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.whatsappNoNoStar,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.companyAddress,
                                        isRequired: false,
                                        controller: profileController.HireDateController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterCompanyAddress,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.reasonForLeaving,
                                        isRequired: false,
                                        controller: profileController.HireDateController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterReasonForLeaving,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      CustomLabeledTextField(
                                        label: AppText.lastDrawnSalary,
                                        isRequired: false,
                                        controller: profileController.employeeNameController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterLastDrawnSalary,
                                        validator: ValidationHelper.validateDescription,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.responsibilities,
                                        isRequired: false,
                                        controller: profileController.employeeNameController,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterResponsibilities,
                                        validator: ValidationHelper.validateDescription,
                                      ),
                                      const Text(
                                        AppText.UploadDoc,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.grey2,
                                        ),
                                      ),const Text(
                                        'Only PDF files. Max 2 MB',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: AppColor.grey2,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
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
                                      const SizedBox(height: 10),
                                    ],
                                  ),
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

  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: profileController.selectedGender.value,
          onChanged: (value) {
            profileController.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}

class EmploymentType {
  final String id;
  final String name;

  EmploymentType({required this.id, required this.name});
}

class HireDateController {
}
