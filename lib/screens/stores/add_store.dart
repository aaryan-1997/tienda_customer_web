import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/store_controller.dart';
import 'package:tiendaweb/widgets/big_text.dart';
import 'package:tiendaweb/widgets/small_text.dart';

import '../../utils/colors.dart';
import '../../utils/custom_loader.dart';
import '../../utils/custom_widgets.dart';
import '../../utils/dimension.dart';

class AddStore extends StatefulWidget {
  const AddStore({Key? key}) : super(key: key);

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: body,
    );
  }

  Widget get body => LayoutBuilder(builder: (context, size) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
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
            height: size.maxHeight * 0.85,
            width: size.maxWidth * 0.5,
            child: formLayout,
          ),
        );
      });

  Widget get formLayout => Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: (height > 800) ? height * 0.5 : height * 0.35,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/addShop.png'),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
            ),
            SizedBox(height: Dimensions.height20),
            BigText(
              text: "Shop ID",
              color: AppColor.black,
              size: Dimensions.font26,
              weight: FontWeight.bold,
            ),
            SizedBox(height: Dimensions.height20),
            textFieldName,
            SizedBox(height: Dimensions.height20),
            signButton,
          ],
        ),
      );

  Widget get textFieldName =>
      GetBuilder<StoreController>(builder: (storeController) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextFormField(
            controller: storeController.shopIdController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            textAlign: TextAlign.center,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(50)
            ],
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.store),
              hintText: 'Shop ID',
              border: border,
              enabledBorder: border,
              focusedBorder: enableBorder,
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Shop ID';
              } else if (storeController.shopIdController.text.trim() == '') {
                return 'Please enter Shop ID';
              } else {
                return null;
              }
            },
          ),
        );
      });

  Widget get signButton =>
      GetBuilder<StoreController>(builder: (storeController) {
        return Align(
          alignment: Alignment.center,
          child: (storeController.isLoading == true)
              ? CustomLoader()
              : InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await storeController.addStore().then((value) {
                        if (value) {
                          Get.back();
                        }
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColor.appColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30))),
                    child: SmallText(
                      text: "Continue",
                      color: AppColor.white,
                      size: Dimensions.font18,
                    ),
                  ),
                ),
        );
      });
}
