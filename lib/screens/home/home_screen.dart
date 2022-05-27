import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiendaweb/provider/homePro/home_provider.dart';
import 'package:tiendaweb/utils/colors.dart';

import '../../utils/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  final String shopId;
  const HomeScreen({Key? key, required this.shopId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double height = 0;
  double width = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar => AppBar(
        centerTitle: true,
        elevation: 0.4,
        flexibleSpace: Container(
          color: white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/logo.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Grocery',
                    style: TextStyle(color: black, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Category',
                    style: TextStyle(color: black, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'About',
                    style: TextStyle(color: black, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Contact Us',
                    style: TextStyle(color: black, fontSize: 15),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: black,
              )),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart, color: black)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person, color: black)),
          SizedBox(
            width: 10,
          )
        ],
      );

  Widget get body => ListView(
        children: [
          carousel,
          SizedBox(
            height: 10,
          ),
          offers,
          SizedBox(
            height: 10,
          ),
          categories,
          SizedBox(
            height: 10,
          ),
        ],
      );

  Widget get carousel =>
      Consumer<HomeProvider>(builder: (context, data, child) {
        return (data.sliders.isEmpty)
            ? Container()
            : CarouselSlider.builder(
                options: CarouselOptions(
                  height: height * 0.9,
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
                      height: height * 0.9,
                      width: width);
                },
              );
      });

  Widget get offers => Container(
        height: height * 0.2,
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                height: height * 0.16,
                width: height * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/placeholder.png'),
                  ),
                ),
              );
            }),
      );

  Widget get categories => Container(
        height: height * 0.1,
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                height: height * 0.8,
                width: height * 0.2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: itemColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add_business),
                    Text('Categories'),
                  ],
                ),
              );
            }),
      );
}
