// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class AppConstant {
  static const String GOOGLE_API_KEY =
      'AIzaSyC44N6yERgjg8AM_UOznKlflcEZWYE8tro';
  static const String BASE_URL = 'https://tienda.thedigitalkranti.com';
  static const String IMAGE_BASE_URL =
      'https://tienda.thedigitalkranti.com/public/';
  static const String AUTH_API_VERSION = '/api/v2/auth';
  static const String API_VERSION = '/api/v2';
  //============
  static String ACCESS_TOKEN = "";

  //===========Auth===============confirm_code
  static const String CUSTOMER_LOGIN = AUTH_API_VERSION + "/customer-login";
  static const String CUSTOMER_SIGNUP = AUTH_API_VERSION + "/user-signup";
  //===
  static const String USER_INFO = API_VERSION + "/user/info";
  static const String UPDATE_USER = API_VERSION + "/profile/update";
  static const String UPDATE_PROFILE_IMAGE =
      API_VERSION + "/profile/image-upload";

  static const String OTP_VERIFY = AUTH_API_VERSION + "/confirm_code";
  static const String RESEND_OTP = AUTH_API_VERSION + "/resend_code";
  static const String QRCODE = API_VERSION + "/shop/scan/details/";
  static const String SHOPLIST = API_VERSION + "/shop/scanned/stores";
  static const String NEARSHOP = API_VERSION + "/shop/near";
  static const String SLIDER = API_VERSION + "/sliders";

  //====
  static const String CATEGORY = API_VERSION + "/categories/shop-wise";
  static const String HOME_PRODUCT = API_VERSION + "/products/home/";
  static const String PRODUCT_BY_ID = API_VERSION + "/products/";
  static const String PRODUCT_BY_CAT_ID = API_VERSION + "/products/category/";
  static const String RELATED_PRODUCT = API_VERSION + "/products/related/";
  static const String TOP_SELLER_PRODUCT =
      API_VERSION + "/products/top-from-seller/";
  static const String PRODUCT_VARIENT =
      API_VERSION + "/products/variant/price?";

  //==== cart
  static const String ADD_TO_CART = API_VERSION + "/carts/add";
  static const String GET_TO_CART = API_VERSION + "/carts/";
  static const String CHANGE_CART_QTY = API_VERSION + "/carts/change-quantity";
  static const String CART_SUMMERY = API_VERSION + "/cart-summary";

  //==== Payment payment-types
  static const String PAYMENT_TYPE = API_VERSION + "/payment-types";

  //==== Order
  static const String PLACE_ORDER = API_VERSION + "/order/store";
  static const String TRACK_ORDER = API_VERSION + "/order/track/";

  //==== Coupon
  static const String APPLY_COUPON = API_VERSION + "/coupon/apply";
  static const String REMOVE_COUPON = API_VERSION + "/coupon-remove";

  //=====user Address
  static const String STATE = API_VERSION + "/states";
  static const String CITY_BY_STATE = API_VERSION + "/cities-by-state/";
  static const String CREATE_ADDRESS = API_VERSION + "/user/shipping/create";
  static const String UPDATE_ADDRESS = API_VERSION + "/user/shipping/update";
  static const String GET_ADDRESS = API_VERSION + "/user/shipping/address";
  static const String MAKE_DEFAULT_ADDRESS =
      API_VERSION + "/user/shipping/make_default";
  static const String UPDATE_CART_ADDRESS =
      API_VERSION + "/update-address-in-cart";
  static const String DELETE_ADDRESS = API_VERSION + "/user/shipping/delete/";

  //=====
  static const String PURCHASE_HISTORY = API_VERSION + "/purchase-history";
  static const String PURCHASE_HISTORY_DETAIL =
      API_VERSION + "/purchase-history-details/";
  static const String PURCHASE_ITEMS = API_VERSION + "/purchase-history-items/";
  //=====
  static const String WEB_VIEW_PAGES = API_VERSION + "/pages/customer";

  //===Wishlist
  static const String ADD_TO_WISHLIST = API_VERSION + "/wishlists-add-product";
  static const String GET_WISHLIST = API_VERSION + "/wishlists/user-wishlist/";
  static const String REMOVE_WISHLIST =
      API_VERSION + "/wishlists-remove-product";
  static const String REMOVE_ALL_WISHLIST =
      API_VERSION + "/wishlists-remove-product";

  static const String UPLOAD_PRESCRIPTION =
      API_VERSION + "/prescription/upload";
  static const String PRESCRIPTION_LIST =
      API_VERSION + "/prescription/list/customer/";
}
