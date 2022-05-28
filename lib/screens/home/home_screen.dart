import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiendaweb/api/api_url.dart';
import 'package:tiendaweb/provider/homePro/home_provider.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/app_icon.dart';
import 'package:tiendaweb/widgets/big_text.dart';
import 'package:tiendaweb/widgets/icon_and_text_widget.dart';
import 'package:tiendaweb/widgets/small_text.dart';

import '../../utils/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  final String shopId;
  const HomeScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imgList = [
    'https://www.texcial.com/wp-content/uploads/2020/07/EFWEF.png',
    'http://onlyracks.com/images/slider-2.jpg'
  ];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _initFun();
    });
    super.initState();
  }

  _initFun() async {
    log('message  ${widget.shopId}');
    // await context.read<AuthProvider>().fetchUserInfo(context: context,);
    await Provider.of<HomeProvider>(context, listen: false)
        .fetchSlider(context: context, isLoad: false, id: widget.shopId);
    await Provider.of<HomeProvider>(context, listen: false)
        .fetchCategory(context: context, isLoad: false, id: widget.shopId);
    await Provider.of<HomeProvider>(context, listen: false)
        .fetchProduct(context: context, isLoad: false, id: widget.shopId);
  }

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
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
                IconAndBigTextWidget(
                  icon: Icons.home_rounded,
                  text: 'Home',
                  iconColor: AppColor.black,
                  textColor: AppColor.black,
                  iconSize: Dimensions.height30,
                  textSize: Dimensions.font20,
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
                IconAndBigTextWidget(
                  icon: Icons.person_rounded,
                  text: 'Contact Us',
                  iconColor: AppColor.black,
                  textColor: AppColor.black,
                  iconSize: Dimensions.height30,
                  textSize: Dimensions.font20,
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
        ],
      );

  Widget get carousel =>
      Consumer<HomeProvider>(builder: (context, data, child) {
        return (data.sliders.isEmpty)
            ? Container()
            : CarouselSlider.builder(
                options: CarouselOptions(
                  height: Dimensions.screenHeight! * 0.9,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 1200),
                  viewportFraction: 1.0,
                ),
                itemCount: data.sliders.length,
                itemBuilder: (context, i, pageIndex) {
                  var item = data.sliders[i];
                  return cacheImage(
                      image: item.sliderImage,
                      radius: 0,
                      height: Dimensions.screenHeight! * 0.9,
                      width: Dimensions.screenWidth!);
                },
              );
      });

  Widget get offers => Container(
        height: Dimensions.screenHeight! * 0.2,
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                height: Dimensions.screenHeight! * 0.16,
                width: Dimensions.screenHeight! * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/placeholder.png'),
                  ),
                ),
              );
            }),
      );

  Widget get categories => Consumer<HomeProvider>(
        builder: (context, data, child) {
          return (data.category.isEmpty)
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
                      itemCount: data.category.length,
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
                                    image: NetworkImage(Url.IMAGE_BASE_URL +
                                        "${data.category[index].icon}"),
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width5),
                              BigText(
                                text: "${data.category[index].name}",
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

  Widget get products =>
      Consumer<HomeProvider>(builder: (context, data, child) {
        return (data.category.isEmpty)
            ? Container()
            : Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.height15,
                    right: Dimensions.height15,
                    bottom: Dimensions.height15),
                child: GridView.builder(
                  itemCount: data.productList.length,
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
                                      image: NetworkImage(Url.IMAGE_BASE_URL +
                                          "${data.productList[index].thumbnailImage}"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(height: Dimensions.height10),
                                BigText(
                                  text:
                                      "₹ ${data.productList[index].basePrice}",
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
                                      text: data.productList[index].name ?? "",
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
                              child: data.productList[index]
                                          .isAvailableWishlist ==
                                      true
                                  // Remove from favourite
                                  ? GestureDetector(
                                      onTap: () async {
                                        await data.removeFromWishList(
                                            context: context,
                                            isLoad: false,
                                            storeId: widget.shopId,
                                            prodId: data.productList[index].id
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
                                        await data.addToWishList(
                                            context: context,
                                            isLoad: false,
                                            storeId: widget.shopId,
                                            prodId: data.productList[index].id
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
}
