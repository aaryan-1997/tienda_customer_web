import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:tiendaweb/model/homeModel/wishlist_response_model.dart';
import 'package:tiendaweb/repository/home_repo.dart';
import 'package:tiendaweb/model/homeModel/category_response.dart';
import 'package:tiendaweb/model/homeModel/product_response.dart';
import 'package:tiendaweb/model/homeModel/slider_model.dart';
import 'package:tiendaweb/utils/app_utils.dart';
import 'package:tiendaweb/utils/constant.dart';
import 'package:tiendaweb/utils/sp_function.dart';

import '../model/common_response.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;
  HomeController({required this.homeRepo});

  //===========
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<SliderDetail> _sliderList = [];
  List<SliderDetail> get sliderList => _sliderList;

  List<Category> _categoryList = [];
  List<Category> get categoryList => _categoryList;

  List<Product> _productList = <Product>[];
  List<Product> get productList => _productList;

  List<Product> _relatedProductList = <Product>[];
  List<Product> get relatedProductList => _relatedProductList;

  List<Product> _topSellingProductList = <Product>[];
  List<Product> get topSellingProductList => _topSellingProductList;

  List<Product> _categoryProductList = <Product>[];
  List<Product> get categoryProductList => _categoryProductList;

  // List<ProductVarient> _productVarient = [];
  // List<ProductVarient> get productVarient => _productVarient;

  List<WishlistProduct> _wishlistProduct = [];
  List<WishlistProduct> get wishlistProduct => _wishlistProduct;

  SPFunction spFunction = SPFunction();
  // XFile? pickedFile;

  Future<void> slider() async {
    var id = await spFunction.getString(ConstantKey.storeIdKey);
    var body = {"id": id};
    try {
      SliderModel response = await homeRepo.slider(body);
      if (response.result != null && response.result == true) {
        _sliderList = response.sliderList!;
      }
      update();
    } catch (e) {
      log("Home Slider Error===>" + e.toString());
    }
  }

  Future<void> category() async {
    var id = await spFunction.getString(ConstantKey.storeIdKey);
    var body = {"shopid": id};
    log(jsonEncode(body));
    try {
      CategoryResponse response = await homeRepo.category(body);
      if (response.success != null && response.success == true) {
        _categoryList = response.category!;
      }
      update();
    } catch (e) {
      log("Home Slider Error===>" + e.toString());
    }
  }

  Future<void> homeProduct() async {
    try {
      var storeId = await spFunction.getString(ConstantKey.storeIdKey);
      ProductResponse productResponse = await homeRepo.homeProduct(storeId);
      if (productResponse.success != null && productResponse.success == true) {
        _productList = productResponse.product!;
      }
      update();
    } catch (e) {
      log("Home Slider Error===>" + e.toString());
    }
  }

  // Future<void> productDetailById(String prodId) async {
  //   try {
  //     _productVarient = [];
  //     ProgressDialog.showProgressDialog(true);
  //     ProductVarientResponse productResponse =
  //         await homeRepo.productDetailById(prodId);
  //     ProgressDialog.hideProgressDialog();
  //     if (productResponse.success != null && productResponse.success == true) {
  //       _productVarient = productResponse.productVarient!;
  //     }
  //     update();
  //   } catch (e) {
  //     log("Product varient list Error===>" + e.toString());
  //   }
  // }

  Future<void> productByCategoryId(String catId) async {
    try {
      _isLoading = true;
      _categoryProductList = [];
      ProductResponse productResponse =
          await homeRepo.productByCategoryId(catId);
      if (productResponse.success != null && productResponse.success == true) {
        _categoryProductList = productResponse.product!;
      } else {
        _categoryProductList = [];
      }
    } catch (e) {
      log("Category Product list Error===>" + e.toString());
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
  }

  Future<void> getTopFromThisSellerProducts({String prodId = "0"}) async {
    try {
      ProductResponse productResponse =
          await homeRepo.getRelatedProducts(prodId);
      if (productResponse.success != null && productResponse.success == true) {
        _topSellingProductList = productResponse.product!;
      }
    } catch (e) {
      log("top selling Error===>" + e.toString());
    }
    update([_isLoading = false, _topSellingProductList]);
  }

  Future<void> getRelatedProducts({String prodId = "0"}) async {
    try {
      _isLoading = true;
      ProductResponse productResponse =
          await homeRepo.getRelatedProducts(prodId);
      if (productResponse.success != null && productResponse.success == true) {
        _relatedProductList = productResponse.product!;
      }
    } catch (e) {
      log("related product Error===>" + e.toString());
    }
    update([_isLoading = false, _relatedProductList]);
  }

//=====

  Future<void> getWishlistProduct() async {
    try {
      _isLoading = true;
      var storeId = await spFunction.getString(ConstantKey.storeIdKey);
      WishlistResponseModel response =
          await homeRepo.getWishlistProduct(storeId);
      if (response.result != null && response.result == true) {
        _wishlistProduct = response.wishlistProduct!;
      }
    } catch (e) {
      _isLoading = false;
      update();
      log("Get wishlist error" + e.toString());
    }
    _isLoading = false;
    update();
  }

  Future<void> addToWishList(String prodId) async {
    try {
      var storeId = await spFunction.getString(ConstantKey.storeIdKey);
      var body = {"shop_id": storeId, "product_id": prodId};
      CommonResponse commonResponse = await homeRepo.addToWishList(body);
      if (commonResponse.result != null && commonResponse.result == true) {
        homeProduct();
        getWishlistProduct();
        AppUtils().showSnackBar(message: commonResponse.message.toString());
      } else if (commonResponse.result != null &&
          commonResponse.result == false) {
        AppUtils().showSnackBar(message: commonResponse.message.toString());
      } else {
        AppUtils().showSnackBar(message: "Some error occure try later!");
      }
    } catch (e) {
      log("Add to wishlist error " + e.toString());
    }
  }

  Future<void> removeFromWishList(String prodId) async {
    try {
      var body = {"product_id": prodId};
      CommonResponse commonResponse = await homeRepo.removeFromWishList(body);
      if (commonResponse.result != null && commonResponse.result == true) {
        homeProduct();
        getWishlistProduct();
        AppUtils().showSnackBar(message: commonResponse.message.toString());
      } else if (commonResponse.result != null &&
          commonResponse.result == false) {
        AppUtils().showSnackBar(message: commonResponse.message.toString());
      } else {
        AppUtils().showSnackBar(message: "Some error occure try later!");
      }
    } catch (e) {
      log("Remove to wishlist error " + e.toString());
    }
  }
}
