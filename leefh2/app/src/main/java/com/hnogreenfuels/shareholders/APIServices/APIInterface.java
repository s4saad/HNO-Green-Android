package com.hnogreenfuels.shareholders.APIServices;


import com.hnogreenfuels.shareholders.Model.AdministratorModel;
import com.hnogreenfuels.shareholders.Model.BuyShareModel;
import com.hnogreenfuels.shareholders.Model.ConfirmOrderModel;
import com.hnogreenfuels.shareholders.Model.GenetareOrderModel;
import com.hnogreenfuels.shareholders.Model.LoginModel;
import com.hnogreenfuels.shareholders.Model.ProfileModel;
import com.hnogreenfuels.shareholders.Model.ShareholderUpdates;
import com.hnogreenfuels.shareholders.Model.SummeryModel;
import com.hnogreenfuels.shareholders.Model.TransactionsModel;
import com.hnogreenfuels.shareholders.Model.pendingPurchaseModel;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.Map;

import retrofit2.Call;
import retrofit2.http.FieldMap;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;
import retrofit2.http.Url;

public interface APIInterface {

    @FormUrlEncoded
    @POST("{url}")
        // signup and login
    Call<LoginModel> registerOrLoginApi(@Path(value = "url", encoded = true) String type, @FieldMap Map<String, String> fields);

//    @POST("home_data")
//    Call<HomeScreenModel> RestaurestsApi();
//
//    @POST
//    Call<HomeScreenModel> NextUrl(@Url String url);
//
//    @POST("user_forgot_password")
//    Call<JsonElement> forgotPassword(@FieldMap HashMap<String, String> map);
//
//    @FormUrlEncoded
//    @POST("track_pendings_orders")
//    Call<TrackingModel> trackPendingOrders(@FieldMap HashMap<String, String> map);
//
//    @FormUrlEncoded
//    @POST("user_device_token")
//    Call<JsonElement> sedDeviceToken(@FieldMap HashMap<String, String> map);
//
//
//    @FormUrlEncoded
//    @POST("track_completed_orders")
//    Call<TrackingModel> trackCompletedOrders(@FieldMap HashMap<String, String> map);

    @FormUrlEncoded
    @POST("reviews_and_ratings")
    Call<JsonElement> submitReview(@FieldMap HashMap<String, String> map);


    @GET
    Call<LoginModel> login(@Url String url);

    @GET
    Call<AdministratorModel> Administrator(@Url String url);

    @GET
    Call<TransactionsModel> transactions(@Url String url);

    @GET
    Call<ShareholderUpdates> shareholderupdates(@Url String url);

    @GET
    Call<pendingPurchaseModel> pendingPurchases(@Url String url);

    @GET
    Call<BuyShareModel> pubShare(@Url String url);
    @GET
    Call<ProfileModel> getUsername(@Url String url);
    @GET
    Call<LoginModel> updateUserName(@Url String url);

    @GET
    Call<SummeryModel> summery(@Url String url);

    @GET
    Call<GenetareOrderModel> generateOrder(@Url String url);

    @GET
    Call<ConfirmOrderModel> confirmOrder(@Url String url);

    @GET
    Call<ProfileModel> profile(@Url String url);
//
//    @GET
//    Call<AboutRestaurantModel> restaurantAbout(@Url String url);
//
//
//    @GET("get_voucher")
//    Call<VoucherModel> getVoucher();
//
//    @GET("get_filters")
//    Call<FiltersModel> getFilters();
//
//
//    @GET
//    Call<SearchRestaurantModel> restaurantsOfSameCategories(@Url String url);
//
//
//    @Multipart
//    @POST("update_cart_details")
//    Call<JsonElement> updateCart(@PartMap HashMap<String, RequestBody> map);
//
//    @FormUrlEncoded
//    @POST("search_restaurant")
//    Call<SearchRestaurantModel> searchRestaurant(@FieldMap HashMap<String, String> map);
//
//    @FormUrlEncoded
//    @POST("search_filters")
//    Call<SearchRestaurantModel> searchFilters(@FieldMap HashMap<String, List> map);
//
//
//    @Multipart
//    @POST("add_to_cart")
//    Call<JsonElement> AddToCart(@PartMap HashMap<String, RequestBody> map);//,@PartMap HashMap<String, List<Integer>> arrayMap);
//
//    @Multipart
//    @POST("add_user_address")
//    Call<JsonElement> AddUserAddress(@PartMap HashMap<String, RequestBody> map);
//
//
//    @Multipart
//    @POST("place_orders")
//    Call<SuccessPojo> PlaceOrder(@PartMap HashMap<String, RequestBody> map);
//
//    @GET
//    Call<ProductDetailModel> ProductDetailApi(@Url String url);
//
//
//    @DELETE
//    Call<JsonElement> DeleteCartProduct(@Url String url);
//
//    @GET
//    Call<CartDetailModel> CartDetailModel(@Url String url);
//
//    @GET
//    Call<MyAddressesModel> myAddress(@Url String url);
//
//
//    @GET
//    Call<RestaurantDetailModel> RestaurantDetailApi(@Url String url);
//
//    @GET
//    Call<UserProfileModel> UserProfileApi(@Url String url);
//
//    @Multipart
//    @POST
//    Call<JsonElement> UpdateProfileApi(@Url String url, @PartMap HashMap<String, RequestBody> updateMap, @Part MultipartBody.Part profileImage);

//    @FormUrlEncoded
//    @POST("{url}")
//        //It user for Send OTP and ResetPassword
//    Call<SuccessPojo> sendOtp(@Path(value = "url", encoded = true) String type, @FieldMap Map<String, String> fields);
//
//    @GET("{url}")
//        //It user for Send OTP and ResetPassword
//    Call<SuccessPojo> logout(@Path(value = "url", encoded = true) String type, @HeaderMap Map<String, String> fields);
//
//    @GET("get_filter_list/{type}")
//    Call<FilterPojo> getFilter(@Path(value = "type", encoded = true) String type, @HeaderMap Map<String, String> header);
//
//    @FormUrlEncoded
//    @POST("search_restaurants")
//    Call<SearchRestaurantResponse> getSearchList(@HeaderMap HashMap<String, String> header, @Field("key_word") String searchName, @Field("lat") String latitude, @Field("lng") String longitude);
}