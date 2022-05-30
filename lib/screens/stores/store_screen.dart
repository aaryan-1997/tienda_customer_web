import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/location_controller.dart';
import 'package:tiendaweb/controllers/store_controller.dart';
import 'package:tiendaweb/routes/routes.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:tiendaweb/utils/custom_widgets.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/utils/sp_function.dart';
import 'package:tiendaweb/widgets/big_text.dart';
import 'package:tiendaweb/widgets/small_text.dart';

import '../../utils/colors.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar => AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Store'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.getAddStoreRoute());
              },
              icon: Icon(Icons.add_business_sharp)),
          IconButton(
              onPressed: () {
                Get.find<LocationController>().getGeoLocationPosition();
              },
              icon: Icon(Icons.location_pin)),
          SizedBox(width: 10)
        ],
      );

  Widget get body => LayoutBuilder(builder: (context, size) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                  ),
                ]),
            height:
                (size.maxWidth > 400) ? size.maxHeight * 0.8 : size.maxHeight,
            width: (size.maxWidth > 800)
                ? size.maxWidth * 0.5
                : (size.maxWidth > 400)
                    ? size.maxWidth * 0.7
                    : size.maxWidth,
            child: ListView(
              children: [
                storeListContainer,
                SizedBox(height: Dimensions.height20),
                BigText(
                  text: 'Near by Store',
                  size: Dimensions.font18,
                  weight: FontWeight.bold,
                ),
                SizedBox(height: Dimensions.height20),
                storeNearBy,
                SizedBox(height: Dimensions.height20),
              ],
            ),
          ),
        );
      });

  Widget get storeListContainer =>
      GetBuilder<StoreController>(builder: (storeController) {
        return Container(
          child: (storeController.storedetailList.isEmpty)
              ? InkWell(
                  onTap: () {
                    Get.toNamed(Routes.getAddStoreRoute());
                  },
                  child: SizedBox(
                    height: Dimensions.screenHeight * 0.2,
                    child: Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        decoration: BoxDecoration(
                            color: AppColor.appColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'Add Shop',
                          style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: storeController.storedetailList.length,
                  itemBuilder: (context, index) {
                    var item = storeController.storedetailList[index];
                    return InkWell(
                      onTap: () async {
                        SPFunction spFunction = SPFunction();
                        await spFunction.setString(
                            ConstantKey.storeIdKey,
                            storeController.storedetailList[index].userId
                                .toString());
                        await storeController.initalLoad(context);
                        Get.offNamedUntil(
                            Routes.getHomeRoute(), (route) => false);
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    cacheImage(
                                        image: item.logo ?? "",
                                        radius: 5,
                                        height: 50,
                                        width: 50),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name ?? "",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item.address ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: AppColor.tagColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 18,
                                        color: AppColor.white,
                                      ),
                                      Text(
                                        '${item.rating}',
                                        style: TextStyle(color: AppColor.white),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        );
      });
  Widget get storeNearBy =>
      GetBuilder<StoreController>(builder: (storeController) {
        return Container(
          child: (storeController.nearbyStore.isEmpty)
              ? SizedBox(
                  height: Dimensions.screenHeight * 0.3,
                  child: Center(
                      child: BigText(
                    text: 'No stores found near you',
                    size: Dimensions.font18,
                    color: AppColor.black,
                  )),
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: storeController.nearbyStore.length,
                  itemBuilder: (context, index) {
                    var item = storeController.nearbyStore[index];
                    return InkWell(
                      onTap: () {
                        storeController.initalLoad(context);
                        Get.offNamedUntil(
                            Routes.getHomeRoute(), (route) => false);
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    cacheImage(
                                        image: item.logo ?? "",
                                        radius: 5,
                                        height: 50,
                                        width: 50),
                                    SizedBox(width: Dimensions.width5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                            text: item.name ?? "",
                                            size: Dimensions.font18,
                                            color: AppColor.black,
                                            weight: FontWeight.bold,
                                          ),
                                          SmallText(
                                            text: item.address ?? "",
                                            size: Dimensions.font18,
                                            color: AppColor.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: Dimensions.width5),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColor.green,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: Dimensions.iconSize20,
                                      color: AppColor.white,
                                    ),
                                    SmallText(
                                      text: "${item.rating}",
                                      size: Dimensions.font18,
                                      color: AppColor.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        );
      });
}
