import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/dimension.dart';

class ShimmerHelper {
  buildBasicShimmer(
      {double height = double.infinity, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: AppColor.grey.withOpacity(0.3),
      highlightColor: AppColor.grey,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  buildListShimmer(
      {int itemCount = 10,
      double itemHeight = 100.0,
      double width = double.infinity}) {
    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
              top: 0.0,
              left: Dimensions.width15,
              right: Dimensions.width15,
              bottom: Dimensions.height15),
          child: ShimmerHelper()
              .buildBasicShimmer(height: itemHeight, width: width),
        );
      },
    );
  }

  buildProductGridShimmer({scontroller, itemCount = 10}) {
    return GridView.builder(
      itemCount: itemCount,
      controller: scontroller,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      padding: EdgeInsets.all(Dimensions.width10),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: AppColor.grey.withOpacity(0.3),
            highlightColor: AppColor.grey,
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  buildSquareGridShimmer({scontroller, itemCount = 10}) {
    return GridView.builder(
      itemCount: itemCount,
      controller: scontroller,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1),
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: AppColor.grey.withOpacity(0.3),
            highlightColor: AppColor.grey,
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
