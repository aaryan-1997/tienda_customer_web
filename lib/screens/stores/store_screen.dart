import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiendaweb/provider/shopPro/shop_provider.dart';
import 'package:tiendaweb/screens/home/home_screen.dart';
import 'package:tiendaweb/screens/stores/add_store.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:tiendaweb/utils/custom_widgets.dart';
import 'package:tiendaweb/utils/dimension.dart';

import '../../utils/colors.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  double height = 0;
  double width = 0;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _initFun();
    });
    super.initState();
  }

  _initFun() async {
    await Provider.of<ShopProvider>(context, listen: false)
        .fetchStore(context: context, isLoad: true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    debugPrint('===>>>   ${_pref.getString(accessTokenKey).toString()}');
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStore(),
                  ),
                ).then((value) async {
                  await Provider.of<ShopProvider>(context, listen: false)
                      .fetchStore(context: context, isLoad: true);
                });
              },
              icon: Icon(Icons.add_business_sharp)),
          IconButton(onPressed: () {}, icon: Icon(Icons.location_pin)),
          SizedBox(
            width: 10,
          )
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Near by Store',
                  style: TextStyle(
                    fontSize: size20 - 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                storeNearBy,
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      });

  Widget get storeListContainer =>
      Consumer<ShopProvider>(builder: (context, data, child) {
        return Container(
          child: (data.storeModel.isEmpty)
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddStore(),
                      ),
                    ).then((value) async {
                      await Provider.of<ShopProvider>(context, listen: false)
                          .fetchStore(context: context, isLoad: true);
                    });
                  },
                  child: SizedBox(
                    height: height * 0.2,
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
                  itemCount: data.storeModel.length,
                  itemBuilder: (context, index) {
                    var item = data.storeModel[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomeScreen(
                                shopId: item.userId.toString(),
                              ),
                            ),
                            (route) => false);
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
                                        image: item.logo,
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
                                            item.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item.address,
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
  Widget get storeNearBy => Container(
        child: (true)
            ? Container(
                height: height * 0.3,
                child: Center(
                  child: Text(
                    'No stores found near you',
                    style: TextStyle(
                        color: AppColor.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/image/logo.png',
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'data',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'datadsa asdsa d asdas ds asada sa a',
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
                                    '0',
                                    style: TextStyle(color: AppColor.white),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  );
                }),
      );
}
