import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/api/app_constant.dart';
import 'package:tiendaweb/controllers/home_controller.dart';
import 'package:tiendaweb/controllers/store_controller.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/custom_app_bar.dart';
import 'package:tiendaweb/utils/custom_bottom_bar.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/app_icon.dart';
import 'package:tiendaweb/widgets/big_text.dart';
import 'package:tiendaweb/widgets/icon_and_text_widget.dart';
import 'package:tiendaweb/widgets/small_text.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int currentIndex = 0;
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
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: appBar,
      body: body,
    );
  }

  Widget get body => ListView(
        children: [
          SizedBox(height: Dimensions.height15),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width120),
            child: BigText(
              text: "Categories",
              color: AppColor.black,
              size: Dimensions.font24,
            ),
          ),
          categories,
          SizedBox(height: Dimensions.height20),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width120),
            child: BigText(
              text: "Product By Category",
              color: AppColor.black,
              size: Dimensions.font24,
            ),
          ),
          SizedBox(height: Dimensions.height15),
          productByCategory,
          SizedBox(height: Dimensions.height20),
          bottomBar,
        ],
      );

  Widget get categories => GetBuilder<HomeController>(
        builder: (homeController) {
          return (homeController.categoryList.isEmpty)
              ? Container()
              : Container(
                  height: Dimensions.width140 + Dimensions.width30,
                  margin: EdgeInsets.only(
                      left: Dimensions.width120,
                      right: Dimensions.width120,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.categoryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await homeController.productByCategoryId(
                                homeController.categoryList[index].id
                                    .toString());
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(right: Dimensions.width5),
                                padding:
                                    EdgeInsets.only(right: Dimensions.width10),
                                height:
                                    Dimensions.width140 + Dimensions.width20,
                                width: Dimensions.width140 + Dimensions.width20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.catColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: Dimensions.width100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(AppConstant
                                                  .IMAGE_BASE_URL +
                                              "${homeController.categoryList[index].icon}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    BigText(
                                      text:
                                          "${homeController.categoryList[index].name}",
                                      color: AppColor.black,
                                      size: Dimensions.font18,
                                      weight: FontWeight.bold,
                                      maxline: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.height5),
                              Container(
                                height: currentIndex == index
                                    ? Dimensions.height5
                                    : 0,
                                width: Dimensions.width80,
                                decoration:
                                    BoxDecoration(color: AppColor.buttonColor),
                              )
                            ],
                          ),
                        );
                      }),
                );
        },
      );

  Widget get productByCategory =>
      GetBuilder<HomeController>(builder: (homeController) {
        return Container(
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
            itemCount: homeController.categoryProductList.isEmpty
                ? homeController.productList.length
                : homeController.categoryProductList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              var productList = homeController.categoryProductList.isEmpty
                  ? homeController.productList
                  : homeController.categoryProductList;
              return InkWell(
                onTap: () async {
                  // await homeController.productDetailById(
                  //     productList[index].id.toString());
                  // Get.toNamed(RouteHelper.getProductDetailsScreen());
                },
                child: Material(
                  elevation: 2,
                  type: MaterialType.canvas,
                  shadowColor: AppColor.appColor.withOpacity(0.9),
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.radius10), // if you need this
                    side: BorderSide(color: AppColor.appColor, width: 1),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: Dimensions.height120,
                            width: Dimensions.screenWidth,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                              image: DecorationImage(
                                image: NetworkImage(AppConstant.IMAGE_BASE_URL +
                                    "${productList[index].thumbnailImage}"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          BigText(
                            text: "₹ ${productList[index].basePrice}",
                            color: AppColor.black,
                            size: Dimensions.font18,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(height: Dimensions.height5),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width5),
                              child: BigText(
                                text: productList[index].name ?? "",
                                size: Dimensions.font18,
                                maxline: 2,
                                weight: FontWeight.w500,
                                color: AppColor.black,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: Dimensions.height5,
                        right: Dimensions.width5,
                        child: productList[index].isAvailableWishlist == true
                            // Remove from favourite
                            ? GestureDetector(
                                onTap: () async {
                                  await homeController.removeFromWishList(
                                      productList[index].id.toString());
                                },
                                child: AppIcon(
                                  icon: Icons.favorite_rounded,
                                  size: Dimensions.height30,
                                  backgroundColor: Colors.transparent,
                                  iconColor: AppColor.favColor,
                                  iconSize: Dimensions.height30,
                                ),
                              )
                            // Add to favourite
                            : GestureDetector(
                                onTap: () async {
                                  await homeController.addToWishList(
                                      productList[index].id.toString());
                                },
                                child: AppIcon(
                                  icon: Icons.favorite_border_outlined,
                                  size: Dimensions.height30,
                                  backgroundColor: Colors.transparent,
                                  iconColor: AppColor.favColor,
                                  iconSize: Dimensions.height30,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      });
}
