import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/api/app_constant.dart';
import 'package:tiendaweb/controllers/home_controller.dart';
import 'package:tiendaweb/controllers/store_controller.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/custom_app_bar.dart';
import 'package:tiendaweb/utils/custom_bottom_bar.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/utils/shimmer_helper.dart';
import 'package:tiendaweb/widgets/big_text.dart';
import 'package:tiendaweb/widgets/small_text.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final StoreController _storeController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _storeController.initalLoad(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar, body: body);
  }

  Widget get body => ListView(
        children: [
          SizedBox(height: Dimensions.height20),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width120),
            child: BigText(
              text: "Wishlist",
              color: AppColor.black,
              size: Dimensions.font24,
            ),
          ),
          wishList,
          bottomBar,
        ],
      );

  Widget get wishList => GetBuilder<HomeController>(builder: (homeController) {
        return homeController.wishlistProduct.isEmpty &&
                homeController.isLoading
            ? ShimmerHelper().buildProductGridShimmer()
            : homeController.wishlistProduct.isEmpty &&
                    !homeController.isLoading
                ? Container(
                    alignment: Alignment.center,
                    height: Dimensions.height140,
                    child: SmallText(
                      text: "No item in your wishlist",
                      color: AppColor.grey,
                      size: Dimensions.font26,
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.width120,
                      right: Dimensions.width120,
                    ),
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        left: Dimensions.height15,
                        right: Dimensions.height15,
                        bottom: Dimensions.height15),
                    child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            top: Dimensions.height5,
                            left: Dimensions.height5,
                            right: Dimensions.height5,
                            bottom: Dimensions.height5),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: homeController.wishlistProduct.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () async {
                              // await homeController.productDetailById(
                              //     "${homeController.wishlistProduct[index].product?.id}");
                              // Get.toNamed(RouteHelper.getProductDetailsScreen());
                            },
                            child: Material(
                              elevation: 2,
                              type: MaterialType.canvas,
                              shadowColor: AppColor.appColor.withOpacity(0.5),
                              color: AppColor.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                side: BorderSide(
                                    color: AppColor.appColor.withOpacity(0.5),
                                    width: 0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: Dimensions.screenHeight * 0.25,
                                    width: Dimensions.screenWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius10),
                                      image: DecorationImage(
                                          image: NetworkImage(AppConstant
                                                  .IMAGE_BASE_URL +
                                              "${homeController.wishlistProduct[index].product?.thumbnailImage}"),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: Dimensions.height30,
                                          margin: EdgeInsets.only(
                                              right: Dimensions.width5,
                                              bottom: Dimensions.height5),
                                          padding: EdgeInsets.only(
                                            left: Dimensions.width5,
                                            right: Dimensions.width5,
                                            top: Dimensions.height5 / 2,
                                            bottom: Dimensions.height5 / 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.appColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.width10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: AppColor.white,
                                                size: Dimensions.iconSize20,
                                              ),
                                              SmallText(
                                                text:
                                                    "${homeController.wishlistProduct[index].product?.rating}",
                                                color: AppColor.white,
                                                size: Dimensions.font16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: Dimensions.height10,
                                        left: Dimensions.height10,
                                        right: Dimensions.height10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SmallText(
                                            text:
                                                "${homeController.wishlistProduct[index].product?.name}",
                                            color: AppColor.black,
                                            size: Dimensions.font18,
                                            maxLine: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    "${homeController.wishlistProduct[index].product?.basePrice}",
                                                color: AppColor.grey,
                                                size: Dimensions.font15,
                                                weight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
      });
}
