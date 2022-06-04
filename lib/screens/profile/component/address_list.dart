import 'dart:developer';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/controllers/address_controller.dart';
import 'package:tiendaweb/utils/colors.dart';
import 'package:tiendaweb/utils/dimension.dart';

import '../../../model/address/address_response_model.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/custom_text_field_with_boder.dart';
import '../../../widgets/small_text.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  ScrollController scrollController = ScrollController();
  final AddressController _addressController = Get.find();

  @override
  void initState() {
    fetchOrder();
    super.initState();
  }

  fetchOrder() async {
    await _addressController.getAddress();
    await _addressController.getState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        margin:
            EdgeInsets.only(top: Dimensions.height30, left: Dimensions.width45),
        child: BigText(
          text: "Address List",
          color: AppColor.black,
          size: Dimensions.font26,
        ),
      ),
      Expanded(
        child: GetBuilder<AddressController>(builder: (addressController) {
          return Container(
            margin: EdgeInsets.only(
                top: Dimensions.height20, left: Dimensions.width45),
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: addressController.addressList.length,
              itemBuilder: ((context, index) {
                return Row(
                  children: [
                    Material(
                      elevation: 3,
                      type: MaterialType.canvas,
                      shadowColor: AppColor.appColor.withOpacity(0.9),
                      color: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radius10), // if you need this
                        side: BorderSide.none,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AddressTile(
                              title: "Address",
                              value: addressController
                                  .addressList[index].address!),
                          AddressTile(
                              title: "City",
                              value: addressController
                                  .addressList[index].cityName!),
                          AddressTile(
                              title: "State",
                              value: addressController
                                  .addressList[index].stateName!),
                          AddressTile(
                              title: "Pin Code",
                              value: addressController
                                  .addressList[index].postalCode!),
                          AddressTile(
                              title: "Phone",
                              value:
                                  addressController.addressList[index].phone!),
                        ],
                      ),
                    ),
                    SizedBox(width: Dimensions.width30),
                    InkWell(
                      onTap: () {
                        addNewAddress();
                      },
                      child: SmallText(
                        text: "Add New Address",
                        color: AppColor.appColor,
                        size: Dimensions.font16,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: Dimensions.width30),
                    InkWell(
                      onTap: () async {
                        updateAddress(index);
                      },
                      child: SmallText(
                        text: "Update Address",
                        color: AppColor.appColor,
                        size: Dimensions.font16,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: Dimensions.width30),
                    InkWell(
                      onTap: () async {
                        Get.defaultDialog(
                            content: SmallText(
                              text: "Are you sure to delete this address?",
                              color: AppColor.grey,
                              size: Dimensions.font15,
                            ),
                            onCancel: () {},
                            confirmTextColor: AppColor.white,
                            onConfirm: () {
                              Navigator.pop(context);
                              addressController.deleteAddress(addressController
                                  .addressList[index].id
                                  .toString());
                            });
                      },
                      child: SmallText(
                        text: "Delete",
                        color: AppColor.appColor,
                        size: Dimensions.font16,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        }),
      ),
    ]);
  }
}

class AddressTile extends StatelessWidget {
  final String title;
  final String value;
  const AddressTile({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth / 3,
      margin: EdgeInsets.only(
          bottom: Dimensions.height10,
          top: Dimensions.height10,
          left: Dimensions.width10,
          right: Dimensions.width10),
      padding: EdgeInsets.only(bottom: Dimensions.height5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimensions.width80,
            child: BigText(
              text: title,
              color: AppColor.black,
              size: Dimensions.font18,
              weight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SizedBox(
              child: BigText(
                text: value,
                color: AppColor.grey,
                size: Dimensions.font18,
                maxline: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final GlobalKey<FormState> _formNewKey = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
updateAddress(index) {
  String stateLabel = "";
  String cityLabel = "";
  final AddressController _addressController = Get.find<AddressController>();
  Address _address = _addressController.addressList[index];
  _addressController.addressNameController.text = _address.address!;
  _addressController.mobileController.text = _address.phone!;
  _addressController.postalCodeController.text = _address.postalCode!;
  _addressController.stateController.text = _address.stateId.toString();
  stateLabel = _address.stateName.toString();
  _addressController.cityController.text = _address.cityId.toString();
  cityLabel = _address.cityName.toString();
  _addressController.latitudeController.text = _address.lat.toString();
  _addressController.longitudeController.text = _address.lang.toString();
  return Get.dialog(
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<AddressController>(builder: (addressController) {
          return AlertDialog(
            title: BigText(
              text: "Update Address",
              color: AppColor.black,
              size: Dimensions.font20,
              weight: FontWeight.bold,
            ),
            content: SizedBox(
              width: Dimensions.screenWidth / 2.5,
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(
                    right: Dimensions.width10,
                    left: Dimensions.width10,
                    top: Dimensions.height20,
                  ),
                  padding: EdgeInsets.only(
                    right: Dimensions.width10,
                    left: Dimensions.width10,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColor.appColor.withOpacity(0.10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Address",
                        size: Dimensions.font14,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height10),
                      CustomTextFieldWithBorder(
                        controller: addressController.addressNameController,
                        labelText: "Full Address",
                        readOnly: true,
                        keyboardType: TextInputType.name,
                        textCapital: TextCapitalization.characters,
                        validator: (value) {
                          if (value != null && value != "") {
                            return null;
                          } else {
                            return "Invalid address";
                          }
                        },
                        onTap: () {
                          // Get.toNamed(RouteHelper.getpredictLocationScreen())!
                          //     .then(
                          //   (value) => addressController.getLocation(),
                          // );
                        },
                        onSaved: (value) => addressController
                            .addressNameController.text = value.toString(),
                      ),
                      SizedBox(height: Dimensions.height10),
                      BigText(
                        text: "Phone",
                        size: Dimensions.font14,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height10),
                      CustomTextFieldWithBorder(
                        controller: addressController.mobileController,
                        labelText: "Phone Number",
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value != "") {
                            return null;
                          } else {
                            return "Invalid phone";
                          }
                        },
                        onSaved: (value) => addressController
                            .mobileController.text = value.toString(),
                      ),
                      SizedBox(height: Dimensions.height10),
                      BigText(
                        text: "State",
                        size: Dimensions.font14,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height10),
                      CustomSearchableDropDown(
                        items: addressController.stateList,
                        label: ' $stateLabel',
                        backgroundColor: AppColor.white,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius10 / 2)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Container(
                          margin: EdgeInsets.only(right: Dimensions.width10),
                          child: AppIcon(
                            icon: Icons.search,
                            backgroundColor: AppColor.white,
                            iconColor: AppColor.black,
                            size: Dimensions.font15,
                            iconSize: Dimensions.iconSize20,
                          ),
                        ),
                        dropDownMenuItems:
                            addressController.stateList.map((item) {
                          return item.name;
                        }).toList(),
                        onChanged: (value) async {
                          if (value != null) {
                            log(value.name);
                            addressController.stateController.text =
                                value.id.toString();
                            await addressController
                                .getCityByState(value.id.toString());
                          } else {}
                        },
                      ),
                      SizedBox(height: Dimensions.height10),
                      BigText(
                        text: "City",
                        size: Dimensions.font14,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height10),
                      CustomSearchableDropDown(
                        items: addressController.cityList,
                        label: ' $cityLabel',
                        backgroundColor: AppColor.white,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius10 / 2)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Container(
                          margin: EdgeInsets.only(right: Dimensions.width10),
                          child: AppIcon(
                            icon: Icons.search,
                            backgroundColor: AppColor.white,
                            iconColor: AppColor.black,
                            size: Dimensions.font15,
                            iconSize: Dimensions.iconSize20,
                          ),
                        ),
                        dropDownMenuItems:
                            addressController.cityList.map((item) {
                          return item.name;
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            log(value.name);
                            addressController.cityController.text =
                                value.id.toString();
                          } else {}
                        },
                      ),
                      SizedBox(height: Dimensions.height10), // Submit Button

                      BigText(
                        text: "Postal Code",
                        size: Dimensions.font14,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: Dimensions.height10),
                      CustomTextFieldWithBorder(
                        controller: addressController.postalCodeController,
                        labelText: "Postal Code",
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value != "") {
                            return null;
                          } else {
                            return "Invalid phone";
                          }
                        },
                        onSaved: (value) => addressController
                            .postalCodeController.text = value.toString(),
                      ),

                      Container(
                        padding: EdgeInsets.only(
                          bottom: Dimensions.height20,
                          top: Dimensions.height20,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await addressController
                                  .updateAddress(_address.id.toString());
                              Get.back();
                            }
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            padding: EdgeInsets.only(
                                right: Dimensions.width10,
                                left: Dimensions.width10,
                                top: Dimensions.height15,
                                bottom: Dimensions.height15),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                              color: AppColor.appColor,
                            ),
                            child: Center(
                              child: BigText(
                                text: 'Create',
                                size: Dimensions.font16,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () => Get.back(),
              ),
            ],
          );
        }),
      ],
    ),
  );
}

addNewAddress() => Get.dialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<AddressController>(builder: (addressController) {
            return AlertDialog(
              title: BigText(
                text: "New Address",
                color: AppColor.black,
                size: Dimensions.font20,
                weight: FontWeight.bold,
              ),
              content: SizedBox(
                width: Dimensions.screenWidth / 2.5,
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: Dimensions.width10,
                      left: Dimensions.width10,
                      top: Dimensions.height20,
                    ),
                    padding: EdgeInsets.only(
                      right: Dimensions.width10,
                      left: Dimensions.width10,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColor.appColor.withOpacity(0.10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "Address",
                          size: Dimensions.font14,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: Dimensions.height10),
                        CustomTextFieldWithBorder(
                          controller: addressController.addressNameController,
                          labelText: "Full Address",
                          readOnly: true,
                          keyboardType: TextInputType.name,
                          textCapital: TextCapitalization.characters,
                          validator: (value) {
                            if (value != null && value != "") {
                              return null;
                            } else {
                              return "Invalid address";
                            }
                          },
                          onTap: () {
                            // Get.toNamed(RouteHelper.getpredictLocationScreen())!
                            //     .then(
                            //   (value) => addressController.getLocation(),
                            // );
                          },
                          onSaved: (value) => addressController
                              .addressNameController.text = value.toString(),
                        ),
                        SizedBox(height: Dimensions.height10),
                        BigText(
                          text: "Phone",
                          size: Dimensions.font14,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: Dimensions.height10),
                        CustomTextFieldWithBorder(
                          controller: addressController.mobileController,
                          labelText: "Phone Number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value != null && value != "") {
                              return null;
                            } else {
                              return "Invalid phone";
                            }
                          },
                          onSaved: (value) => addressController
                              .mobileController.text = value.toString(),
                        ),
                        SizedBox(height: Dimensions.height10),
                        BigText(
                          text: "State",
                          size: Dimensions.font14,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: Dimensions.height10),
                        CustomSearchableDropDown(
                          items: addressController.stateList,
                          label: ' State',
                          backgroundColor: AppColor.white,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.radius10 / 2)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          prefixIcon: Container(
                            margin: EdgeInsets.only(right: Dimensions.width10),
                            child: AppIcon(
                              icon: Icons.search,
                              backgroundColor: AppColor.white,
                              iconColor: AppColor.black,
                              size: Dimensions.font15,
                              iconSize: Dimensions.iconSize20,
                            ),
                          ),
                          dropDownMenuItems:
                              addressController.stateList.map((item) {
                            return item.name;
                          }).toList(),
                          onChanged: (value) async {
                            if (value != null) {
                              log(value.name);
                              addressController.stateController.text =
                                  value.id.toString();
                              await addressController
                                  .getCityByState(value.id.toString());
                            } else {}
                          },
                        ),
                        SizedBox(height: Dimensions.height10),
                        BigText(
                          text: "City",
                          size: Dimensions.font14,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: Dimensions.height10),
                        CustomSearchableDropDown(
                          items: addressController.cityList,
                          label: ' City',
                          backgroundColor: AppColor.white,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.radius10 / 2)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          prefixIcon: Container(
                            margin: EdgeInsets.only(right: Dimensions.width10),
                            child: AppIcon(
                              icon: Icons.search,
                              backgroundColor: AppColor.white,
                              iconColor: AppColor.black,
                              size: Dimensions.font15,
                              iconSize: Dimensions.iconSize20,
                            ),
                          ),
                          dropDownMenuItems:
                              addressController.cityList.map((item) {
                            return item.name;
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              log(value.name);
                              addressController.cityController.text =
                                  value.id.toString();
                            } else {}
                          },
                        ),
                        SizedBox(height: Dimensions.height10), // Submit Button

                        BigText(
                          text: "Postal Code",
                          size: Dimensions.font14,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: Dimensions.height10),
                        CustomTextFieldWithBorder(
                          controller: addressController.postalCodeController,
                          labelText: "Postal Code",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value != null && value != "") {
                              return null;
                            } else {
                              return "Invalid phone";
                            }
                          },
                          onSaved: (value) => addressController
                              .postalCodeController.text = value.toString(),
                        ),

                        Container(
                          padding: EdgeInsets.only(
                            bottom: Dimensions.height20,
                            top: Dimensions.height20,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await addressController.addNewShippingAddress();
                                Get.back();
                              }
                            },
                            child: Container(
                              width: Dimensions.screenWidth / 2,
                              padding: EdgeInsets.only(
                                  right: Dimensions.width10,
                                  left: Dimensions.width10,
                                  top: Dimensions.height15,
                                  bottom: Dimensions.height15),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                color: AppColor.appColor,
                              ),
                              child: Center(
                                child: BigText(
                                  text: 'Create',
                                  size: Dimensions.font16,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () => Get.back(),
                ),
              ],
            );
          }),
        ],
      ),
    );
