/*
class LoanApplicationScreen extends StatelessWidget {

  LeadDDController leadDDController = Get.put(LeadDDController());
  GreetingController greetingController = Get.put(GreetingController());
  InfoController infoController = Get.put(InfoController());
  final TextEditingController _searchController = TextEditingController();


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
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.primaryLight, AppColor.primaryDark],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
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
                      margin: EdgeInsets.only(
                          top: 90 // MediaQuery.of(context).size.height * 0.22
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
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              controller: loanApplicationController.scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: loanApplicationController.titles.length,
                              itemBuilder: (context, index) {
                                return Obx(() {
                                  Color circleColor;

                                  if (loanApplicationController.currentStep.value == index) {
                                    circleColor = AppColor.primaryColor;
                                  } else if (loanApplicationController.stepCompleted[index]) {
                                    circleColor = Colors.green;
                                  } else {
                                    circleColor = Colors.grey;
                                  }

                                  return GestureDetector(
                                    onTap: () => loanApplicationController.jumpToStep(index),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        if (index != 0)
                                          Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(bottom: 25), // adjust vertically
                                            child: SizedBox(
                                              width: 30,
                                              child: Divider(
                                                thickness: 2,
                                                color: loanApplicationController.stepCompleted[index - 1]
                                                    ? Colors.green
                                                    : Colors.grey[300],
                                                height: 2,
                                              ),
                                            ),
                                          ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: circleColor,
                                                  child: Text(
                                                    '${index + 1}',
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                                if (loanApplicationController.stepCompleted[index])
                                                  Positioned(
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Container(
                                                      decoration:BoxDecoration(
                                                          color:loanApplicationController.currentStep.value == index
                                                              ? Colors.green // current step completed
                                                              : Colors.blue,
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.white)
                                                      ),
                                                      padding: EdgeInsets.all(2.0),
                                                      child: Icon(Icons.check, size: 12, color: Colors.white),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 100,
                                                child: Text(
                                                  _breakTwoWords(loanApplicationController.titles[index]),
                                                  style: const TextStyle(fontSize: 12),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Scrollable form
                          SingleChildScrollView(
                            child: Obx(() => Padding(
                              padding: const EdgeInsets.only(bottom: 80), // give space for bottom buttons
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Form Step ${loanApplicationController.currentStep.value + 1}',
                                    style: const TextStyle(fontSize: 25),
                                  ),

                                  const SizedBox(height: 20),

                                  // Placeholder: Replace with real form fields
                                  for (int i = 0; i < 20; i++)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(labelText: 'Field $i'),
                                      ),
                                    ),
                                ],
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() => Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: loanApplicationController.currentStep.value > 0
                    ? loanApplicationController.previousStep
                    : null,
                child: const Text('Prev'),
              ),
              ElevatedButton(
                onPressed: () => loanApplicationController.markStepAsCompleted(),
                child: const Text('Save', style: TextStyle(color: AppColor.appWhite),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: loanApplicationController.currentStep.value < 6
                    ? loanApplicationController.nextStep
                    : null,
                child: const Text('Next',style: TextStyle(color: AppColor.appWhite),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                ),
              ),
            ],
          ),
        )),


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
  String _breakTwoWords(String title) {
    final words = title.trim().split(' ');
    if (words.length == 2) {
      return '${words[0]}\n${words[1]}';
    }
    return title;
  }

}*/
