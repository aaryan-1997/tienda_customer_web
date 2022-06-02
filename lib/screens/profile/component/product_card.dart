import 'package:flutter/material.dart';

import '../../../api/app_constant.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimension.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/small_text.dart';


class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => onTap(context),
      child: Container(
        margin: EdgeInsets.only(left: Dimensions.width5),
        padding: EdgeInsets.only(
            top: Dimensions.height10,
            left: Dimensions.width5,
            right: Dimensions.width5),
        width: Dimensions.width120,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.appColor, width: 1.5),
          borderRadius: BorderRadius.circular(Dimensions.radius15),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: constraints.maxHeight * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(AppConstant.IMAGE_BASE_URL + imageUrl),
                        fit: BoxFit.contain),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                BigText(
                  text: name,
                  size: Dimensions.font12,
                  color: AppColor.black,
                  textAlign: TextAlign.center,
                  maxline: 2,
                ),
                SmallText(
                  text: price,
                  size: Dimensions.font13,
                  color: AppColor.black,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

