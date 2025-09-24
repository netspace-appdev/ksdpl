import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:ksdpl/common/helper.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BoxShape shape;
  final double borderRadius;
  final BoxFit fit;
  final BaseCacheManager? cacheManger;

  const CustomImageWidget({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.shape = BoxShape.rectangle,
    this.borderRadius = 8.0,
    this.fit = BoxFit.cover,
    this.cacheManger
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: cacheManger,//pancode
      memCacheHeight: 400, //pancode
      memCacheWidth: 400,//pancode

      imageUrl: imageUrl,
      cacheKey: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(borderRadius) : null,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: shape,
            borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(borderRadius) : null,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(borderRadius) : null,
          color: Colors.white,
        ),
        // child: Icon(Icons.ima, size: width * 0.5, color: Colors.grey),
        child: Image.asset(AppImage.noImage, height: width,),
      ),
    );
  }
}