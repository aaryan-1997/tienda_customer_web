import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/auth_controller.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/custom_app_bar.dart';
import 'package:tiendaweb/utils/dimension.dart';
import 'package:tiendaweb/widgets/app_icon.dart';
import 'package:tiendaweb/widgets/small_text.dart';

import 'component/address_list.dart';
import 'component/order_list.dart';

class ProfileScreen extends StatefulWidget {
 
  const ProfileScreen({Key? key, }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   int selectedIndex=0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>().getUserDetails();
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: appBar,
      body: body,
    );
  }

  Widget get body => Row(
        children: [
          Expanded(child: profileCard),
          Expanded(flex: 4, child: mainBody.elementAt(selectedIndex)),
        ],
      );

  List<Widget> mainBody = [
    OrderList(),
    AddressList(),
    history,
    termCondition,
  ];

  Widget get profileCard => Drawer(
        backgroundColor: AppColor.white,
        elevation: 1,
        child: GetBuilder<AuthController>(builder: (authController) {
          return ListView(
            children: [
              DrawerHeader(
                child: Image.network(GetUtils.isNullOrBlank(
                            authController.userDetail.avatarOriginal) ==
                        false
                    ? authController.userDetail.avatarOriginal.toString()
                    : "https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png"),
              ),
              Container(
                alignment: Alignment.center,
                child: SmallText(
                  text: authController.userDetail.avatarOriginal ?? "",
                  color: AppColor.black,
                  size: Dimensions.font16,
                ),
              ),
              SizedBox(height: Dimensions.height10),
              SideMenuTile(
                  title: "My Orders",
                  icon: Icons.card_travel,
                  ontap: () {
                    setState(() => selectedIndex = 0);
                  }),
              SideMenuTile(
                  title: "My Address",
                  icon: Icons.location_pin,
                  ontap: () {
                    setState(() => selectedIndex = 1);
                  }),
              SideMenuTile(
                  title: "History",
                  icon: Icons.history,
                  ontap: () {
                    setState(() => selectedIndex = 2);
                  }),
              SideMenuTile(
                  title: "Term & Condition",
                  icon: Icons.privacy_tip,
                  ontap: () {
                    setState(() => selectedIndex = 3);
                  }),
            ],
          );
        }),
      );
}

Widget get history => Column(children: [
      SmallText(
        text: "History List",
        color: AppColor.black,
      )
    ]);
Widget get termCondition => Column(children: [
      SmallText(
        text: "Term & Condition",
        color: AppColor.black,
      )
    ]);

class SideMenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback ontap;
  const SideMenuTile(
      {Key? key, required this.title, required this.icon, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height10,
          left: Dimensions.width10,
          right: Dimensions.width10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10)),
      child: ListTile(
        tileColor: AppColor.appColor,
        contentPadding: EdgeInsets.only(left: Dimensions.width5),
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(Dimensions.radius10)),
        leading: AppIcon(
          icon: icon,
          iconSize: Dimensions.iconSize20,
          backgroundColor: AppColor.white,
        ),
        selectedTileColor: AppColor.appColor,
        title: SmallText(
          text: title,
          color: AppColor.white,
          size: Dimensions.font18,
        ),
        onTap: ontap,
      ),
    );
  }
}
