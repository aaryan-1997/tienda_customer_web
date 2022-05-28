class CommonResponse {
  CommonResponse({
    this.result,
    this.message,
    this.combinedOrderId,
    this.discount,
  });

  bool? result;
  String? message;
  int? combinedOrderId;
  double? discount;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        result: json["result"],
        message: json["message"],
        combinedOrderId: json["combined_order_id"],
        discount: json["discount"],
      );
}
