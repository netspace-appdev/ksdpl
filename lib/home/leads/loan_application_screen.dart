
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetProductListByBank.dart' as productBank;
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../controllers/leads/loan_appl_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';


class LoanApplicationScreen extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  final TextEditingController _searchController = TextEditingController();
  final MultiStepFormController controller = Get.put(MultiStepFormController());

  final _formKey = GlobalKey<FormState>();
  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());/// Remove it
  final LoanApplicationController loanApplicationController =Get.put(LoanApplicationController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

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
                      //height: MediaQuery.of(context).size.height,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                          children: [
                            const SizedBox(
                              height: 10,
                            ),

                            percentBar()  ,

                            const SizedBox(
                              height: 10,
                            ),

                            Helper.customDivider(color: AppColor.grey4),

                            const SizedBox(
                              height: 10,
                            ),

                            ExpansionTile(


                              childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                              title:const Text( AppText.coApplDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                              leading: Icon(Icons.list_alt, size: 20,),
                              children: [

                                const SizedBox(
                                  height: 20,
                                ),

                                CustomLabeledTextField(
                                  label: AppText.fullName,
                                  isRequired: true,
                                  controller: loanApplicationController.fullNameController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterFullName,
                                  validator:  ValidationHelper.validateName,
                                ),

                                CustomLabeledTextField(
                                  label: AppText.fathersName,
                                  isRequired: true,
                                  controller: loanApplicationController.fatherNameController,
                                  inputType: TextInputType.phone,
                                  hintText: AppText.enterFathersName,
                                  validator: ValidationHelper.validatePhoneNumber,
                                ),

                                const SizedBox(height: 10),
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

                                const SizedBox(height: 10),
                                /// Label Row (with * if required)

                                Obx(()=>  Row(
                                  children: [
                                    _buildRadioOption("Male"),
                                    _buildRadioOption("Female"),
                                    _buildRadioOption("Other"),
                                  ],
                                )
                                ),

                                const SizedBox(height: 20),

                                CustomLabeledPickerTextField(
                                  label: AppText.dateOfBirth,
                                  isRequired: true,
                                  controller: loanApplicationController.dobController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.mmddyyyy,
                                  validator: ValidationHelper.validateDob,
                                  isDateField: true,
                                ),

                                CustomLabeledTextField(
                                  label: AppText.qualification,
                                  isRequired: true,
                                  controller: loanApplicationController.qualiController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterQualification,
                                  validator: ValidationHelper.validatePhoneNumber,
                                ),

                                CustomLabeledTextField(
                                  label: AppText.maritalStatus,
                                  isRequired: true,
                                  controller: loanApplicationController.maritalController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterMaritalStatus,
                                  validator: ValidationHelper.validatePhoneNumber,
                                ),

                                CustomLabeledTextField(
                                  label: AppText.employmentStatus,
                                  isRequired: true,
                                  controller: loanApplicationController.emplStatusController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterEmploymentStatus,
                                  validator: ValidationHelper.validatePhoneNumber,
                                ),

                                CustomLabeledTextField(
                                  label: AppText.nationality,
                                  isRequired: true,
                                  controller: loanApplicationController.nationalityController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterNationality,
                                  validator: ValidationHelper.validatePhoneNumber,
                                ),


                                CustomLabeledTextField(
                                  label: AppText.occupation,
                                  isRequired: true,
                                  controller: loanApplicationController.occupationController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterOccupation,
                                  validator: ValidationHelper.validatePhoneNumber,
                                ),

                                CustomLabeledTextField(
                                  label: AppText.occupationSector,
                                  isRequired: true,
                                  controller: loanApplicationController.occupationController,
                                  inputType: TextInputType.name,
                                  hintText: AppText.enterOccupationSector,
                                  validator: ValidationHelper.validatePhoneNumber,
                                ),


                                CustomLabeledTextField(
                                  label: AppText.eml,
                                  isRequired: false,
                                  controller: loanApplicationController.emailController,
                                  inputType: TextInputType.emailAddress,
                                  hintText: AppText.enterEA,
                                  validator: ValidationHelper.validateEmail,
                                ),

                                CustomLabeledTextField(
                                  label: AppText.mobileNumber,
                                  isRequired: true,
                                  controller: loanApplicationController.mobController ,
                                  inputType: TextInputType.phone,
                                  hintText: AppText.enterPhNumber,
                                  validator: ValidationHelper.validatePhoneNumber,

                                ),
                              ],
                            ),

                            
                            CustomLabeledTextField(
                              label: AppText.panNumber,
                              isRequired: false,
                              controller: addleadcontroller.panController ,
                              inputType: TextInputType.name,
                              hintText: AppText.enterPan,

                            ),

                            CustomLabeledTextField(
                              label: AppText.streetAdd,
                              isRequired: false,
                              controller: addleadcontroller.streetAddController ,
                              inputType: TextInputType.name,
                              hintText: AppText.enterStreetAdd,

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
                              if (leadDDController.isLoading.value) {
                                return  Center(child:CustomSkelton.productShimmerList(context));
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
                              if (leadDDController.isLoading.value) {
                                return  Center(child:CustomSkelton.productShimmerList(context));
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
                              if (leadDDController.isLoading.value) {
                                return  Center(child:CustomSkelton.productShimmerList(context));
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

                            CustomLabeledTextField(
                              label: AppText.zipCode,
                              isRequired: false,
                              controller: addleadcontroller.zipController ,
                              inputType: TextInputType.number,
                              hintText: AppText.enterZipCode,

                            ),

                            CustomLabeledTextField(
                              label: AppText.nationality,
                              isRequired: false,
                              controller: addleadcontroller.nationalityController ,
                              inputType: TextInputType.name,
                              hintText: AppText.nationality,
                              validator: ValidationHelper.validateNationality,
                            ),


                            const Text(
                              AppText.currEmpSt,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.grey2,
                              ),
                            ),

                            const SizedBox(height: 10),


                            Obx((){
                              if (leadDDController.isLoading.value) {
                                return  Center(child:CustomSkelton.productShimmerList(context));
                              }


                              return CustomDropdown<String>(
                                items: leadDDController.currEmpStList,
                                getId: (item) => item,  // Adjust based on your model structure
                                getName: (item) => item,
                                selectedValue: leadDDController.currEmpStatus.value,
                                onChanged: (value) {
                                  leadDDController.currEmpStatus.value =  value;
                                },
                              );
                            }),

                            const SizedBox(height: 20),

                            CustomLabeledTextField(
                              label: AppText.employerName,
                              isRequired: false,
                              controller: addleadcontroller.employerNameController ,
                              inputType: TextInputType.name,
                              hintText: AppText.enterEmployerName,
                              validator: ValidationHelper.validateEmpName,
                            ),

                            CustomLabeledTextField(
                              label: AppText.monIncome,
                              isRequired: false,
                              controller: addleadcontroller.monthlyIncomeController ,
                              inputType: TextInputType.number,
                              hintText: AppText.enterMonIncome,

                            ),

                            CustomLabeledTextField(
                              label: AppText.addIncome,
                              isRequired: false,
                              controller: addleadcontroller.addSourceIncomeController ,
                              inputType: TextInputType.name,
                              hintText: AppText.enterAddIncome,
                              validator: ValidationHelper.validateAddSrcInc,
                            ),

                            const Text(
                              AppText.preferredBank,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.grey2,
                              ),
                            ),

                            const SizedBox(height: 10),


                            Obx((){
                              if (leadDDController.isLoading.value) {
                                return  Center(child:CustomSkelton.productShimmerList(context));
                              }


                              return CustomDropdown<bank.Data>(
                                items: leadDDController.getAllBankModel.value?.data ?? [],
                                getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                getName: (item) => item.bankName.toString(),
                                selectedValue: leadDDController.getAllBankModel.value?.data?.firstWhereOrNull(
                                      (item) => item.id.toString() == leadDDController.selectedBank.value,
                                ),
                                onChanged: (value) {

                                  leadDDController.selectedBank.value =  value?.id?.toString();
                                  leadDDController.getProductListByBankIdApi(bankId: leadDDController.selectedBank.value);
                                },
                              );
                            }),

                            const SizedBox(height: 20),

                            const Text(
                              AppText.existingRelationship,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.grey2,
                              ),
                            ),

                            const SizedBox(height: 10),


                            Obx(()=>Column(
                              children: addleadcontroller.optionsRelBank.asMap().entries.map((entry) {
                                int index = entry.key;
                                String option = entry.value;

                                return CheckboxListTile(
                                  activeColor: AppColor.secondaryColor,

                                  title: Text(option),
                                  value: addleadcontroller.selectedIndexRelBank.value == index,
                                  onChanged: (value) => addleadcontroller.selectCheckboxRelBank(index),
                                );
                              }).toList(),
                            )),

                            const SizedBox(height: 20),

                            CustomLabeledTextField(
                              label: AppText.brLoc,
                              isRequired: false,
                              controller: addleadcontroller.branchLocController ,
                              inputType: TextInputType.name,
                              hintText: AppText.enterBrLoc,
                              validator: ValidationHelper.validateBrLoc,
                            ),

                            const Text(
                              AppText.productTypeInt,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.grey2,
                              ),
                            ),

                            const SizedBox(height: 10),


                            Obx((){
                              if (leadDDController.isLoading.value) {
                                return  Center(child:CustomSkelton.productShimmerList(context));
                              }


                              return CustomDropdown<product.Data>(
                                items: leadDDController.getAllKsdplProductModel.value?.data ?? [],
                                getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                getName: (item) => item.productName.toString(),
                                selectedValue: leadDDController.getAllKsdplProductModel.value?.data?.firstWhereOrNull(
                                      (item) => item.id.toString() == leadDDController.selectedProdType.value,
                                ),
                                onChanged: (value) {
                                  leadDDController.selectedProdType.value =  value?.id?.toString();
                                },
                              );
                            }),


                            const SizedBox(height: 20),

                            Obx(() => Column(

                              children: [
                                CheckboxListTile(
                                  activeColor: AppColor.secondaryColor,
                                  title: Text(AppText.connector),
                                  value: addleadcontroller.isConnectorChecked.value,
                                  onChanged: addleadcontroller.toggleConnectorCheckbox,
                                  controlAffinity: ListTileControlAffinity.leading, // Puts checkbox on the left
                                ),
                                if(addleadcontroller.isConnectorChecked.value)
                                  Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      CustomLabeledTextField(
                                        label: AppText.conName,
                                        isRequired: false,
                                        controller: addleadcontroller.connNameController ,
                                        inputType: TextInputType.name,
                                        hintText: AppText.enterConName,
                                        validator: ValidationHelper.validateConnName,
                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.conMob,
                                        isRequired: false,
                                        controller: addleadcontroller.connMobController ,
                                        inputType: TextInputType.number,
                                        hintText: AppText.enterConMob,

                                      ),

                                      CustomLabeledTextField(
                                        label: AppText.conShare,
                                        isRequired: false,
                                        controller: addleadcontroller.connShareController ,
                                        inputType: TextInputType.number,
                                        hintText: AppText.enterConShare,

                                      )

                                    ],
                                  )
                              ],
                            )),

                            SizedBox(height: 20),


Obx(() => Container(
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Previous Button (Hidden on Step 1)
                                  if (controller.currentStep.value > 0)
                                    ElevatedButton(
                                      onPressed: controller.previousStep,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[400],
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                      ),
                                      child: Text("Previous",
                                          style: TextStyle(color: Colors.white)),
                                    )
                                  else
                                    SizedBox(), // Empty space to maintain layout

                                  // Next & Save Button
                                  ElevatedButton(
                                    onPressed: controller.currentStep.value == 5
                                        ? controller.saveForm
                                        : controller.nextStep,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    ),
                                    child: Text(
                                      controller.currentStep.value == 5
                                          ? "Save & Continue"
                                          : "Next",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )),

                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx((){
          if(addleadcontroller.isLoading.value){
            return const Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onPressed,
                child: const Text(
                  AppText.submit,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }),
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
              onTap: (){
                Get.back();
              },
              child: Image.asset(AppImage.arrowLeft,height: 24,)),
          const Text(
            AppText.loanAppl,
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
          groupValue: loanApplicationController.selectedGender.value,
          onChanged: (value) {
            loanApplicationController.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }

  void onPressed(){


    if (_formKey.currentState!.validate()) {

      if (addleadcontroller.selectedGender.value==null) {
        ToastMessage.msg("Please select gender");
      }else {
        ToastMessage.msg("Form Submitted");
      }
    }
  }

  Widget percentBar(){
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: new LinearPercentIndicator(
        //width: MediaQuery.of(context).size.width - 50,
        animation: true,
        lineHeight: 15.0,
        animationDuration: 2500,
        percent: 0.8,
        //center: Text("80.0%"),
        // linearStrokeCap: LinearStrokeCap.roundAll,
        barRadius: Radius.circular(15),
        progressColor:AppColor.greenColor,
      ),
    );
  }
}


class MultiStepFormController extends GetxController {
  var currentStep = 0.obs;

  void nextStep() {
    if (currentStep.value < 5) currentStep.value++;
  }

  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  void saveForm() {
    print("Form Saved!");
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiStepFormController extends GetxController {
  var currentIndex = 0.obs;

  void next() {
    if (currentIndex.value < 6) currentIndex.value++;
  }

  void previous() {
    if (currentIndex.value > 0) currentIndex.value--;
  }

  void setIndex(int index) {
    currentIndex.value = index;
  }
}

class LoanApplicationScreen extends StatelessWidget {
  final MultiStepFormController controller = Get.put(MultiStepFormController());

  final List<String> steps = [
    'Personal Info',
    'Co-Applicant',
    'Property Details',
    'Family',
    'Credit Cards',
    'Financials',
    'References'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: steps.length,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text("Loan Application"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: Obx(() {
              double progress = (controller.currentIndex.value + 1) / steps.length;
              return LinearProgressIndicator(
                value: progress,
                color: Colors.green,
                backgroundColor: Colors.white24,
              );
            }),
          ),
        ),
        body: Column(
          children: [
            // Tab Navigation (Mobile Optimized)
            Container(
              height: 50,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    final selected = controller.currentIndex.value == index;
                    return GestureDetector(
                      onTap: () {
                        controller.setIndex(index);
                        DefaultTabController.of(context).animateTo(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected ? Colors.deepPurple : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.deepPurple),
                        ),
                        child: Center(
                          child: Text(
                            steps[index],
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // Form Body
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: steps.map((step) {
                  return Center(
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$step Form",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 30),
                            const Text("Form fields go here..."),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Navigation Buttons
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (controller.currentIndex.value > 0)
                      ElevatedButton.icon(
                        onPressed: controller.previous,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Previous"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    if (controller.currentIndex.value < steps.length - 1)
                      ElevatedButton.icon(
                        onPressed: controller.next,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text("Next"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}*/
