/*
Widget birthday() {
  return Obx(() {
    if (dashboardController.isLoading.value) {
      return Center(child: CustomSkelton.dashboardShimmerList(context));
    }

    if (dashboardController.getUpcomingDateOfBirthModel.value == null ||
        dashboardController.getUpcomingDateOfBirthModel.value!.data == null ||
        dashboardController.getUpcomingDateOfBirthModel.value!.data!.isEmpty) {
      return _noBirthdayCard();
    }

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
  gradient: LinearGradient(
              colors: [AppColor.primaryLight, AppColor.primaryDark],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),

          color: AppColor.appWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.grey4, width: 1),
 boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                AppText.upcomingBirthdays,
                style: GoogleFonts.merriweather(
                  fontSize: 15,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Birthday list
            SizedBox(
              height: 175,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dashboardController.getUpcomingDateOfBirthModel.value!.data!.length,
                itemBuilder: (context, index) {
                  var birthday = dashboardController.getUpcomingDateOfBirthModel.value!.data![index];
                  List<Color> colors = [AppColor.secondaryColor, AppColor.lightGreen, AppColor.lightBrown];
                  var thColor = colors[index % colors.length];

                  return Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.appWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: thColor, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Avatar
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: thColor,
                            border: Border.all(color: thColor),
                          ),
                          child: Center(
                            child: Text(
                              birthday.employeeName!.isNotEmpty
                                  ? birthday.employeeName![0].toUpperCase()
                                  : "U",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        /// Name
                        Text(
                          birthday.employeeName.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blackLight,
                          ),
                        ),

                        /// Date
                        Text(
                          Helper.birthdayFormat(birthday.dateOfBirth.toString()),
                          style: const TextStyle(fontSize: 14, color: AppColor.blackLight),
                        ),

                        /// Send wishes button
                        Container(
                          height: 40,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: thColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Add action for sending wishes
                            },
                            child: const Text(
                              "Send Wishes",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  });
}

Widget latestNews(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Obx((){
        if (dashboardController.isLoading.value) {
          return  Center(child: CustomSkelton.dashboardShimmerList(context));
        }
        if (dashboardController.getBreakingNewsModel.value == null ||
            dashboardController.getBreakingNewsModel.value!.data == null ||dashboardController.getBreakingNewsModel.value!.data!.isEmpty) {
          return _noNewsCard(); // Handle the null case
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                "Latest News",
                style: GoogleFonts.merriweather(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dashboardController.getBreakingNewsModel.value!.data!.length,
                itemBuilder: (context, index) {
                  var data = dashboardController.getBreakingNewsModel.value!.data![index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.grey4, width: 1),
                    ),
                    child:SizedBox(
                      width: 200, // Width of each news card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                            data.imageUrl.toString()==""?
                            Image.asset(
                              AppImage.noImage,
                              width: double.infinity,
                              height: 100,
                              fit: BoxFit.cover,
                            ):
                            Image.network(
                              BaseUrl.imageBaseUrl+ data.imageUrl.toString(),
                              width: double.infinity,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Wrapping title and description inside Expanded/Flexible to prevent overflow
                          Expanded(
                            child: Text(
                              data.title.toString(),//data["title"]!,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: Text(
                              data.description.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Remove,d Spacer() as it forces max height usage
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: TextButton(
                              //onPressed: () => _launchURL(data.url.toString()),
                              onPressed: (){
                                Get.toNamed("/newsDetailsScreen", arguments: {
                                  "newsId":data.id.toString()
                                });
                              },
                              child: const Text(
                                "Read More",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      })
    ],
  );
}
*/
