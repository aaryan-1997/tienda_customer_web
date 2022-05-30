import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/api/app_constant.dart';
import 'package:tiendaweb/controllers/home_controller.dart';
import 'package:tiendaweb/controllers/store_controller.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/app_icon.dart';
import 'package:tiendaweb/widgets/big_text.dart';
import 'package:tiendaweb/widgets/icon_and_text_widget.dart';
import 'package:tiendaweb/widgets/small_text.dart';

import '../../utils/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StoreController _storeController = Get.find();
  List<String> imgList = [
    'https://www.texcial.com/wp-content/uploads/2020/07/EFWEF.png',
    'http://onlyracks.com/images/slider-2.jpg'
  ];

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

  AppBar get appBar => AppBar(
        centerTitle: true,
        elevation: 0.4,
        flexibleSpace: Container(color: AppColor.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: Dimensions.height50,
              width: Dimensions.width45,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/logo.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  focusColor: AppColor.grey,
                  onTap: () async {
                    await _storeController.initalLoad(context);
                  },
                  child: IconAndBigTextWidget(
                    icon: Icons.home_rounded,
                    text: 'Home',
                    iconColor: AppColor.black,
                    textColor: AppColor.black,
                    iconSize: Dimensions.height30,
                    textSize: Dimensions.font20,
                  ),
                ),
                SizedBox(width: Dimensions.height20),
                IconAndBigTextWidget(
                  icon: Icons.category,
                  text: 'Category',
                  iconColor: AppColor.black,
                  textColor: AppColor.black,
                  iconSize: Dimensions.height30,
                  textSize: Dimensions.font20,
                ),
                SizedBox(width: Dimensions.height20),
                IconAndBigTextWidget(
                  icon: Icons.favorite_rounded,
                  text: 'Wishlist',
                  iconColor: AppColor.black,
                  textColor: AppColor.black,
                  iconSize: Dimensions.height30,
                  textSize: Dimensions.font20,
                ),
                SizedBox(width: Dimensions.height20),
                IconAndBigTextWidget(
                  icon: Icons.contact_page,
                  text: 'About Us',
                  iconColor: AppColor.black,
                  textColor: AppColor.black,
                  iconSize: Dimensions.height30,
                  textSize: Dimensions.font20,
                ),
                SizedBox(width: Dimensions.height20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.getStoreRoute());
                  },
                  child: IconAndBigTextWidget(
                    icon: Icons.add_business_sharp,
                    text: 'Your Stores',
                    iconColor: AppColor.black,
                    textColor: AppColor.black,
                    iconSize: Dimensions.height30,
                    textSize: Dimensions.font20,
                  ),
                ),
                SizedBox(width: Dimensions.height20),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: AppColor.black)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart, color: AppColor.black)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: AppColor.black)),
          SizedBox(width: Dimensions.width10),
        ],
      );

  Widget get body => ListView(
        children: [
          // carousel
          carousel,
          SizedBox(width: Dimensions.height10),
          //offer
          offers,
          SizedBox(width: Dimensions.height10),
          // categories
          Container(
            margin: EdgeInsets.only(left: Dimensions.width20),
            child: BigText(
              text: "Categories",
              weight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          categories,
          SizedBox(width: Dimensions.height10),
          //product
          Container(
            margin: EdgeInsets.only(left: Dimensions.width20),
            child: BigText(
              text: "Popular Products",
              weight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          products,
          //Bottom Bar
          bottomBar,
        ],
      );

  Widget get carousel => GetBuilder<HomeController>(builder: (homeController) {
        return (homeController.sliderList.isEmpty)
            ? Container()
            : CarouselSlider.builder(
                options: CarouselOptions(
                  height: Dimensions.screenHeight * 0.9,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 1200),
                  viewportFraction: 1.0,
                ),
                itemCount: homeController.sliderList.length,
                itemBuilder: (context, i, pageIndex) {
                  var item = homeController.sliderList[i];
                  return cacheImage(
                      image: item.sliderImage ?? "",
                      radius: 0,
                      height: Dimensions.screenHeight * 0.9,
                      width: Dimensions.screenWidth);
                },
              );
      });

  Widget get offers => Container(
        height: Dimensions.screenHeight * 0.2,
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                height: Dimensions.screenHeight * 0.16,
                width: Dimensions.screenHeight * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/placeholder.png'),
                  ),
                ),
              );
            }),
      );

  Widget get categories => GetBuilder<HomeController>(
        builder: (homeController) {
          return (homeController.categoryList.isEmpty)
              ? Container()
              : Container(
                  height: Dimensions.width80,
                  margin: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width10,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.categoryList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: Dimensions.width5),
                          padding: EdgeInsets.only(right: Dimensions.width10),
                          height: Dimensions.width80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.catColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: Dimensions.width80,
                                width: Dimensions.width80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(AppConstant
                                            .IMAGE_BASE_URL +
                                        "${homeController.categoryList[index].icon}"),
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width5),
                              BigText(
                                text:
                                    "${homeController.categoryList[index].name}",
                                color: AppColor.black,
                                size: Dimensions.font18,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        );
                      }),
                );
        },
      );

  Widget get products => GetBuilder<HomeController>(builder: (homeController) {
        return (homeController.productList.isEmpty)
            ? Container()
            : Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.height15,
                    right: Dimensions.height15,
                    bottom: Dimensions.height15),
                child: GridView.builder(
                  itemCount: homeController.productList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        // await homeController.productDetailById(
                        //     homeController.productList[index].id.toString());
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
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    image: DecorationImage(
                                      image: NetworkImage(AppConstant
                                              .IMAGE_BASE_URL +
                                          "${homeController.productList[index].thumbnailImage}"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(height: Dimensions.height10),
                                BigText(
                                  text:
                                      "₹ ${homeController.productList[index].basePrice}",
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
                                      text: homeController
                                              .productList[index].name ??
                                          "",
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
                              child: homeController.productList[index]
                                          .isAvailableWishlist ==
                                      true
                                  // Remove from favourite
                                  ? GestureDetector(
                                      onTap: () async {
                                        await homeController.removeFromWishList(
                                            homeController.productList[index].id
                                                .toString());
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
                                            homeController.productList[index].id
                                                .toString());
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
  Widget get bottomBar => SizedBox(
        height: Dimensions.screenHeight / 1.5,
        width: Dimensions.screenWidth,
        child: ClipPath(
          clipper: WaveClipperOne(flip: true, reverse: true),
          child: Container(
            color: AppColor.appColor.withOpacity(0.2),
            padding: EdgeInsets.only(
                top: Dimensions.height60,
                left: Dimensions.width45,
                right: Dimensions.width45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    width: Dimensions.screenWidth / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimensions.height100,
                          width: Dimensions.width100,
                          child: Image.asset("assets/image/splash.png"),
                        ),
                        SizedBox(height: Dimensions.height45),
                        SmallText(
                          text: ConstantKey.about,
                          color: AppColor.black,
                          size: Dimensions.font16,
                          maxLine: 5,
                        ),
                        SizedBox(height: Dimensions.height30),
                        Row(
                          children: [
                            SmallText(
                              text: "Address",
                              color: AppColor.black,
                              size: Dimensions.font18,
                            ),
                            SizedBox(width: Dimensions.width10),
                            BigText(
                              text: "D-77,Noida Sector 63",
                              color: AppColor.black,
                              size: Dimensions.font16,
                              maxline: 2,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height30),
                        Row(
                          children: [
                            SmallText(
                              text: "Email",
                              color: AppColor.black,
                              size: Dimensions.font18,
                            ),
                            SizedBox(width: Dimensions.width10),
                            BigText(
                              text: "demo@test.com",
                              color: AppColor.black,
                              size: Dimensions.font16,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height30),
                        Row(
                          children: [
                            SmallText(
                              text: "Call Us ",
                              color: AppColor.black,
                              size: Dimensions.font18,
                              maxLine: 2,
                            ),
                            SizedBox(width: Dimensions.width10),
                            BigText(
                              text: "9884435XX",
                              color: AppColor.black,
                              size: Dimensions.font16,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: Dimensions.screenWidth / 4,
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: Dimensions.screenWidth / 4,
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: Dimensions.screenWidth / 4,
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
