
import 'package:tiendaweb/api/api_url.dart';

class SliderModel {
  SliderModel({
    required this.sliderImage,
    required this.sliderTitle,
    required this.sliderTargetUrl,
  });

  String sliderImage;
  String sliderTitle;
  String sliderTargetUrl;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    sliderImage:Url.IMAGE_BASE_URL+ json["slider_image"],
    sliderTitle: json["slider_title"],
    sliderTargetUrl: json["slider_target_url"],
  );


}
