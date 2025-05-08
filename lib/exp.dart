import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BeautifulScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'https://via.placeholder.com/400x200.png?text=Banner+1',
    'https://via.placeholder.com/400x200.png?text=Banner+2',
    'https://via.placeholder.com/400x200.png?text=Banner+3',
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, __) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pro UI Screen',
            style: GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: imageUrls.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (_, __) => shimmerBox(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 180.h,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Featured Section',
                style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) => featureCard(index + 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerBox() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: 180.h,
        color: Colors.white,
      ),
    );
  }

  Widget featureCard(int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade100,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(Icons.star, size: 32.sp, color: Colors.deepPurple),
            SizedBox(height: 8.h),
            Text(
              'Feature $index',
              style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}