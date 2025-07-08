import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/income_step_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllBranchBIModel.dart' as bankBrach;
import '../../custom_widgets/CustomMultiSelectDropdown.dart';
import '../../custom_widgets/CustomTextLabel.dart';
import '../../models/product/GetAllProductCategoryModel.dart' as productCat;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart' as state;
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import '../../models/product/GetAllProductCategoryModel.dart' as productSegment;
import '../../models/camnote/GetAllPackageMasterModel.dart' as pkg;

class Step1CamNote extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  final CamNoteController camNoteController =Get.find();
  Addleadcontroller addleadcontroller = Get.find();
  AddProductController addProductController = Get.find();
  IncomeStepController incomeStepController = Get.put(IncomeStepController());
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Obx((){
        if( camNoteController.isLoadingMainScreen.value)
          return Center(
            child: CustomSkelton.productShimmerList(context),
          );
        return Form(
          key: camNoteController.stepFormKeys[0],
          child: Obx((){
            if (addleadcontroller.isLoading.value) {
              return  Center(child: CustomSkelton.productShimmerList(context));
            }

            print("addIncomeList obx==>${camNoteController.addIncomeList.length}");
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

                  controller: camNoteController.camFullNameController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterFullName,
                  validator:  ValidationHelper.validateName,
                ),

                CustomLabeledPickerTextField(
                  label: AppText.dateOfBirth,
                  isRequired: true,

                  controller: camNoteController.camDobController,
                  inputType: TextInputType.name,
                  hintText: AppText.mmddyyyy,
                  validator: ValidationHelper.validateDob,
                  isDateField: true,
                  isFutureDisabled: true,
                ),

                CustomLabeledTextField(
                  label: AppText.phoneNumberNoStar,
                  isRequired: true,

                  controller: camNoteController.camPhoneController,
                  inputType: TextInputType.phone,
                  hintText: AppText.enterPhNumber,
                  validator: ValidationHelper.validatePhoneNumber,
                  maxLength: 10,

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
                  controller: camNoteController.camLoanAmtReqController,
                  inputType: TextInputType.phone,
                  hintText: AppText.enterLar,
                  validator: ValidationHelper.validateLoanAmt,
                ),

                CustomLabeledTextField(
                  label: AppText.eml,
                  isRequired: false,

                  controller: camNoteController.camEmailController,
                  inputType: TextInputType.emailAddress,
                  hintText: AppText.enterEA,
                  validator: ValidationHelper.validateEmail,
                ),

                CustomLabeledTextField(
                  label: AppText.aadhar,
                  isRequired: false,

                  controller:camNoteController.camAadharController,
                  inputType: TextInputType.phone,
                  hintText: AppText.enterAadhar,
                  maxLength: 12,
                  isSecret: true,
                  secretDigit: 4,

                ),

                CustomLabeledTextField(
                  label: AppText.panNumber,
                  isRequired: false,

                  controller: camNoteController.camPanController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterPan,
                  validator: ValidationHelper.validatePanCard,
                  maxLength: 10,
                  isCapital: true,
                ),

                CustomLabeledTextField(
                  label: AppText.streetAdd,
                  isRequired: false,

                  controller: camNoteController.camStreetAddController,
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

                  return CustomDropdown<state.Data>(
                    items: leadDDController.getAllStateModel.value?.data ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.stateName.toString(),
                    selectedValue: leadDDController.getAllStateModel.value?.data?.firstWhereOrNull(
                          (item) => item.id.toString() == camNoteController.camSelectedState.value,
                    ),
                    onChanged: (value) {
                      camNoteController.camSelectedState.value =  value?.id?.toString();
                      leadDDController.getDistrictByStateIdApi(stateId: camNoteController.camSelectedState.value);
                    },
                    onClear: (){
                      camNoteController.camSelectedDistrict.value = null;
                      leadDDController.districtListCurr.value.clear(); // reset dependent dropdown

                      camNoteController.camSelectedCity.value = null;
                      leadDDController. cityListCurr.value.clear(); // reset dependent dropdown
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
                    items: leadDDController.districtListCurr.value ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.districtName.toString(),
                    selectedValue: leadDDController.districtListCurr.value.firstWhereOrNull(
                          (item) => item.id.toString() == camNoteController.camSelectedDistrict.value,
                    ),
                    onChanged: (value) {
                      camNoteController.camSelectedDistrict.value =  value?.id?.toString();
                      leadDDController.getCityByDistrictIdApi(districtId: camNoteController.camSelectedDistrict.value);
                    },
                    onClear: (){
                      camNoteController.camSelectedDistrict.value = null;
                      leadDDController.districtListCurr.value.clear(); // reset dependent dropdown

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
                    items: leadDDController.cityListCurr.value  ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.cityName.toString(),
                    selectedValue: leadDDController.cityListCurr.value.firstWhereOrNull(
                          (item) => item.id.toString() == camNoteController.camSelectedCity.value,
                    ),
                    onChanged: (value) {
                      camNoteController.camSelectedCity.value=  value?.id?.toString();
                    },
                    onClear: (){
                      camNoteController.camSelectedCity.value = null;
                      leadDDController.cityListCurr.value.clear(); // reset dependent dropdown

                    },
                  );
                }),

                const SizedBox(height: 20),

                CustomLabeledTextField(
                  label: AppText.zipCode,
                  isRequired: false,

                  controller: camNoteController.camZipController ,
                  inputType: TextInputType.number,
                  hintText: AppText.enterZipCode,
                  maxLength: 6,
                ),

                CustomLabeledTextField(
                  label: AppText.nationality,
                  isRequired: false,

                  controller: camNoteController.camNationalityController,
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
                     // selectedValue: leadDDController.currEmpStatus.value,
                    selectedValue: camNoteController.camCurrEmpStatus.value,
                    onChanged: (value) {
                      camNoteController.camCurrEmpStatus.value =  value;
                    },
                  );
                }),

                const SizedBox(height: 20),

                CustomLabeledTextField(
                  label: AppText.employerName,
                  isRequired: false,

                  controller: camNoteController.camEmployerNameController ,
                  inputType: TextInputType.name,
                  hintText: AppText.enterEmployerName,
                  validator: ValidationHelper.validateEmpName,
                ),

                CustomLabeledTextField(
                  label: AppText.monIncome,
                  isRequired: false,

                  controller: camNoteController.camMonthlyIncomeController ,
                  inputType: TextInputType.number,
                  hintText: AppText.enterMonIncome,

                ),

                CustomLabeledTextField(
                  label: AppText.brLoc,
                  isRequired: false,

                  controller: camNoteController.camBranchLocController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterBrLoc,
                  validator: ValidationHelper.validateBrLoc,
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
                  if (leadDDController.isBankLoading.value) {
                    return  Center(child:CustomSkelton.leadShimmerList(context));
                  }


                  return CustomDropdown<bank.Data>(
                    items: leadDDController.getAllBankModel.value?.data ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.bankName.toString(),
                    selectedValue: leadDDController.getAllBankModel.value?.data?.firstWhereOrNull(
                          (item) => item.id.toString() == camNoteController.camSelectedBank.value,
                    ),
                    onChanged: (value) {

                      camNoteController.camSelectedBank.value =  value?.id?.toString();
                     // leadDDController.getProductListByBankIdApi(bankId: camNoteController.camSelectedBank.value);
                    },
                  );
                }),
                SizedBox(height: 30,),


                CustomTextLabel(
                  label: AppText.productSegment,
                  isRequired: true,

                ),

                const SizedBox(height: 10),


                Obx((){
                  if (addProductController.isLoadingProductCategory.value) {
                    return  Center(child:CustomSkelton.leadShimmerList(context));
                  }


                  return CustomDropdown<productSegment.Data>(
                    items: addProductController.productCategoryList  ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.productCategoryName.toString(),
                    selectedValue: addProductController.productCategoryList.firstWhereOrNull(
                          (item) => item.id == camNoteController.camSelectedProdSegment.value,
                    ),
                    onChanged: (value) {
                      camNoteController.camSelectedProdSegment.value =  value?.id;
                    },
                    onClear: (){
                      camNoteController.camSelectedProdSegment.value = null;


                    },
                  );
                }),
                SizedBox(height: 30,),

              /*  const Text(
                  AppText.productTypeInt,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.grey2,
                  ),
                ),*/
                CustomTextLabel(
                  label: AppText.productTypeInt,
                  isRequired: true,

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
                          (item) => item.id.toString() == camNoteController.camSelectedProdType.value,
                    ),
                    onChanged: (value) {
                      camNoteController.camSelectedProdType.value =  value?.id?.toString();
                    },
                      onClear: (){
                        camNoteController.camSelectedProdType.value = null;


                      }
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
                      value: camNoteController.camSelectedIndexRelBank.value == index,
                      onChanged: (value) => camNoteController.selectCheckboxRelBank(index),
                    );
                  }).toList(),
                )),



                const SizedBox(height: 20),




                CustomTextLabel(
                  label: AppText.packageName,
                  isRequired: true,

                ),

                const SizedBox(height: 10),


                Obx((){
                  if (camNoteController.isPackageLoading.value) {
                    return  Center(child:CustomSkelton.leadShimmerList(context));
                  }


                  return CustomDropdown<pkg.Data>(
                    items: camNoteController.packageList  ?? [],
                    getId: (item) => item.id.toString(),  // Adjust based on your model structure
                    getName: (item) => item.packageName.toString(),
                    selectedValue: camNoteController.packageList.firstWhereOrNull(
                          (item) => item.id == camNoteController.selectedPackage.value,

                    ),
                    onChanged: (value) {
                      camNoteController.selectedPackage.value =  value?.id;
                      camNoteController.camPackageAmtController.text=value?.amount.toString() ??"0";
                      if(camNoteController.selectedPackage.value!=null){
                        camNoteController.getPackageDetailsByIdApi(packageId: camNoteController.selectedPackage.toString());
                      }

                    },
                    onClear: (){
                      camNoteController.selectedPackage.value = 0;

                    },
                  );
                }),
                SizedBox(height: 20,),

                CustomLabeledTextField(
                  label: AppText.packageAmount,
                  controller: camNoteController.camPackageAmtController,
                  inputType: TextInputType.number,
                  hintText: AppText.enterPackageAmount,
                  isInputEnabled: false,
                ),

                CustomLabeledTextField(
                  label: AppText.receivableAmount,
                  controller: camNoteController.camReceivableAmtController,
                  inputType: TextInputType.number,
                  hintText: AppText.enterReceivableAmount,

                ),

                CustomLabeledPickerTextField(
                  label: AppText.receivableDate,

                  controller: camNoteController.camReceivableDateController,
                  inputType: TextInputType.name,
                  hintText: AppText.mmddyyyy,
                  isDateField: true,

                ),

                CustomLabeledTextField(
                  label: AppText.transactionDetails,
                  controller: camNoteController.camTransactionDetailsController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterTransactionDetails,

                ),
                CustomLabeledTextField(
                  label: AppText.remark,
                  controller: camNoteController.camRemarkController,
                  inputType: TextInputType.name,
                  hintText: AppText.enterRemark,

                ),

                Helper.customDivider(color: Colors.grey),
                SizedBox(height: 10,),

                CustomTextLabel(
                  label: AppText.addIncome,
                ),

                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(camNoteController.addIncomeList.length, (index) {
                    final ai = camNoteController.addIncomeList[index];

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
                            index== camNoteController.addIncomeList.length-1?
                            Obx((){
                              if(camNoteController.isLoading.value){
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
                                      camNoteController.addAdditionalSrcIncome();
                                    },
                                    icon: Container(

                                        decoration: BoxDecoration(
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
                              if(camNoteController.isLoading.value){
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
                                    onPressed: camNoteController.addIncomeList.length <= 1?(){}: (){
                                      camNoteController.removeAdditionalSrcIncome(index);
                                    },
                                    icon: Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          color: camNoteController.addIncomeList.length <= 1?AppColor.lightRed: AppColor.redColor,

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



              ],
            );
          }),
        );
      }),
    );
  }
  Widget _buildRadioOption(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: camNoteController.selectedGender.value,
          onChanged: (value) {
            camNoteController.selectedGender.value=value;
          },
        ),
        Text(gender),
      ],
    );
  }
}