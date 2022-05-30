class SliderModel {
  List<SliderDetail>? sliderList;
  bool? result;
  int? status;

  SliderModel({this.sliderList, this.result, this.status});

  SliderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      sliderList = <SliderDetail>[];
      json['data'].forEach((v) {
        sliderList!.add(SliderDetail.fromJson(v));
      });
    }
    result = json['result'];
    status = json['status'];
  }
}

class SliderDetail {
  String? sliderImage;
  String? sliderTitle;
  String? sliderTargetUrl;

  SliderDetail({this.sliderImage, this.sliderTitle, this.sliderTargetUrl});

  SliderDetail.fromJson(Map<String, dynamic> json) {
    sliderImage = json['slider_image'];
    sliderTitle = json['slider_title'];
    sliderTargetUrl = json['slider_target_url'];
  }
}
