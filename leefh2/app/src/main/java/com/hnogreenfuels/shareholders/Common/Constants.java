package com.hnogreenfuels.shareholders.Common;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

import com.hnogreenfuels.shareholders.Model.AdministratorModel;
import com.hnogreenfuels.shareholders.Model.LoginModel;

import java.util.List;

public class Constants {


    public static double CURRENT_LNG  ;
    public static  double CURRENT_LAT ;
    public static double NEW_LNG;
    public static double NEW_LAT;
    public static String NEW_ADDRESS;
    //    public static String BASE_URL = "http://deliveryance.sigitechnologies.com/public/api/";
    public static String BASE_URL = "https://shareholders.hnogreenfuels.com/api/android/?action=";


    public static String ImageURL = "https://deliveryance.sigitechnologies.com/public/images/restaurant_images/";
    public static String ImgCuisineURL = "https://deliveryance.sigitechnologies.com/public/images/cuisine/";
    public static String ImgProductURL = "https://deliveryance.sigitechnologies.com/public/Images/product_images/";
    public static String ImgProfileURL = "https://deliveryance.sigitechnologies.com/public/images/profile_images/";

    public static String dollarSign = "$ ";
    public static AdministratorModel.Data adminstratorDetails;
    public static List<LoginModel.Ppics_All> allPics;

    public static class Keywords {

        //these keywords used in login page to make different visibility of linear inside card
        public static final String sign_in = "signIn";//To display Signin page
        public static final String sign_up = "signUp";//To display Register page
        public static final String verification = "verification";//To show otp verification
        public static final String forgot_pswd = "forgotPswd";// To show forgot password geting phone number screen
        public static final String new_pswd = "newPswd";//To show reset password page


    }

    public static final String EXPANDED = "EXPANDED";
    public static final String COLLAPSED = "COLLAPSED";
    public static final String IDLE = "IDLE";
    public static final int CATEGORY = 0;
    public static final int FOOD_ITEMS = 1;

    public static class Params {
        public static String user_id = "user_id";
        public static String restaurant_id = "restaurant_id";
        public static String veg_only = "veg_only";
        public static String food_id = "food_id";
        public static String quantity = "quantity";
        public static String category_id = "category_id";
        public static String force_insert = "force_insert";
        public static String coupon_code = "coupon_code";
        public static String payment_str = "Amount";

        public static String item_total = "item_total";
        public static String offer_discount = "offer_discount";
        public static String restaurant_packaging_charge = "restaurant_packaging_charge";
        public static String gst = "gst";
        public static String delivery_charge = "delivery_charge";
        public static String bill_amount = "bill_amount";
        public static String paid_type = "paid_type";

        public static String phone = "phone";
        public static String login_type = "login_type";
        public static String device_token = "device_token";
        public static String password = "password";
        public static String email = "email";

        //Firebase
        public static String address = "address";
        public static String current_address = "current_address";
        public static String lng = "lng";
        public static String lat = "lat";
        public static String type = "type";
        public static String new_user_request = "new_user_request";
        public static String current_request = "current_request";
        public static String request_id = "request_id";
        public static String status = "status";

        public static String LatLng = "latLng";
        public static String longitude = "longitude";
        public static String latitude = "latitude";
        public static String prov_location = "prov_location";
        public static String device_type = "device_type";
        public static String landmark = "landmark";
        public static String flat_no = "flat_no";
        public static String is_veg = "is_veg";
        public static String id = "id";
        public static String name = "name";
        public static String profile_image = "profile_image";

    }

    public final static String CHECK_NETWORK_ERROR = "Check your network connection.";

    public static boolean checkInternetConnection(Context context) {
        ConnectivityManager connectivity = (ConnectivityManager) context
                .getSystemService(Context.CONNECTIVITY_SERVICE);
        if (connectivity == null) {
            return false;
        } else {
            NetworkInfo[] info = connectivity.getAllNetworkInfo();
            if (info != null) {
                for (NetworkInfo anInfo : info) {
                    if (anInfo.getState() == NetworkInfo.State.CONNECTED) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}
