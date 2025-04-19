/*

class LoanApplicationScreen extends StatelessWidget {
  final LeadDDController leadDDController = Get.put(LeadDDController());
  final GreetingController greetingController = Get.put(GreetingController());
  final InfoController infoController = Get.put(InfoController());
  final MultiStepFormController controller = Get.put(MultiStepFormController());
  final LoanApplicationController loanApplicationController = Get.put(LoanApplicationController());

  final _formKey = GlobalKey<FormState>();

  final List<String> tabTitles = [
    "Personal Information",
    "Co-Applicant Details",
    "Property Details",
    "Family Members",
    "Credit Cards",
    "Financial Details",
    "References",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: Column(
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
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        header(context),
                      ],
                    ),
                  ),
                  // White Container with Tabs and Progress Bar
                  SizedBox(
                    height: 500,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 90),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: const BoxDecoration(
                          color: AppColor.backgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TabBar(
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.primaryDark,
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: AppColor.primaryDark,
                              tabs: tabTitles.map((title) => CustomTab(text: title)).toList(),
                            ),
                            const SizedBox(height: 15),
                            GetBuilder<MultiStepFormController>(
                              builder: (controller) {
                                double percent = (controller.currentTabIndex + 1) / tabTitles.length;
                                return LinearProgressIndicator(
                                  value: percent,
                                  minHeight: 10,
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.green,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Expanded(
                                child: TabBarView(
                                  children: List.generate(
                                    tabTitles.length,
                                        (index) => Center(
                                      child: Text(
                                        '${tabTitles[index]} Form Section',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const Text(
            "Loan Application Form",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 24), // Placeholder for alignment
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String text;

  const CustomTab({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.primaryDark),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
class MultiStepFormController extends GetxController {
  int currentTabIndex = 0;

  void updateTabIndex(int index) {
    currentTabIndex = index;
    update();
  }
}*/
