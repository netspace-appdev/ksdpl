
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ksdpl/common/base_url.dart';
import 'package:ksdpl/controllers/camnote/camnote_controller.dart';
import 'package:ksdpl/controllers/leads/leadlist_controller.dart';
import 'package:ksdpl/custom_widgets/CustomShortButton.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/storage_service.dart';
import '../../common/validation_helper.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/income_step_controller.dart';
import '../../controllers/product/add_product_controller.dart';
import '../../custom_widgets/CustomBigYesNDilogBox.dart';
import '../../custom_widgets/CustomBigYesNoLoaderDialogBox.dart';

import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomIconDilogBox.dart';
import '../../custom_widgets/CustomImageWidget.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;

import '../../custom_widgets/CustomLabeledTextField2.dart';

import '../../custom_widgets/CustomTextLabel.dart';
import '../../custom_widgets/SnackBarHelper.dart';
import '../../custom_widgets/custom_photo_picker_widget.dart';

import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart' as state;
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import '../../models/product/GetAllProductCategoryModel.dart' as productSegment;
import '../../models/camnote/GetAllPackageMasterModel.dart' as pkg;
import '../../custom_widgets/CustomTextFieldPrefix.dart' as customTF;

class Step1CamNote extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  final CamNoteController camNoteController =Get.find();
  Addleadcontroller addleadcontroller = Get.find();
  AddProductController addProductController = Get.find();
  IncomeStepController incomeStepController = Get.put(IncomeStepController());
  final _formKeyQr = GlobalKey<FormState>();
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

            print("here 1--->${camNoteController.geoLocPropLatEnabled.value}");
            print("here 2--->${camNoteController.geoLocPropLongEnabled.value}");

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Prevents extra spacing
              children: [
                const SizedBox(
                  height: 10,
                ),
                ///Enhancement-13 Dec Package
                ExpansionTile(
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
                  title:const Text( AppText.packageDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: const Icon(Icons.list_alt, size: 20,),
                  children: [

                    Obx(()=>Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(camNoteController.multiPackageList.length, (index) {
                        final mp = camNoteController.multiPackageList[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextLabel(
                              label: AppText.packageName,
                             // isRequired: camNoteController.selectedPackage.value==0?false:true,

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
                                      (item) => item.id == mp.selectedPackageMulti.value,

                                ),
                                onChanged: (value) {
                                  // print("value image--->${value?.qRImage.toString()}");
                                  mp.selectedPackageMulti.value =  value?.id;
                                  print("mp.selectedPackageMulti.value---->${mp.selectedPackageMulti.value}");
                                  mp.camPackageAmtMultiController.text=value?.amount.toString() ??"0";
                                  print("camNoteController.camPackageAmtController.text---->${mp.camPackageAmtMultiController.text} and ${value?.amount.toString()}");
                                  if(mp.selectedPackageMulti.value!=null){
                                    camNoteController.getPackageDetailsByIdApi(packageId: mp.selectedPackageMulti.value.toString());

                                  }

                                },
                                onClear: (){
                                  camNoteController.selectedPackage.value = 0;
                                  camNoteController.camPackageAmtController.clear();
                                  camNoteController.camReceivableAmtController.clear();
                                  camNoteController.camReceivableDateController.clear();
                                  camNoteController.camTransactionDetailsController.clear();
                                  camNoteController.camRemarkController.clear();

                                },
                                isEnabled: mp.enablePackageDropdown.value??false,
                              );
                            }),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      AppText.paymentStatus,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black54,
                                      ),
                                    ),
                                    Text(
                                     mp.multiPackageStatus.value??"N/A",
                                      style: GoogleFonts.merriweather(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        color: mp.multiPackageStatus.value=="N/A"? AppColor.blackColor: mp.multiPackageStatus.value=="SUCCESS"?AppColor.greenColor:
                                        mp.multiPackageStatus.value=="FAILURE"?AppColor.redColor:AppColor.blackColor,

                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: (mp.multiPackageStatus.value=="SUCCESS" || mp.multiPackageStatus.value=="REFUND_FAILED" || mp.multiPackageStatus.value=="REFUND_SUCCESS")?null: () async {
                                        final selectedPackage =
                                        camNoteController.packageList.firstWhereOrNull(
                                              (item) => item.id == mp.selectedPackageMulti.value,
                                        );

                                        if (selectedPackage == null) {

                                          SnackbarHelper.showSnackbar(title: "Oops!", message: "Please select a package first");
                                          return;
                                        }

                                        if (selectedPackage.qRImage != null) {
                                          var empId=StorageService.get(StorageService.EMPLOYEE_ID);
                                           var success=await camNoteController.insertCustomerPackageRequestOnCamnoteApi(
                                            Id: mp.multiPackageId.toString(),
                                            Name: camNoteController.camFullNameController.text.trim().toString(),
                                            Mobile:camNoteController.camPhoneController.text.trim().toString(),
                                            Amount: mp.camPackageAmtMultiController.text.trim().toString(),
                                            ReceiveDate: mp.camReceivableDateMultiController.text.trim().toString(),
                                            Utr:  mp.camTransactionDetailsUtrMultiController.text.trim().toString(),
                                            User_ID: empId??"0",
                                            PackageId: mp.selectedPackageMulti.value.toString(),
                                            LeadId:  camNoteController.getLeadId.value.toString(),
                                          );

                                           if(success){
                                             var success2=await camNoteController.newGenerateQRApi(
                                              serviceId: camNoteController.insertCustomerPackageRequestOnCamnoteModel.value?.data?.id.toString()??"0",
                                               amount:mp.camPackageAmtMultiController.text.trim().toString(),
                                               leadId: camNoteController.insertCustomerPackageRequestOnCamnoteModel.value?.data?.leadId.toString()??"0",
                                             );

                                             if(success2){
                                               showPackageQRDialog(

                                                 imageURL:
                                                     (camNoteController.newGenerateQRModel.value?.data?.qrImageUrl??""),
                                                 packageId:mp.selectedPackageMulti.value.toString(), //selectedPackage.id.toString(),
                                                 packageAmount: camNoteController.newGenerateQRModel.value?.data?.amount.toString()??"0",
                                                 refId: camNoteController.newGenerateQRModel.value?.data?.refId==null || camNoteController.newGenerateQRModel.value?.data?.refId=="null"?"":
                                                 camNoteController.newGenerateQRModel.value?.data?.refId.toString()??"",
                                                 qrString: camNoteController.newGenerateQRModel.value?.data?.qrString.toString()??"0",
                                               );
                                               camNoteController.getSalePackagesByLeadIdApi(LeadId:camNoteController.insertCustomerPackageRequestOnCamnoteModel.value?.data?.leadId.toString()??"0" );
                                             }
                                           }



                                        } else {

                                          SnackbarHelper.showSnackbar(title: "QR Not Available", message: "QR code is not available for this package");
                                        }
                                      },
                                      icon: Container(

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            color: (mp.multiPackageStatus.value=="SUCCESS" || mp.multiPackageStatus.value=="REFUND_FAILED" || mp.multiPackageStatus.value=="REFUND_SUCCESS")?Colors.grey: AppColor.primaryColor,

                                          ),
                                          padding: EdgeInsets.all(10),

                                          child: const Text(
                                            AppText.generateQR,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.appWhite,
                                            ),
                                          )
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),

                            CustomLabeledTextField(
                              label: AppText.packageAmount,
                              controller: mp.camPackageAmtMultiController,
                              inputType: TextInputType.number,
                              hintText: AppText.enterPackageAmount,
                              isInputEnabled: mp.enableAllPackageFields.value??true,

                             // isRequired: camNoteController.selectedPackage.value==0?false:true,
                            ),


                            CustomLabeledTextField(
                              label: AppText.receivableAmount,
                              controller:mp.camReceivableAmtMultiController,
                              inputType: TextInputType.number,
                              hintText: AppText.enterReceivableAmount,
                              //isRequired: camNoteController.selectedPackage.value==0?false:true,
                            //  isInputEnabled: mp.enableAllPackageFields.value??true,
                            ),

                            CustomLabeledPickerTextField(
                              label: AppText.receivableDate,

                              controller: mp.camReceivableDateMultiController,
                              inputType: TextInputType.name,
                              hintText: AppText.mmddyyyy,
                              isDateField: true,
                              isFutureDisabled: true,
                             // isRequired: camNoteController.selectedPackage.value==0?false:true,
                              enabled:mp.enableAllPackageFields.value??true,
                            ),

                            CustomLabeledTextField(
                              label: AppText.invoiceNumber,
                              controller: mp.camTransactionDetailsUtrMultiController,
                              inputType: TextInputType.name,
                              hintText: AppText.enterinvoiceNumber,
                             // isRequired: camNoteController.selectedPackage.value==0?false:true,
                              isInputEnabled: mp.enableAllPackageFields.value??true,
                            ),

                           /* CustomLabeledTextField(
                              label: AppText.remark,
                              controller: mp.camRemarkMultiController,//camNoteController.camRemarkController
                              inputType: TextInputType.name,
                              hintText: AppText.enterRemark,

                            ),*/


                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                index== camNoteController.multiPackageList.length-1?
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
                                        onPressed:(){
                                          if (!camNoteController.canAddNewPackage()) {
                                            SnackbarHelper.showSnackbar(
                                              title: AppText.actionNotAllowed,
                                              message:  AppText.actionNotAllowedMsg,
                                              backgroundColor: AppColor.primaryColor,
                                              textColor: AppColor.appWhite
                                            );
                                            return;
                                          }
                                          camNoteController.addMultiPackage();
                                        },
                                        icon: Container(

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              color: AppColor.appWhite,
                                                border: Border.all(color: AppColor.primaryColor)

                                            ),
                                            padding: EdgeInsets.all(10),

                                            child: const Text(
                                              AppText.addPackage,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.primaryColor,
                                              ),
                                            )
                                        )
                                    ),
                                  );
                                }):
                                Container(),

                                SizedBox(height: 20),
                                if(mp.canBeDeleted.value==true)
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
                                        onPressed: camNoteController.multiPackageList.length <= 1?(){}: (){
                                          camNoteController.removeMultiPackage(index);
                                        },
                                        icon: Container(

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              color: camNoteController.multiPackageList.length <= 1?AppColor.lightRed: AppColor.redColor,

                                            ),
                                            padding: EdgeInsets.all(10),

                                            child: Icon(Icons.remove, color: AppColor.appWhite,)
                                        )
                                    ),
                                  );
                                })
                              ],
                            ),
                            if (index != camNoteController.multiPackageList.length - 1)
                              Helper.customDivider(color: AppColor.secondaryColor),

                            const SizedBox(height: 10,)
                          ],
                        );
                      }),
                    )


                    )
                  ],
                ),



                SizedBox(height: 10,),

                ExpansionTile(
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
                  title:const Text( AppText.basicDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: const Icon(Icons.list_alt, size: 20,),
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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

                        CustomLabeledTextField2(
                          isInputEnabled: true,
                          label: AppText.phoneNumberNoStar,
                          isRequired: true,
                          controller: camNoteController.camPhoneController,
                          inputType: TextInputType.phone,
                          hintText: AppText.enterPhNumber,
                          validator: ValidationHelper.validatePhoneNumber,
                          maxLength: 10,
                          onChanged: (value) {

                           /* if(value.isNotEmpty){
                              camNoteController.getLeadDetailByCustomerNumberApi(value);
                            }*/
                          },
                        ),

                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 10, // gap between items
                                    runSpacing: 5, // gap between lines if wrapped
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      const Row(
                                        children: [
                                          Text(
                                            AppText.whatsappNoNoStar,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.grey2,
                                            ),
                                          ),
                                          Text(
                                            ' *',
                                            style: TextStyle(
                                              color: Colors.red, // red star
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                        //I need a checkbox here
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Checkbox(
                                            value: camNoteController.isSameAsPhone.value,
                                            onChanged: (value) {
                                              camNoteController.isSameAsPhone.value = value ?? false;
                                              if( camNoteController.isSameAsPhone.value){
                                                camNoteController.camWhatsappController.text=camNoteController.camPhoneController.text;
                                              }else{
                                                camNoteController.camWhatsappController.clear();
                                              }
                                            },
                                            activeColor: AppColor.secondaryColor,
                                          ),
                                          const Text(
                                            AppText.sameAsPhoneNo,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),


                            SizedBox(height: 10),
                          ],
                        ),

                        customTF.CustomTextFieldPrefix(
                          controller: camNoteController.camWhatsappController,
                          inputType: TextInputType.number,
                          hintText: AppText.enterWhatsappNo,

                        ),

                        SizedBox(height: 15,),

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
                          isRequired: true,

                          controller: camNoteController.camEmailController,
                          inputType: TextInputType.emailAddress,
                          hintText: AppText.enterEA,
                          validator: ValidationHelper.validateEmail,
                        ),

                        CustomLabeledTextField(
                          label: AppText.aadhar,
                          isRequired: true,

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

                          isSecret: true,
                          secretDigit: 4,

                        ),

                        CustomLabeledTextField(
                          label: AppText.streetAdd,
                          isRequired: false,

                          controller: camNoteController.camStreetAddController,
                          inputType: TextInputType.name,
                          hintText: AppText.enterStreetAdd,

                        ),
                        CustomTextLabel(
                          label: AppText.state,
                          isRequired: true,
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
                              camNoteController.camSelectedState.value=null;
                              camNoteController.camSelectedDistrict.value = null;
                              leadDDController.districtListCurr.value.clear(); // reset dependent dropdown

                              camNoteController.camSelectedCity.value = null;
                              leadDDController. cityListCurr.value.clear(); // reset dependent dropdown
                            },
                          );
                        }),


                        const SizedBox(height: 20),


                        const CustomTextLabel(
                          label: AppText.district,
                          isRequired: true,
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



                        CustomTextLabel(
                          label: AppText.city,
                          isRequired: true,
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
                          isRequired: true,

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
                      ],
                    )


                  ],
                ),


                ExpansionTile(
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
                  title:const Text( AppText.otherDetails, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: const Icon(Icons.list_alt, size: 20,),
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          isRequired: true,
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
                              ///start from here

                              camNoteController.camSelectedProdSegment.value =  value?.id;
                              print(" camNoteController.camSelectedProdSegment.value===>${ camNoteController.camSelectedProdSegment.value}");

                              if(camNoteController.camSelectedProdSegment.value==1){
                                camNoteController.isRequiredVisibleSecure.value=true;
                                camNoteController.isOfferedSecurityMandatory.value=true;
                              }else{
                                camNoteController.isRequiredVisibleSecure.value=false;
                                camNoteController.isOfferedSecurityMandatory.value=false;
                              }
                              print(" mNoteController.isRequiredVisibleSecure.value===>af==>${ camNoteController.isRequiredVisibleSecure.value}");
                            },
                            onClear: (){
                              camNoteController.camSelectedProdSegment.value = null;


                            },
                          );
                        }),
                        SizedBox(height: 30,),


                        const CustomTextLabel(
                          label: AppText.productTypeInt, //KSDPL product is now scheme
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
                      ],
                    )


                  ],
                ),

                ExpansionTile(
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 0),
                  title:const Text( AppText.geolocationPhotos, style: TextStyle(color: AppColor.blackColor, fontSize: 16, fontWeight: FontWeight.w500),),
                  leading: const Icon(Icons.list_alt, size: 20,),
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        CustomLabeledTextField(
                          label: AppText.geoLocationProperty,
                          controller: camNoteController.camGeoLocationPropertyLatController,
                          inputType: TextInputType.number,
                          hintText: AppText.enterLatitude,
                          isInputEnabled: camNoteController.isUserAIC.value==false?false:camNoteController.geoLocPropLatEnabled.value,
                          isRequired: camNoteController.isRequiredVisibleSecure.value,
                        ),
                        CustomLabeledTextField(
                          label: "",
                          controller: camNoteController.camGeoLocationPropertyLongController,
                          inputType: TextInputType.number,
                          hintText: AppText.enterLongitude,
                          isInputEnabled: camNoteController.isUserAIC.value==false?false:camNoteController.geoLocPropLongEnabled.value,
                        ),
                        Visibility(
                          visible: (camNoteController.geoLocPropLatEnabled.value && camNoteController.geoLocPropLongEnabled.value)?true:false,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CustomShortButton(
                              backgroundColor: Colors.green,
                              textColor: AppColor.appWhite,
                              text: AppText.sendEmail,
                              onPressed: (){
                                onSendEmail("1", context);
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        CustomLabeledTextField(
                          label: AppText.geoLocationResidence,
                          controller: camNoteController.camGeoLocationResidenceLatController,
                          inputType: TextInputType.number,
                          hintText: AppText.enterLatitude,
                          isInputEnabled: camNoteController.isUserAIC.value==false?false: camNoteController.geoLocResLatEnabled.value,
                          isRequired: camNoteController.isRequiredVisibleSecure.value,
                        ),
                        CustomLabeledTextField(
                          label: "",
                          controller: camNoteController.camGeoLocationResidenceLongController,
                          inputType: TextInputType.number,
                          hintText: AppText.enterLongitude,
                          isInputEnabled:camNoteController.isUserAIC.value==false?false:camNoteController.geoLocResLongEnabled.value,
                        ),

                        Visibility(
                          visible:  (camNoteController.geoLocResLatEnabled.value && camNoteController.geoLocResLongEnabled.value)?true:false,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CustomShortButton(
                              backgroundColor: Colors.green,
                              textColor: AppColor.appWhite,
                              text: AppText.sendEmail,
                              onPressed: (){
                                onSendEmail("2", context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomLabeledTextField(
                          label: AppText.geoLocationOffice,
                          controller: camNoteController.camGeoLocationOfficeLatController,
                          inputType: TextInputType.number,
                          hintText: AppText.enterLatitude,
                          isInputEnabled:camNoteController.isUserAIC.value==false?false:camNoteController.geoLocOffLatEnabled.value,
                          isRequired: camNoteController.isRequiredVisibleSecure.value,
                        ),

                        CustomLabeledTextField(
                          label: "",
                          controller: camNoteController.camGeoLocationOfficeLongController,
                          inputType: TextInputType.number,
                          hintText: AppText.enterLongitude,
                          isInputEnabled:camNoteController.isUserAIC.value==false?false:camNoteController.geoLocOffLongEnabled.value,
                        ),

                        Visibility(
                          visible: (camNoteController.geoLocOffLatEnabled.value && camNoteController.geoLocOffLongEnabled.value)?true:false,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CustomShortButton(
                              backgroundColor: Colors.green,
                              textColor: AppColor.appWhite,
                              text: AppText.sendEmail,
                              onPressed: (){
                                onSendEmail("3", context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomPhotoPickerWidget(
                          controller: camNoteController,
                          imageKey: 'property_photo',
                          label: 'Upload Property Photos',
                          isCloseVisible:camNoteController.photosPropEnabled.value,
                          isUploadActive:camNoteController.isUserAIC.value==false?false: camNoteController.photosPropEnabled.value,
                          toastMessage: "you can not upload photos now",
                          isRequired: camNoteController.isRequiredVisibleSecure.value,
                          isUploadButtonVisible: camNoteController.isUserAIC.value==true?true:false,
                        ),

                        const SizedBox(height: 20,),

                        CustomPhotoPickerWidget(
                          controller: camNoteController,
                          imageKey: 'residence_photo',
                          label: 'Upload Residence Photos',
                          isCloseVisible:camNoteController.photosResEnabled.value,
                          isUploadActive:camNoteController.isUserAIC.value==false?false: camNoteController.photosResEnabled.value,
                          toastMessage: "you can not upload photos now",
                          isRequired: camNoteController.isRequiredVisibleSecure.value,
                          isUploadButtonVisible: camNoteController.isUserAIC.value==true?true:false,
                        ),

                        const SizedBox(height: 20,),

                        CustomPhotoPickerWidget(
                          imageKey: 'office_photo',
                          controller: camNoteController,
                          label: 'Upload Office Photos',
                          isCloseVisible:camNoteController.photosOffEnabled.value,
                          isUploadActive:camNoteController.isUserAIC.value==false?false: camNoteController.photosOffEnabled.value,
                          toastMessage: "you can not upload photos now",
                          isRequired: camNoteController.isRequiredVisibleSecure.value,
                          isUploadButtonVisible: camNoteController.isUserAIC.value==true?true:false,
                        ),

                        const SizedBox(height: 20,),
                      ],
                    )
                  ],
                ),

                Helper.customDivider(color: Colors.grey),

                SizedBox(height: 10,),

                CustomTextLabel(
                  label: AppText.addIncome,
                ),

                ///Addition Income

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

  void onSendEmail(String locationType, BuildContext context){
    if(camNoteController.camFullNameController.text.isEmpty){
      ToastMessage.msg(AppText.pleaseEnterFullName);
    }else if(camNoteController.camPhoneController.text.isEmpty){
      ToastMessage.msg(AppText.enterPhone);
    }else if(camNoteController.camEmailController.text.isEmpty){
      ToastMessage.msg(AppText.pleaseEnterEmail);
    }else{
      showDialog(
        context: context,
        builder: (context) {
          return CustomIconDialogBox(
            title: "Are you sure?",
            icon: Icons.info_outline,
            iconColor: AppColor.secondaryColor,
            description: "Do you want to send an email with the property's geo-location and photo?",
            onYes: () {

              camNoteController.sendMailForLocationOfCustomerApi(
                  locationType: locationType,
                  email:camNoteController.camEmailController.text.trim().toString(),
                  leadId: camNoteController.getLeadId.value.toString()
              );
            },
            onNo: () {

            },
          );
        },
      );

    }
  }
/*  void showPackageQRDialog({
    required BuildContext context,
    required String imageURL,
    required String packageId,

}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomBigYesNoDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Scan the QR Code",
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomImageWidget(
                    imageUrl: imageURL,
                    // imageUrl: "",
                    height: 300,
                    width: MediaQuery.of(context).size.width
                ),

                const SizedBox(height: 12),

                // C. Hindi
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                    children: [
                      TextSpan(
                          text: "Please Scan the QR Code to continue or \nSend QR on WhatsApp",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          firstButtonText: "WhatsApp",
          onFirstButtonPressed: (){
            Get.back();
            camNoteController.qrCustomerNameController.clear();
            camNoteController.qrWhatsappController.clear();
            showQRCustomerNUmberDialog(
              context: context,
              packageId: packageId,
            );

          },
          secondButtonText: "No, Thanks",
          onSecondButtonPressed: (){
            Get.back();
          },
          firstButtonColor: AppColor.primaryColor,
          secondButtonColor: AppColor.redColor,
        );
      },
    );
  }*/

  void showPackageQRDialog({

    required String imageURL,
    required String packageId,
    required String packageAmount,
    required String refId,
    required String qrString,

  }) {
    print("imageURL in dialogue===>${imageURL}");
    Get.dialog(
        CustomBigYesNoDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Scan the QR Code",
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomImageWidget(
                    imageUrl: imageURL,
                    // imageUrl: "",
                    height: 300,
                    width: double.infinity
                ),
                const SizedBox(height: 12),

                // C. Hindi
                RichText(
                  text:  TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                    children: [
                      const TextSpan(
                          text: "Amount : ",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor)),
                      TextSpan(
                          text: packageAmount,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.secondaryColor)),
                    ],
                  ),
                ),
                RichText(
                  text:  TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                    children: [
                      const TextSpan(
                          text: "RefId : ",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor)),

                      TextSpan(
                          text: refId,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.secondaryColor)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // C. Hindi
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                    children: [
                      TextSpan(
                          text: "Please Scan the QR Code to continue or \nSend QR on WhatsApp",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black87)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          firstButtonText: "WhatsApp",
          onFirstButtonPressed: (){
            Get.back();
            camNoteController.qrCustomerNameController.clear();
            camNoteController.qrWhatsappController.clear();
            showQRCustomerNUmberDialog(

              packageId: packageId,
              qrString: qrString,
            );

          },
          secondButtonText: "No, Thanks",
          onSecondButtonPressed: (){
            Get.back();
          },
          firstButtonColor: AppColor.secondaryColor,
          secondButtonColor: AppColor.redColor,
        )
    );
  }


/*  void showQRCustomerNUmberDialog({
    required BuildContext context,
    required String packageId,
  })
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => CustomBigYesNoLoaderDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Customer Details",
          content: SingleChildScrollView(
            child: Form(
              key: _formKeyQr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabeledTextField(
                    label: AppText.customerName,
                    isRequired: true,
                    controller: camNoteController.qrCustomerNameController,
                    inputType: TextInputType.name,
                    hintText: AppText.enterCustomerName,
                    validator: ValidationHelper.validateName,
                  ),
                  const SizedBox(height: 15),
                  CustomLabeledTextField(
                    label: AppText.whatsappNoNoStar,
                    isRequired: true,
                    controller: camNoteController.qrWhatsappController,
                    inputType: TextInputType.number,
                    hintText: AppText.enterWhatsappNo,
                    validator: ValidationHelper.validateWhatsapp,
                  ),
                  const SizedBox(height: 12),
                   RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                      children: [
                        TextSpan(
                          text: "Send QR on above WhatsApp Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 👇 Loader logic right here
          firstButtonChild: camNoteController.isQRApiLoading.value
              ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Text(
            "Send",
            style: TextStyle(color: Colors.white),
          ),

          secondButtonText: "Cancel",
          firstButtonColor: AppColor.primaryColor,
          secondButtonColor: AppColor.redColor,

          onFirstButtonPressed: () {
            if (!camNoteController.isQRApiLoading.value &&
                _formKeyQr.currentState!.validate()) {
              camNoteController.sendPaymentQRCodeOnWhatsAppToCustomerApi(
                CustomerName: camNoteController.qrCustomerNameController.text.trim(),
                CustomerWhatsAppNo: camNoteController.qrWhatsappController.text.trim(),
                PackageId: packageId,
              ).then((_){
                Get.back();
              });
            }
          },
          onSecondButtonPressed: () {
            Get.back();
          },
        ));
      },
    );
  }*/
  void showQRCustomerNUmberDialog({
  /*  required BuildContext context,*/
    required String packageId,
    required String qrString,
  })
  {
    Get.dialog(
        Obx(() => CustomBigYesNoLoaderDialogBox(
          titleBackgroundColor: AppColor.secondaryColor,
          title: "Customer Details",
          content: SingleChildScrollView(
            child: Form(
              key: _formKeyQr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabeledTextField(
                    label: AppText.customerName,
                    isRequired: true,
                    controller: camNoteController.qrCustomerNameController,
                    inputType: TextInputType.name,
                    hintText: AppText.enterCustomerName,
                    validator: ValidationHelper.validateName,
                  ),
                  const SizedBox(height: 15),
                  CustomLabeledTextField(
                    label: AppText.whatsappNoNoStar,
                    isRequired: true,
                    controller: camNoteController.qrWhatsappController,
                    inputType: TextInputType.number,
                    hintText: AppText.enterWhatsappNo,
                    validator: ValidationHelper.validateWhatsapp,
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.6),
                      children: [
                        TextSpan(
                          text: "Send QR on above WhatsApp Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 👇 Loader logic right here
          firstButtonChild: camNoteController.isQRApiLoading.value
              ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Text(
            "Send",
            style: TextStyle(color: Colors.white),
          ),

          secondButtonText: "Cancel",
          firstButtonColor: AppColor.secondaryColor,
          secondButtonColor: AppColor.redColor,

          onFirstButtonPressed: () {
            if (!camNoteController.isQRApiLoading.value &&
                _formKeyQr.currentState!.validate()) {
              camNoteController.sendPaymentQRCodeOnWhatsAppToCustomerApi(
                CustomerName: camNoteController.qrCustomerNameController.text.trim(),
                CustomerWhatsAppNo: camNoteController.qrWhatsappController.text.trim(),
                PackageId: packageId,
                QRString: qrString,
              ).then((_){
                Get.back();
              });
            }
          },
          onSecondButtonPressed: () {
            Get.back();
          },
        ))
    );
  }





}