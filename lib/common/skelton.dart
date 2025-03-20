

/*
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerEffectExample extends StatefulWidget {
  @override
  _ShimmerEffectExampleState createState() => _ShimmerEffectExampleState();
}

class _ShimmerEffectExampleState extends State<ShimmerEffectExample> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a delay for data fetching
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Skeleton Effect'),
        centerTitle: true,
      ),
      body: _isLoading ? shimmerList() : loadedContent(),
    );
  }



  Widget loadedContent() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Text(
                'Loaded Item ${index + 1}',
                style: const TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget shimmerList() {
    return ListView.builder(
      itemCount: 6, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        );

      },
    );
  }

  *//*Widget shimmerList() {
    return ListView.builder(
      itemCount: 6, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        );
        return
      },
    );
  }*//*

}*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomSkelton{
  static homeShimmerList() {
    return SizedBox(
      height: 120.0,
      child: ListView.builder(
        itemCount: 6, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          );

        },
      ),
    );
  }
  static productShimmerList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 6, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          );

        },
      ),
    );
  }

  static dashboardShimmerList(BuildContext context) {
    return SizedBox(
      height: 160.0, // Adjusted height to match the shimmer container
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Enables horizontal scrolling
        itemCount: 6, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjusted spacing
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // Set width for each shimmer
                height: 160.0, // Keep height fixed
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}