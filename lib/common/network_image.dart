import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'shimmer_widget.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final bool isCircle;

  const CustomNetworkImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.isCircle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(100.sp)
          : BorderRadius.circular(10.sp),
      child: CachedNetworkImage(
        imageUrl: "$url",
        fit: fit,
        placeholder: (c, s) {
          return ShimmerWidget(
            child: Container(color: Colors.grey[300]),
          );
        },
        errorWidget: (c, s, o) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: isCircle
                  ? BorderRadius.circular(1000.sp)
                  : BorderRadius.circular(10.sp),
              color: Theme.of(context).cardColor,
            ),
            child: Icon(
              Iconsax.gallery,
              size: 40.sp,
              color: Theme.of(context).hintColor,
            ),
          );
        },
      ),
    );
  }
}
