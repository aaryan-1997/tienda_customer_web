import 'dart:developer';

import 'package:get/get.dart';
import 'package:tiendaweb/api/api_service.dart';
import 'package:tiendaweb/api/app_constant.dart';
import 'package:tiendaweb/model/homeModel/category_response.dart';
import 'package:tiendaweb/model/homeModel/product_response.dart';
import 'package:tiendaweb/model/homeModel/slider_model.dart';
import 'package:tiendaweb/model/homeModel/wishlist_response_model.dart';

import '../model/common_response.dart';

class HomeRepo extends GetxService {
  ApiClient apiClient;
  HomeRepo({required this.apiClient});

  Future<SliderModel> slider(body) async {
    SliderModel sliderModel = SliderModel();

    try {
      Response response =
          await apiClient.postData(url: AppConstant.SLIDER, body: body);
      if (response.statusCode == 200) {
        sliderModel = SliderModel.fromJson(response.body);
      } else {}
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return sliderModel;
  }

  Future<CategoryResponse> category(body) async {
    CategoryResponse sliderModel = CategoryResponse();

    try {
      Response response =
          await apiClient.postData(url: AppConstant.CATEGORY, body: body);
      if (response.statusCode == 200) {
        sliderModel = CategoryResponse.fromJson(response.body);
      } else {}
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return sliderModel;
  }

  Future<ProductResponse> homeProduct(String storeId) async {
    ProductResponse productResponse = ProductResponse();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.HOME_PRODUCT + storeId);
      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        productResponse = ProductResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return productResponse;
  }

  // Future<ProductVarientResponse> productDetailById(String prodId) async {
  //   ProductVarientResponse productResponse = ProductVarientResponse();

  //   try {
  //     log("Product Id===>" + prodId);
  //     Response response =
  //         await apiClient.getData(AppConstant.PRODUCT_BY_ID + prodId);
  //     if (response.statusCode == 200) {
  //       productResponse = ProductVarientResponse.fromJson(response.body);
  //     } else if (response.statusCode == 400) {
  //       productResponse = ProductVarientResponse.fromJson(response.body);
  //     }
  //   } catch (e) {
  //     log("Error===>" + e.toString());
  //   }
  //   return productResponse;
  // }

  Future<ProductResponse> productByCategoryId(String catId) async {
    ProductResponse productResponse = ProductResponse();

    try {
      log("Category Id===>" + catId);
      Response response =
          await apiClient.getData(url: AppConstant.PRODUCT_BY_CAT_ID + catId);
      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        productResponse = ProductResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Error===>" + e.toString());
    }
    return productResponse;
  }

  // Future<VarientModel> getVariantWiseInfo(
  //     {String id = "0", color = '', variants = ''}) async {
  //   VarientModel varientModel = VarientModel();
  //   try {
  //     Response response = await apiClient.getData(AppConstant.PRODUCT_VARIENT +
  //         "id=$id&color=$color&variants=$variants");
  //     if (response.statusCode == 200) {
  //       varientModel = VarientModel.fromJson(response.body);
  //     }
  //   } catch (e) {
  //     log("Varient Error===>" + e.toString());
  //   }
  //   return varientModel;
  // }

  Future<ProductResponse> getRelatedProducts(String prodId) async {
    ProductResponse productResponse = ProductResponse();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.RELATED_PRODUCT + prodId);
      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        productResponse = ProductResponse.fromJson(response.body);
      } else if (response.statusCode == 404) {
        productResponse = ProductResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Error releted product" + e.toString());
    }
    return productResponse;
  }

  Future<ProductResponse> getTopFromThisSellerProducts(String prodId) async {
    ProductResponse productResponse = ProductResponse();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.TOP_SELLER_PRODUCT + prodId);
      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        productResponse = ProductResponse.fromJson(response.body);
      } else if (response.statusCode == 404) {
        productResponse = ProductResponse.fromJson(response.body);
      }
    } catch (e) {
      log("Error releted product" + e.toString());
    }
    return productResponse;
  }

  Future<CommonResponse> addToWishList(body) async {
    CommonResponse commonResponse = CommonResponse();
    try {
      Response response = await apiClient.postData(
          url: AppConstant.ADD_TO_WISHLIST, body: body);
      if (response.statusCode == 200) {
        commonResponse = CommonResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        commonResponse = CommonResponse.fromJson(response.body);
      } else {
        commonResponse = CommonResponse();
      }
    } catch (e) {
      log("Add to wishlist error " + e.toString());
    }
    return commonResponse;
  }

  Future<CommonResponse> removeFromWishList(body) async {
    CommonResponse commonResponse = CommonResponse();
    try {
      Response response = await apiClient.postData(
          url: AppConstant.REMOVE_WISHLIST, body: body);
      if (response.statusCode == 200) {
        commonResponse = CommonResponse.fromJson(response.body);
      } else if (response.statusCode == 400) {
        commonResponse = CommonResponse.fromJson(response.body);
      } else {
        commonResponse = CommonResponse();
      }
    } catch (e) {
      log("Add to wishlist error " + e.toString());
    }
    return commonResponse;
  }

  Future<WishlistResponseModel> getWishlistProduct(String shopId) async {
    WishlistResponseModel wishlistProductResponse = WishlistResponseModel();
    try {
      Response response =
          await apiClient.getData(url: AppConstant.GET_WISHLIST + shopId);
      if (response.statusCode == 200) {
        wishlistProductResponse = WishlistResponseModel.fromJson(response.body);
      } else if (response.statusCode == 400) {
        wishlistProductResponse = WishlistResponseModel.fromJson(response.body);
      } else {
        wishlistProductResponse = WishlistResponseModel();
      }
    } catch (e) {
      log("Get wishlist error " + e.toString());
    }
    return wishlistProductResponse;
  }
}
