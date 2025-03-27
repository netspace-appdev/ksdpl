
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ksdpl/models/dashboard/GetAllStateModel.dart';
import 'package:ksdpl/models/dashboard/GetDistrictByStateModel.dart' as dist;
import 'package:ksdpl/models/dashboard/GetCityByDistrictIdModel.dart' as city;
import 'package:ksdpl/models/dashboard/GetAllBankModel.dart' as bank;
import 'package:ksdpl/models/dashboard/GetAllKsdplProductModel.dart' as product;
import 'package:ksdpl/models/dashboard/GetProductListByBank.dart' as productBank;
import '../../common/CustomSearchBar.dart';
import '../../common/helper.dart';
import '../../common/skelton.dart';
import '../../common/validation_helper.dart';
import '../../controllers/drawer_controller.dart';
import '../../controllers/greeting_controller.dart';
import '../../controllers/lead_dd_controller.dart';
import '../../controllers/leads/addLeadController.dart';
import '../../controllers/leads/infoController.dart';
import '../../custom_widgets/CustomDropdown.dart';
import '../../custom_widgets/CustomLabelPickerTextField.dart';
import '../../custom_widgets/CustomLabeledTextField.dart';
import 'custom_drawer.dart';



class MoreSettingScreen extends StatelessWidget {


  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final Addleadcontroller addleadcontroller =Get.put(Addleadcontroller());
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

                            SizedBox(
                              height: 300,
                              child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                children: [
                                  CustomExpansionTile(
                                    image: AppImage.manInBlack,
                                    title: AppText.myProfile,
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    children: [
                                      ListTile(

                                        leading:  Icon(Icons.home,color: Theme.of(context).brightness == Brightness.dark?Colors.white54:AppColor.black54),
                                        title:  Text("Edit profile", style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                                        onTap: () {
                                          //  Get.toNamed("/editProfile");
                                        },
                                      ),
                                      ListTile(
                                        leading:  Icon(Icons.lock,color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),
                                        title:  Text(AppText.changePassword,style: TextStyle(color:Theme.of(context).brightness == Brightness.dark?Colors.white54: AppColor.black54),),
                                        onTap: () {
                                          //  Get.toNamed("/changePassword");
                                        },
                                      ),
                                    ],
                                  ),
                                  CustomExpansionTile(
                                    image: AppImage.manInBlack,
                                    title: AppText.aboutUs,
                                    onTap: (){
                                      Navigator.pop(context);
                                    },

                                  ),

                                ],
                              ),
                            )
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

      ),
    );
  }
  Widget header(context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          addleadcontroller.fromWhere.value=="drawer" ||addleadcontroller.fromWhere.value=="leadList" ?
          InkWell(
              onTap: (){
                Get.back();
              },
              child: Image.asset(AppImage.arrowLeft,height: 24,)):
          InkWell(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(AppImage.drawerIcon)),

          const Text(
            AppText.settings,
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


    if (_formKey.currentState!.validate()) {

      if (addleadcontroller.selectedGender.value==null) {
        ToastMessage.msg("Please select gender");
      }else {
        ToastMessage.msg("Form Submitted");
      }
    }
  }


}

class CustomExpansionTile extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  final List<Widget> children;
  CustomExpansionTile({required this.image, required this.title,  required this.onTap,

    this.children = const [],});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          leading: Image.asset(image, height: 20),
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          children: children,
        ),
      ),
    );
  }
}

