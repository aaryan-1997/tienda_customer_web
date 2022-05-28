import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/shopPro/shop_provider.dart';
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
  final TextEditingController _shopController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoad = false;

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

  Widget get formLayout => Container(
        child: Form(
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
              SizedBox(
                height: 20,
              ),
              Text(
                'Shop ID',
                style: TextStyle(fontSize: size25),
              ),
              SizedBox(
                height: 20,
              ),
              textFieldName,
              SizedBox(
                height: 20,
              ),
              signButton,
            ],
          ),
        ),
      );

  Widget get textFieldName => Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextFormField(
          controller: _shopController,
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
            } else if (_shopController.text.trim() == '') {
              return 'Please enter Shop ID';
            } else {
              return null;
            }
          },
        ),
      );

  Widget get signButton => Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () async {
            /* await FirebaseMessaging.instance.getToken().then((value) {
              setState(() {
                fcmToken = value!;
              });
            });*/
            setState(() {
              isLoad = false;
            });
            if (_formKey.currentState!.validate()) {
              // context.read<ShopProvider>().addStore(context: context, isLoad: isLoad,id: _shopController.text)
              await Provider.of<ShopProvider>(context, listen: false)
                  .addStore(
                      context: context, isLoad: true, id: _shopController.text)
                  .then((value) {
                setState(() {
                  isLoad = false;
                });
                Navigator.pop(context, true);
              });
            } else {
              log('message');
              setState(() {
                isLoad = false;
              });
            }
          },
          child: (isLoad == true)
              ? CustomLoader()
              : Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColor.appColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: size20 - 2,
                    ),
                  ),
                ),
        ),
      );
}
