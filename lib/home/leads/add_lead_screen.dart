
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksdpl/controllers/leads/income_step_controller.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import '../../controllers/camnote/camnote_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomLabeledTextField2.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/storage_service.dart';
import '../../common/validation_helper.dart';
import '../../controllers/bot_nav_controller.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import '../custom_drawer.dart';


class AddLeadScreen extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  // Addleadcontroller addleadcontroller=Get.put(Addleadcontroller(),permanent: false);
  final Addleadcontroller addleadcontroller=Get.find();
  final addProductController = Get.find<AddProductController>();

  IncomeStepController incomeStepController = Get.put(IncomeStepController());
  final CamNoteController camNoteController =Get.put(CamNoteController());
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key:_scaffoldKey,
        backgroundColor: AppColor.backgroundColor,
        drawer:   CustomDrawer(),
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
                        child: Obx((){
                          if (addleadcontroller.isLoading.value) {
                            return  Center(child: CustomSkelton.productShimmerList(context));
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min, // Prevents extra spacing
                            children: [
                              const SizedBox(
                                height: 10,
                              ),

                              CustomLabeledTextField(
                                label: AppText.fullName,
                                isRequired: true,
                                controller: addleadcontroller.fullNameController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterFullName,
                                validator:  ValidationHelper.validateName,
                              ),

                              CustomLabeledPickerTextField(
                                label: AppText.dateOfBirth,

                                controller: addleadcontroller.dobController,
                                inputType: TextInputType.name,
                                hintText: AppText.mmddyyyy,

                                isDateField: true,
                                isFutureDisabled: true,
                              ),

                              CustomLabeledTextField2(
                                isInputEnabled: true,
                                label: AppText.phoneNumberNoStar,
                                isRequired: true,
                                controller: addleadcontroller.phoneController,
                                inputType: TextInputType.phone,
                                hintText: AppText.enterPhNumber,
                                validator: ValidationHelper.validatePhoneNumber,
                                maxLength: 10,
                                onChanged: (value) {
                                  if (value.length == 10) {
                                    camNoteController.getLeadDetailByCustomerNumberApi(value);
                                  }
                                },
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


                              CustomLabeledTextField(
                                label: AppText.lar,
                                isRequired: true,
                                controller: addleadcontroller.loanAmtReqController,
                                inputType: TextInputType.phone,
                                hintText: AppText.enterLar,
                                validator: ValidationHelper.validateLoanAmt,
                              ),

                              CustomLabeledTextField(
                                label: AppText.eml,
                                isRequired: false,
                                controller: addleadcontroller.emailController,
                                inputType: TextInputType.emailAddress,
                                hintText: AppText.enterEA,
                                validator: ValidationHelper.validateEmailWithoutRequired,
                              ),

                              CustomLabeledTextField(
                                label: AppText.aadhar,
                                isRequired: false,
                                controller: addleadcontroller.aadharController ,
                                inputType: TextInputType.phone,
                                hintText: AppText.enterAadhar,
                                maxLength: 12,
                                isSecret: true,
                                secretDigit: 4,
                              ),

                              CustomLabeledTextField(
                                label: AppText.panNumber,
                                isRequired: false,
                                controller: addleadcontroller.panController ,
                                inputType: TextInputType.name,
                                hintText: AppText.enterPan,
                                validator: ValidationHelper.validatePanCard,
                                maxLength: 10,
                                isCapital: true,

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

                              CustomLabeledTextField(
                                label: AppText.zipCode,
                                isRequired: false,
                                controller: addleadcontroller.zipController ,
                                inputType: TextInputType.number,
                                hintText: AppText.enterZipCode,
                                maxLength: 6,
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


                              CustomTextLabel(
                                label: AppText.productSegment,


                              ),

                              const SizedBox(height: 10),


                              Obx((){
                                if (addleadcontroller.isLoadingProductSegment.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
                                }

                                return CustomDropdown<productCat.Data>(
                                  items: addProductController.productCategoryList  ?? [],
                                  getId: (item) => item.id.toString(),  // Adjust based on your model structure
                                  getName: (item) => item.productCategoryName.toString(),
                                  selectedValue: addProductController.productCategoryList.firstWhereOrNull(
                                        (item) => item.id == addleadcontroller.selectedProdSegment.value,
                                  ),
                                  onChanged: (value) {
                                    addleadcontroller.selectedProdSegment.value =  value?.id;
                                  },
                                  onClear: (){
                                    addleadcontroller.selectedProdSegment.value = 0;
                                    addProductController.productCategoryList.clear(); // reset dependent dropdown

                                  },
                                );
                              }),

                              SizedBox(height: 20,),

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
                                if (leadDDController.isBankLoading.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
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
                                   // leadDDController.getProductListByBankIdApi(bankId: leadDDController.selectedBank.value);
                                  },
                                );
                              }),

                              const SizedBox(height: 20),

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
                                if (leadDDController.isProductLoading.value) {
                                  return  Center(child:CustomSkelton.leadShimmerList(context));
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
                                controller: addleadcontroller.branchLocController,
                                inputType: TextInputType.name,
                                hintText: AppText.enterBrLoc,
                                validator: ValidationHelper.validateBrLoc,
                              ),



                              const SizedBox(height: 20),

                              if(addleadcontroller.fromWhere.value!="interested")
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    const Text(
                                      AppText.existingLoans,
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
                                          value: addleadcontroller.selectedIndexExistingLoan.value == index,
                                          onChanged: (value) => addleadcontroller.selectCheckboxExistingLoan(index),
                                        );
                                      }).toList(),
                                    )),

                                    const SizedBox(height: 20),

                                    const SizedBox(height: 20),

                                    CustomLabeledTextField(
                                      label: AppText.noOfExistingLoans,
                                      isRequired: false,
                                      controller: addleadcontroller.noOfExistingLoansController ,
                                      inputType: TextInputType.number,
                                      hintText: AppText.enterNoOfExistingLoans,
                                      validator: ValidationHelper.validateNoExLoan,
                                    ),

                                    const SizedBox(height: 10),
                                  ],
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              Helper.customDivider(color: Colors.grey),
                              SizedBox(height: 10,),
                              CustomTextLabel(
                                label: AppText.addIncome,
                              ),

                              Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(addleadcontroller.addIncomeList.length, (index) {
                                  final ai = addleadcontroller.addIncomeList[index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabeledTextField(
                                            label: AppText.source,
                                            isRequired: false,
                                            controller: ai.aiSourceController,
                                            inputType: TextInputType.name,
                                            hintText: AppText.enterSource,
                                          ),
                                          CustomLabeledTextField(
                                            label: AppText.income,
                                            isRequired: false,
                                            controller: ai.aiIncomeController,
                                            inputType: TextInputType.number,
                                            hintText: AppText.enterIncome,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,

                                        children: [
                                          index== addleadcontroller.addIncomeList.length-1?
                                          Obx((){
                                            if(addleadcontroller.isLoading.value){
                                              return const Align(
                                                alignment: Alignment.centerRight,
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: CircularProgressIndicator(
                                                    color: AppColor.primaryColor,
                                                  ),
                                                ),
                                              );
                                            }
                                            return Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                  onPressed: (){
                                                    addleadcontroller.addAdditionalSrcIncome();
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
                                            return Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                  onPressed: addleadcontroller.addIncomeList.length <= 1?(){}: (){
                                                    addleadcontroller.removeAdditionalSrcIncome(index);
                                                  },
                                                  icon: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                        color: addleadcontroller.addIncomeList.length <= 1?AppColor.lightRed: AppColor.redColor,
                                                      ),
                                                      padding: EdgeInsets.all(10),
                                                      child: Icon(Icons.remove, color: AppColor.appWhite,)
                                                  )
                                              ),
                                            );
                                          })
                                        ],
                                      )
                                    ],
                                  );
                                }),
                              )),
                              SizedBox(height: 10,),
                              Helper.customDivider(color: Colors.grey),
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
                                          validator: ValidationHelper.validatePhoneNumber,
                                          maxLength: 10,
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

                              Obx((){
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
                                return SizedBox(
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
                                );
                              })
                            ],
                          );
                        }),
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

         // addleadcontroller.fromWhere.value=="drawer" ||addleadcontroller.fromWhere.value=="leadList" ||  addleadcontroller.fromWhere.value=="interested"?
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
     /*     InkWell(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(AppImage.drawerIcon)),*/

          const Text(
            AppText.addLead,
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
          groupValue: addleadcontroller.selectedGender.value,
          onChanged: (value) {
            addleadcontroller.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }

  void onPressed(){
    print("onpressed===>");

    if (_formKey.currentState!.validate()) {
      print("onpressed===>2");
      if (addleadcontroller.selectedGender.value==null) {
        ToastMessage.msg("Please select gender");
      }else if(camNoteController.isaddedMobileNumber.value == true){
        SnackbarHelper.showSnackbar(title: "Incomplete Step 1", message: "This Number already added ");
        return;
      }else {
        if(addleadcontroller.fromWhere.value=="interested"){

          addleadcontroller.fillLeadFormApi(
            id: addleadcontroller.getLeadId.value.toString(),

            dob:  addleadcontroller.dobController.text.toString(),

            gender:  addleadcontroller.selectedGender.toString(),
            loanAmtReq:  addleadcontroller.loanAmtReqController.text.toString(),
            email:  addleadcontroller.emailController.text.toString(),
            aadhar:  addleadcontroller.aadharController.text.toString(),
            pan:  addleadcontroller.panController.text.toString(),
            streetAdd:  addleadcontroller.streetAddController.text.toString(),
            state:  leadDDController.selectedState.value==null?"0":leadDDController.selectedState.value.toString(),
            district: leadDDController.selectedDistrict.value==null?"0":leadDDController.selectedDistrict.value.toString(),
            city: leadDDController.selectedCity.value==null?"0":leadDDController.selectedCity.value.toString(),
            zip: addleadcontroller.zipController.text.toString(),
            nationality: addleadcontroller.nationalityController.text.toString(),
            currEmpSt: leadDDController.currEmpStatus.value??"",
            employerName: addleadcontroller.employerNameController.text.toString(),
            ///Now this is not working, Have different API for Additional source of income
            monthlyIncome: addleadcontroller.monthlyIncomeController.text.toString(),
            addSrcIncome: addleadcontroller.addSourceIncomeController.text.toString(),
            prefBank: leadDDController.selectedBank.value.toString(),
            exRelBank:addleadcontroller.selectedIndexRelBank.value==-1?"":addleadcontroller.selectedIndexRelBank.value==0?"Yes":"No",
            branchLoc:addleadcontroller.branchLocController.text.toString(),
            prodTypeInt: leadDDController.selectedProdType.value.toString(),
            connName: addleadcontroller.connNameController.text.toString(),
            connMob: addleadcontroller.connMobController.text.toString(),
            connShare: addleadcontroller.connShareController.text.toString(),
            loanApplNo: "",
          ).then((_){
            Get.back();
          });
        }else{
          print("inside else==.");
          var empId=StorageService.get(StorageService.EMPLOYEE_ID).toString();
          addleadcontroller.individualLeadUploadApi(

            name: addleadcontroller.fullNameController.text.toString(),
            createdBy: empId.toString(),
            mobileNo:  addleadcontroller.phoneController.text.toString(),
            dob:  addleadcontroller.dobController.text.toString(),
            gender:  addleadcontroller.selectedGender.toString(),
            loanAmtReq:  addleadcontroller.loanAmtReqController.text.toString(),
            email:  addleadcontroller.emailController.text.toString(),
            aadhar:  addleadcontroller.aadharController.text.toString(),
            pan:  addleadcontroller.panController.text.toString(),
            streetAdd:  addleadcontroller.streetAddController.text.toString(),
            state:  leadDDController.selectedState.value==null?"0":leadDDController.selectedState.value.toString(),
            district: leadDDController.selectedDistrict.value==null?"0":leadDDController.selectedDistrict.value.toString(),
            city: leadDDController.selectedCity.value==null?"0":leadDDController.selectedCity.value.toString(),
            zip: addleadcontroller.zipController.text.toString(),
            nationality: addleadcontroller.nationalityController.text.toString(),
            currEmpSt:  leadDDController.currEmpStatus.value??"",
            employerName: addleadcontroller.employerNameController.text.toString(),
            monthlyIncome: addleadcontroller.monthlyIncomeController.text.toString(),
            ///Now this is not working, Have different API for Additional source of income
            addSrcIncome: addleadcontroller.addSourceIncomeController.text.toString(),
            prefBank: leadDDController.selectedBank.toString(),
            exRelBank:addleadcontroller.selectedIndexRelBank.value==-1?"":addleadcontroller.selectedIndexRelBank.value==0?"Yes":"No",
            branchLoc:addleadcontroller.branchLocController.text.toString(),
            prodTypeInt:leadDDController.selectedProdType.value.toString(),
            connName: addleadcontroller.connNameController.text.toString(),
            connMob: addleadcontroller.connMobController.text.toString(),
            connShare: addleadcontroller.connShareController.text.toString(),
            existingLoans:addleadcontroller.selectedIndexExistingLoan.value==-1?"":addleadcontroller.selectedIndexExistingLoan.value==0?"Yes":"No",
            noOfExistingLoans: addleadcontroller.noOfExistingLoansController.text.toString(),
            addIncomeListTemp: addleadcontroller.addIncomeList,
            leadSegment: addleadcontroller.selectedProdSegment.value.toString(),
            uniqueLeadNumber: "",

          ).then((_){
            print("hello====1");
            /*print("addleadcontroller.fromWhere.value===>${addleadcontroller.fromWhere.value}");
            if(addleadcontroller.fromWhere.value=="drawer"){

              print("hello====2");
              BotNavController botNavController=Get.put(BotNavController());
              print("hello====3");
              botNavController.selectedIndex.value = 1;
              print("hello====4");
              Get.offAllNamed("/bottomNavbar");

            }*/
            print("hello====2");
            BotNavController botNavController=Get.put(BotNavController());
            print("hello====3");
            botNavController.selectedIndex.value = 1;
            print("hello====4");
            Get.offAllNamed("/bottomNavbar");
          });
        }

      }
    }
  }


}


