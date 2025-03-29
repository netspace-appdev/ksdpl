
/*
  void showFilterDialog({
    required BuildContext context,
  }) {
    List<String> options = ["Fresh Leads", "Interested Leads", "Not Interested Leads", "Doable Leads","Not Doable Leads"];
    //String? selectedOption = options[0]; // Default selection

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity, // Makes it full width
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🔵 Title in Blue Strip
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color:AppColor.primaryColor, // Title background color
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        gradient: LinearGradient(
                          colors: [AppColor.primaryLight, AppColor.primaryDark],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: const Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white, // Title text color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // 📝 Content (Radio Buttons)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child:  Obx(()=>Column(
                        children: options.asMap().entries.map((entry) {
                          int index = entry.key;
                          String option = entry.value;

                          return CheckboxListTile(
                            activeColor: AppColor.secondaryColor,

                            title: Text(option),
                            value: leadListController.selectedIndex.value == index,
                            onChanged: (value) => leadListController.selectCheckbox(index),
                          );
                        }).toList(),
                      )),
                    ),

                    // 🟠 Buttons (Close & Submit)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColor.grey1,
                              side: BorderSide(color: AppColor.grey2),
                            ),
                            child: Text("Close", style: TextStyle(color: AppColor.grey2)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              leadListController.filterSubmit();
                              Navigator.pop(context); // Close dialog after submission
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.orangeColor,
                            ),
                            child: Text("Submit", style: TextStyle(color: AppColor.appWhite)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }*/

///call
/*void showCallFeedbackDialog({
  required BuildContext context,
  required leadId,
  required currentLeadStage,
  required callDuration,
  required callStartTime,
  required callEndTime,
  required callStatus,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return CustomBigDialogBox(
        titleBackgroundColor: AppColor.secondaryColor,
        title: AppText.addFAndF,
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7, // Prevents overflow
          ),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  CustomLabeledTextField(
                    label: AppText.callFeedback,
                    isRequired: false,
                    controller: leadListController.callFeedbackController,
                    inputType: TextInputType.name,
                    hintText: AppText.enterCallFeedback,
                    isTextArea: true,
                  ),
                  SizedBox(height: 15),
                  CustomLabeledTextField(
                    label: AppText.leadFeedback,
                    isRequired: false,
                    controller: leadListController.leadFeedbackController,
                    inputType: TextInputType.name,
                    hintText: AppText.enterLeadFeedback,
                    isTextArea: true,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Obx(()=>Checkbox(
                        activeColor: AppColor.secondaryColor,
                        value: leadListController.isCallReminder.value,
                        onChanged: (bool? value) {

                          leadListController.isCallReminder.value = value ?? false;

                        },
                      )),
                      Text(
                        AppText.callReminder,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(()=> CustomLabeledPickerTextField(
                    label: AppText.selectDate,
                    isRequired: false,
                    controller: leadListController.followDateController,
                    inputType: TextInputType.name,
                    hintText: "MM/DD/YYYY",
                    isDateField: true,
                    enabled: leadListController.isCallReminder.value,
                  )),
                  Obx(()=>CustomLabeledTimePickerTextField(
                    label: AppText.selectTime,
                    isRequired: false,
                    controller: leadListController.followTimeController,
                    inputType: TextInputType.datetime,
                    hintText: "HH:MM AM/PM",
                    isTimeField: true,
                    enabled: leadListController.isCallReminder.value,
                  )),
                ],
              ),
            ),
          ),
        ),
        onSubmit: () {
          if (leadListController.callFeedbackController.text.isEmpty &&
              leadListController.leadFeedbackController.text.isEmpty) {
            ToastMessage.msg(AppText.addFeedbackFirst);
          } else {

*//*              String selectedDate = leadListController.followDateController.text; // MM/DD/YYYY
              String selectedTime = leadListController.followTimeController.text; // HH:MM AM/PM


              String formattedDateTime="";

              if(leadListController.isCallReminder.value){
                print("call reminder");
                if (selectedDate.isEmpty || selectedTime.isEmpty) {
                  ToastMessage.msg("Date or Time is empty!");
                  return;
                }

                DateTime parsedDate = DateFormat("MM-dd-yyyy").parse(selectedDate);


                DateTime parsedTime = DateFormat("hh:mm a").parse(selectedTime);


                DateTime combinedDateTime = DateTime(
                  parsedDate.year,
                  parsedDate.month,
                  parsedDate.day,
                  parsedTime.hour,
                  parsedTime.minute,
                );

                formattedDateTime = DateFormat("yyyy-MM-dd' 'HH:mm:ss.SS").format(combinedDateTime);

                print("Final Formatted DateTime if reminder is set: $formattedDateTime");
              }else{
                print("No call reminder");

                DateTime now = DateTime.now();

                formattedDateTime=now.toString();
                print("Final Formatted DateTime if reminder is not set: $formattedDateTime");
              }





              var remStatus=leadListController.isCallReminder.value?"1":"0";
              print("remStatus before passing: $remStatus");
              print("formattedDateTime before passing: $formattedDateTime");

              leadListController.workOnLeadApi(
                leadId: leadId.toString(),
                leadStageStatus: currentLeadStage,
                feedbackRelatedToCall: leadListController.callFeedbackController.text.trim(),
                feedbackRelatedToLead: leadListController.leadFeedbackController.text.trim(),
                callStatus: callStatus,
                callDuration: callDuration,
                callStartTime: callStartTime,
                callEndTime: callEndTime,
                callReminder: formattedDateTime,
                reminderStatus:  leadListController.isCallReminder.value?"1":"0",
              );*//*
            var id=leadListController.workOnLeadModel!.data!.id.toString();
            if(callStatus=="1"){
              callDuration=leadListController.workOnLeadModel!.data!.callDuration.toString();
              callStartTime=leadListController.workOnLeadModel!.data!.callStartTime.toString();
              callEndTime=leadListController.workOnLeadModel!.data!.callEndTime.toString();

            }

            leadListController.callFeedbackSubmit(
                leadId: leadId,
                currentLeadStage: currentLeadStage,
                callStatus: callStatus,
                callDuration: callDuration,
                callStartTime: callStartTime,
                callEndTime: callEndTime,
                id: id

            );
            Get.back();
          }

        },
      );
    },
  );
}*/
