

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'helper.dart';



class ImageCarousel extends StatefulWidget {
  final List<String> imgUrls;
  const ImageCarousel({Key? key, required this.imgUrls}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {

  bool isLoading = true;
  int activeIndex = 0; // Keeps track of the current active slide

  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Carousel Slider
          CarouselSlider.builder(
            itemCount: widget.imgUrls.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.imgUrls[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 150.0,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              aspectRatio: 1 / 1,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 16.0),
          // Dot Indicator
          AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: widget.imgUrls.length,
            effect: JumpingDotEffect(
              activeDotColor: AppColor.primaryColor,
              dotHeight: 8.0,
              dotWidth: 8.0,
              spacing: 6.0,
            ),
          ),
        ],
      )
    );
  }
}


