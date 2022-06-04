import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiendaweb/screens/profile/component/product_card.dart';
import 'package:tiendaweb/utils/app_utils.dart';
import 'package:tiendaweb/utils/shimmer_helper.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../controllers/order_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimension.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/small_text.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  ScrollController scrollController = ScrollController();
  final OrderController _orderController = Get.find();
  @override
  void initState() {
    fetchOrder();
    super.initState();
  }

  fetchOrder() async {
    await _orderController.getOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        margin:
            EdgeInsets.only(top: Dimensions.height30, left: Dimensions.width45),
        child: BigText(
          text: "Order List",
          color: AppColor.black,
          size: Dimensions.font26,
        ),
      ),
      Expanded(
        child: GetBuilder<OrderController>(builder: (orderController) {
          return Container(
            margin: EdgeInsets.only(
                top: Dimensions.height20, left: Dimensions.width45),
            child: ListView.builder(
              controller: scrollController,
              itemCount: orderController.orderList.length,
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
                          Container(
                            margin: EdgeInsets.only(
                                top: Dimensions.height10,
                                left: Dimensions.width20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: Dimensions.height80,
                                      width: Dimensions.width80,
                                      decoration: BoxDecoration(
                                        color: AppColor.buttonColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius10 / 2),
                                      ),
                                      child: Icon(
                                        Icons.shopping_basket_outlined,
                                        color: AppColor.white,
                                        size: Dimensions.iconSize30,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    BigText(
                                      text:
                                          "Order Id #${orderController.orderList[index].code}",
                                      color: AppColor.black,
                                      size: Dimensions.font18,
                                    ),
                                    SizedBox(width: Dimensions.width20),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: Dimensions.height10,
                                      bottom: Dimensions.height10,
                                      left: Dimensions.width15,
                                      right: Dimensions.width15),
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width15,
                                      top: Dimensions.height10,
                                      right: Dimensions.width15),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    border: Border.all(
                                        color: AppColor.buttonColor,
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10 / 2),
                                  ),
                                  child: SmallText(
                                    text:
                                        "${orderController.orderList[index].deliveryStatusString}",
                                    color: AppColor.buttonColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: Dimensions.height20,
                              left: Dimensions.width20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SmallText(
                                          text: "Order Date :",
                                          color: AppColor.grey,
                                          size: Dimensions.font15,
                                        ),
                                        SizedBox(width: Dimensions.width15),
                                        SmallText(
                                          text:
                                              "${orderController.orderList[index].date}",
                                          color: AppColor.black,
                                          size: Dimensions.font15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.height15),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SmallText(
                                          text: "Order Amount :",
                                          color: AppColor.grey,
                                          size: Dimensions.font15,
                                        ),
                                        SizedBox(width: Dimensions.width15),
                                        SmallText(
                                          text:
                                              "${orderController.orderList[index].grandTotal}",
                                          color: AppColor.black,
                                          size: Dimensions.font15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: Dimensions.width140),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: BigText(
                                    textAlign: TextAlign.right,
                                    text:
                                        "${orderController.orderList[index].paymentType}",
                                    color: AppColor.green,
                                    size: Dimensions.font15,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                        ],
                      ),
                    ),
                    SizedBox(width: Dimensions.width30),
                    InkWell(
                      onTap: () async {
                        await orderController.getOrderDetail(
                            orderId:
                                orderController.orderList[index].id.toString());
                        //order detail dialog
                        orderDetail();
                      },
                      child: SmallText(
                        text: "Order Details",
                        color: AppColor.appColor,
                        size: Dimensions.font16,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: Dimensions.width30),
                    InkWell(
                      onTap: () async {
                        await orderController.getOrderTracking(
                            orderId:
                                orderController.orderList[index].id.toString());
                        orderTracking();
                      },
                      child: SmallText(
                        text: "Track Order",
                        color: AppColor.appColor,
                        size: Dimensions.font16,
                        textDecoration: TextDecoration.underline,
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        }),
      )
    ]);
  }
}

List<OrderStatusModel> orderStatus = [
  OrderStatusModel(status: "pending", statusString: "Pending"),
  OrderStatusModel(status: "confirmed", statusString: "Confirmed"),
  OrderStatusModel(status: "picked_up", statusString: "Picked"),
  OrderStatusModel(status: "on_the_way", statusString: "On the way"),
  OrderStatusModel(status: "cancelled", statusString: "Cancel"),
  OrderStatusModel(status: "delivered", statusString: "Delivered"),
];

orderDetail() => Get.dialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<OrderController>(builder: (orderController) {
            return AlertDialog(
              title: SmallText(
                text: "Order Items",
                color: AppColor.black,
                size: Dimensions.font16,
              ),
              content: SizedBox(
                width: Dimensions.screenWidth / 2.5,
                child: Column(
                  children: [
                    SizedBox(
                        height: Dimensions.height140,
                        child: orderController.isLoading &&
                                orderController.orderDetails.orderItems == null
                            ? SizedBox(
                                height: Dimensions.height120,
                                child: ShimmerHelper().buildListShimmer(
                                  itemCount: 4,
                                  itemHeight: Dimensions.height100,
                                  width: Dimensions.width60,
                                ),
                              )
                            : SizedBox(
                                height: Dimensions.height120,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width5),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: orderController
                                      .orderDetails.orderItems!.length,
                                  itemBuilder: (context, index) => ProductCard(
                                    imageUrl:
                                        "${orderController.orderDetails.orderItems![index].thumbnailImg}",
                                    name:
                                        "${orderController.orderDetails.orderItems![index].name}-${orderController.orderDetails.orderItems![index].variation}",
                                    price:
                                        "${orderController.orderDetails.orderItems![index].price}",
                                  ),
                                  separatorBuilder: (context, _) =>
                                      SizedBox(width: Dimensions.width5),
                                ),
                              )),
                    Container(
                      padding: EdgeInsets.only(
                        left: Dimensions.width10,
                        right: Dimensions.width10,
                        top: Dimensions.height15,
                        bottom: Dimensions.height15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          BigText(
                            text: "Order Status",
                            color: AppColor.appColor,
                            size: Dimensions.font15,
                          ),
                          orderController.isLoading
                              ? ShimmerHelper().buildBasicShimmer(
                                  height: Dimensions.height10,
                                  width: Dimensions.screenWidth / 2)
                              : BigText(
                                  text:
                                      "${orderController.orderDetails.deliveryStatusString}",
                                  color: AppColor.buttonColor,
                                  size: Dimensions.font15,
                                ),
                        ],
                      ),
                    ),
                    Material(
                      elevation: 2,
                      type: MaterialType.canvas,
                      shadowColor: AppColor.appColor.withOpacity(0.5),
                      color: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radius10), // if you need this
                        side: BorderSide(
                          color: AppColor.appColor.withOpacity(0.5),
                          width: 0.5,
                        ),
                      ),
                      child: Container(
                        width: Dimensions.screenWidth,
                        padding: EdgeInsets.only(
                          left: Dimensions.width10,
                          right: Dimensions.width10,
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15)),
                        child: Column(
                          children: [
                            orderController.isLoading
                                ? ShimmerHelper().buildBasicShimmer(
                                    height: Dimensions.height10,
                                    width: Dimensions.screenWidth)
                                : RowTextContainer(
                                    titleText: "Sub Total",
                                    valueText:
                                        "${orderController.orderDetails.subtotal}",
                                    size: Dimensions.font14,
                                  ),
                            SizedBox(height: Dimensions.height10),
                            orderController.isLoading
                                ? ShimmerHelper().buildBasicShimmer(
                                    height: Dimensions.height10,
                                    width: Dimensions.screenWidth)
                                : RowTextContainer(
                                    titleText: "Tax",
                                    valueText:
                                        "${orderController.orderDetails.tax}",
                                    size: Dimensions.font14,
                                    valueColor: AppColor.grey,
                                  ),
                            SizedBox(height: Dimensions.height10),
                            orderController.isLoading
                                ? ShimmerHelper().buildBasicShimmer(
                                    height: Dimensions.height10,
                                    width: Dimensions.screenWidth)
                                : RowTextContainer(
                                    titleText: "Discount",
                                    valueText:
                                        "${orderController.orderDetails.couponDiscount}",
                                    size: Dimensions.font14,
                                    valueColor: AppColor.grey,
                                  ),
                            SizedBox(height: Dimensions.height10),
                            orderController.isLoading
                                ? ShimmerHelper().buildBasicShimmer(
                                    height: Dimensions.height10,
                                    width: Dimensions.screenWidth)
                                : RowTextContainer(
                                    titleText: "Grand Total",
                                    valueText:
                                        "${orderController.orderDetails.grandTotal}",
                                    size: Dimensions.font14,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width10),
                      child: BigText(
                        text: "Customer Details",
                        size: Dimensions.font16,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: Dimensions.screenWidth,
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width10),
                      child: Column(
                        children: [
                          orderController.isLoading
                              ? ShimmerHelper().buildBasicShimmer(
                                  height: Dimensions.height10)
                              : CustomerAddressDetails(
                                  titleText: 'Name',
                                  valueText:
                                      "${orderController.orderDetails.shippingAddress?.name}",
                                  titeleColor: AppColor.grey,
                                  valueColor: AppColor.grey,
                                ),
                          SizedBox(height: Dimensions.height5),
                          orderController.isLoading
                              ? ShimmerHelper().buildBasicShimmer(
                                  height: Dimensions.height10)
                              : CustomerAddressDetails(
                                  titleText: 'Mobile',
                                  valueText:
                                      "${orderController.orderDetails.shippingAddress?.phone}",
                                  titeleColor: AppColor.grey,
                                  valueColor: AppColor.grey,
                                ),
                          SizedBox(height: Dimensions.height5),
                          orderController.isLoading
                              ? ShimmerHelper().buildBasicShimmer(
                                  height: Dimensions.height10)
                              : CustomerAddressDetails(
                                  titleText: 'Address',
                                  valueText:
                                      '${orderController.orderDetails.shippingAddress?.address}',
                                  titeleColor: AppColor.grey,
                                  valueColor: AppColor.grey,
                                ),
                          SizedBox(height: Dimensions.height5),
                          orderController.isLoading
                              ? ShimmerHelper().buildBasicShimmer(
                                  height: Dimensions.height10)
                              : CustomerAddressDetails(
                                  titleText: 'City',
                                  valueText:
                                      '${orderController.orderDetails.shippingAddress?.city}',
                                  titeleColor: AppColor.grey,
                                  valueColor: AppColor.grey,
                                ),
                          SizedBox(height: Dimensions.height5),
                          orderController.isLoading
                              ? ShimmerHelper().buildBasicShimmer(
                                  height: Dimensions.height10)
                              : CustomerAddressDetails(
                                  titleText: 'State',
                                  valueText:
                                      '${orderController.orderDetails.shippingAddress?.state}',
                                  titeleColor: AppColor.grey,
                                  valueColor: AppColor.grey,
                                ),
                          SizedBox(height: Dimensions.height5),
                          orderController.isLoading
                              ? ShimmerHelper().buildBasicShimmer(
                                  height: Dimensions.height10)
                              : CustomerAddressDetails(
                                  titleText: 'Pin Code',
                                  valueText:
                                      '${orderController.orderDetails.shippingAddress?.postalCode}',
                                  titeleColor: AppColor.grey,
                                  valueColor: AppColor.grey,
                                ),
                          SizedBox(height: Dimensions.height5),
                          orderController.isLoading
                              ? ShimmerHelper().buildBasicShimmer(
                                  height: Dimensions.height10)
                              : CustomerAddressDetails(
                                  titleText: 'Payment Method',
                                  valueText:
                                      '${orderController.orderDetails.paymentType}',
                                  titeleColor: AppColor.grey,
                                  valueColor: AppColor.grey,
                                ),
                        ],
                      ),
                    )
                  ],
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

orderTracking() => Get.dialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<OrderController>(builder: (orderController) {
            return AlertDialog(
              title: SmallText(
                text: "Order Status",
                color: AppColor.black,
                size: Dimensions.font16,
              ),
              content: Column(
                children: [
                  SizedBox(
                    height: Dimensions.screenHeight / 3,
                    width: Dimensions.screenWidth / 2,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: orderController.trackOrderList.length,
                        itemBuilder: (context, index) {
                          return TimelineTile(
                            axis: TimelineAxis.horizontal,
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            beforeLineStyle: LineStyle(
                                color: AppColor.grey,
                                thickness: Dimensions.width5 / 2),
                            indicatorStyle: IndicatorStyle(
                              indicatorXY: 0.3,
                              color: AppColor.appColor,
                              drawGap: true,
                              width: Dimensions.width20,
                              height: Dimensions.height20,
                            ),
                            isFirst: index == 0 ? true : false,
                            isLast: index ==
                                    orderController.trackOrderList.length - 1
                                ? true
                                : false,
                            endChild: Container(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width15,
                                  top: Dimensions.height15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SmallText(
                                    text: orderStatus
                                        .firstWhere((element) =>
                                            element.status ==
                                            orderController
                                                .trackOrderList[index]
                                                .deliveryStatus)
                                        .statusString
                                        .toString(),
                                    size: Dimensions.font12,
                                    color: AppColor.black,
                                    height: 1.5,
                                  ),
                                  SmallText(
                                    text:
                                        "${orderController.trackOrderList[index].updatedAt.toString().toDateTime}",
                                    size: Dimensions.font12,
                                    color: AppColor.black,
                                    height: 1.5,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    height: Dimensions.height45,
                    width: Dimensions.screenWidth / 4,
                    margin: EdgeInsets.only(
                        left: Dimensions.width30,
                        right: Dimensions.width30,
                        bottom: Dimensions.height20),
                    decoration: BoxDecoration(
                      color: AppColor.error,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: Center(
                      child: BigText(
                        text: "Cancel",
                        size: Dimensions.font18,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ],
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

class CustomerAddressDetails extends StatelessWidget {
  final String titleText;
  final String valueText;
  final Color titeleColor;
  final Color valueColor;
  final double titleSize;
  final double valueSize;
  const CustomerAddressDetails(
      {Key? key,
      required this.titleText,
      required this.valueText,
      this.titeleColor = Colors.black,
      this.valueColor = Colors.black,
      this.titleSize = 0,
      this.valueSize = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: Dimensions.width120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                text: titleText,
                color: titeleColor,
                size: titleSize == 0 ? Dimensions.font13 : titleSize,
              ),
              SizedBox(width: Dimensions.width10),
              SmallText(
                text: ":",
                color: AppColor.black,
                size: titleSize == 0 ? Dimensions.font13 : titleSize,
              ),
            ],
          ),
        ),
        SizedBox(width: Dimensions.width10),
        Expanded(
          child: BigText(
            text: valueText,
            color: valueColor,
            maxline: 3,
            size: valueSize == 0 ? Dimensions.font13 : valueSize,
          ),
        ),
      ],
    );
  }
}

class RowTextContainer extends StatelessWidget {
  final String titleText;
  final String valueText;
  final Color titleColor;
  final Color valueColor;
  final FontWeight weight;
  final double size;
  const RowTextContainer(
      {Key? key,
      required this.titleText,
      required this.valueText,
      this.titleColor = Colors.grey,
      this.valueColor = Colors.grey,
      this.weight = FontWeight.normal,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BigText(
          text: titleText,
          color: titleColor,
          weight: weight,
          size: size == 0 ? Dimensions.font13 : size,
        ),
        SmallText(
          text: valueText,
          color: valueColor,
          size: size == 0 ? Dimensions.font13 : size,
        ),
      ],
    );
  }
}

class OrderStatusModel {
  String? status;
  String? statusString;
  OrderStatusModel({this.status, this.statusString});
}
