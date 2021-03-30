package com.hnogreenfuels.shareholders.Session;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.preference.PreferenceManager;


import com.hnogreenfuels.shareholders.LoginActivity;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class SessionManager {
    public static final String POST_CODE_ID = "ID";
    public static String USER_LAT;
    public static String USER_LNG;
    private static final String TAG_TOKEN = "DeviceTocken";
    // Shared Preferences
    SharedPreferences pref;

    // Editor for Shared preferences
    Editor editor;


    // Context
    Context _context;

    // Shared pref mode
    int PRIVATE_MODE = 0;

    // Sharedpref file name
    private static final String PREF_NAME = "MyFod";

    // All Shared Preferences Keys
    private static final String IS_LOGIN = "IsLoggedIn";

    // User name (make variable public to access from outside)
    public static final String KEY_AUTH_TOKEN = "auth_token";

    //User Details

    public static final String KEY_USER_ID = "user_id";
    public static final String API_KEY = "api_key";
    public static final String DISPLAY_NAME = "display_name";
    public static final String Array = "array";
    public static final String qty = "qty";
    public static final String amount = "amount";
    public static final String KEY_USER_NAME = "user_name";
    public static final String KEY_USER_EMAIL = "user_email";
    public static final String KEY_USER_MOBILE = "user_mobile";
    public static final String KEY_USER_ADDRESS = "user_address";
    public static final String KEY_USER_IMAGE = "user_image";
    public static final String KEY_USER_PASSWORD = "user_password";
    public static final String KEY_USER_STRIPE_ID = "stripe_id";
    public static final String KEY_REFFERAL_CODE = "refferal_code";
    public static final String KEY_REFFERAL_LINK = "refferal_link";
    public static final String KEY_DISCOUNT = "discount_amount";
    public static final String KEY_CURRENCY = "currency";
    public static final String KEY_PAYMENTMODE = "payment_mode";


    // Constructor
    public SessionManager(Context context) {
        this._context = context;
        pref = _context.getSharedPreferences(PREF_NAME, PRIVATE_MODE);
        editor = pref.edit();
    }

    /**
     * Create login session
     */
    public void createLoginSession(int userId, String authToken, String userName, String userEmail,
                                   String userMob, String userImg, String password) {
        // Storing login value as TRUE
        editor.putBoolean(IS_LOGIN, true);

        // Storing name in pref
        editor.putString(KEY_USER_ID, String.valueOf(userId));
        editor.putString(KEY_AUTH_TOKEN, authToken);
        editor.putString(KEY_USER_NAME, userName);
        editor.putString(KEY_USER_EMAIL, userEmail);
        editor.putString(KEY_USER_MOBILE, userMob);
        editor.putString(KEY_USER_IMAGE, userImg);
        editor.putString(KEY_USER_PASSWORD, password);
        // commit changes
        editor.commit();
    }

    public void setUserId(String userId) {
        editor.putString(KEY_USER_ID, userId);
        editor.commit();
    }
    public void setLogin(Boolean status) {
        editor.putBoolean(IS_LOGIN, status);
        editor.commit();
    }

    public void setApiKet(String apiKey) {
        editor.putString(API_KEY, apiKey);
        editor.commit();
    }

    public void setDisplayName(String name) {
        editor.putString(DISPLAY_NAME, name);
        editor.commit();
    }

    public String getUserId() {
        return pref.getString(KEY_USER_ID, "");
    }
    public String getApiKey() {
        return pref.getString(API_KEY, "");
    }
    public String getDisplayName() {
        return pref.getString(DISPLAY_NAME, "");
    }

    public int getQty() {
        return pref.getInt(qty, 0);
    }

    public float getAmount() {
        return pref.getFloat(amount, 0);
    }


    public void setProductIdinArray(String userId) {
        Set<String> set = new HashSet<String>();
        set.add(userId);

        editor.putStringSet(Array, set);
        editor.commit();
    }



    public Set<String> getProductIdinArray()
    {
        return pref.getStringSet(Array, null);
    }


    /**
     * Check login method wil check user login status
     * If false it will redirect user to login page
     * Else won't do anything
     */
    public void checkLogin() {
        // Check login status
        if (!this.isLoggedIn()) {
            // user is not logged in redirect him to Login Activity
            Intent i = new Intent(_context, LoginActivity.class);
            // Closing all the Activities
            i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            // Add new Flag to start new Activity
            i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            // Staring Login Activity
            _context.startActivity(i);
        }

    }

    /**
     * Get stored session data
     */
    public HashMap<String, String> getUserDetails() {
        HashMap<String, String> user = new HashMap<String, String>();

        user.put(KEY_USER_ID, pref.getString(KEY_USER_ID, null));
        user.put(KEY_AUTH_TOKEN, pref.getString(KEY_AUTH_TOKEN, null));
        user.put(KEY_USER_NAME, pref.getString(KEY_USER_NAME, ""));
        user.put(KEY_USER_EMAIL, pref.getString(KEY_USER_EMAIL, null));
        user.put(KEY_USER_MOBILE, pref.getString(KEY_USER_MOBILE, null));
        user.put(KEY_USER_ADDRESS, pref.getString(KEY_USER_ADDRESS, null));
        user.put(KEY_USER_IMAGE, pref.getString(KEY_USER_IMAGE, null));
        user.put(KEY_USER_STRIPE_ID, pref.getString(KEY_USER_STRIPE_ID, null));
        user.put(KEY_REFFERAL_CODE, pref.getString(KEY_REFFERAL_CODE, ""));
        user.put(KEY_REFFERAL_LINK, pref.getString(KEY_REFFERAL_LINK, ""));
        user.put(KEY_USER_PASSWORD, pref.getString(KEY_USER_PASSWORD, ""));
        // return user
        return user;
    }


    /**
     * Get stored session data
     * Content-Type=application/json, clientId=8056359277, authToken=6571731612, authId=20
     */
    public HashMap<String, String> getHeader() {
        HashMap<String, String> header = new HashMap<String, String>();
//		header.put("Content-Type", pref.getString("application/json", "application/json"));
        /*header.put("authId", pref.getString(KEY_USER_ID, KEY_USER_ID));
        header.put("authToken", pref.getString(KEY_AUTH_TOKEN, KEY_AUTH_TOKEN));*/


        header.put("authId", pref.getString(KEY_USER_ID, "1"));
        header.put("authToken", pref.getString(KEY_AUTH_TOKEN, "s4nbp5FibJpfEY9q"));

        return header;
    }

    public void logout() {
        // Clearing all data from Shared Preferences
        editor.clear();
        editor.commit();

    }

    /**
     * Quick check for login
     **/
    // Get Login State
    public boolean isLoggedIn() {
        return pref.getBoolean(IS_LOGIN, false);
    }

    public String getCurrency() {
        /*return PreferenceManager.getDefaultSharedPreferences(_context).getString(KEY_CURRENCY, "र");*/
        return PreferenceManager.getDefaultSharedPreferences(_context).getString(KEY_CURRENCY, "$");
    }

    public void setCyrrency(String currency) {
        PreferenceManager.getDefaultSharedPreferences(_context).edit().putString(KEY_CURRENCY, currency).apply();
    }


    public String getPaymentMode() {
        SharedPreferences sharedPreferences = _context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        String address1 = sharedPreferences.getString(KEY_PAYMENTMODE, "");
        return address1;
    }

    public void setPaymentMode(String mode) {
        //PreferenceManager.getDefaultSharedPreferences(_context).edit().putString(KEY_PAYMENTMODE, mode).apply();

        SharedPreferences sharedPreferences = _context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        Editor editor = sharedPreferences.edit();
        editor.putString(KEY_PAYMENTMODE, mode);
        editor.apply();
    }


    //this method will save the device token to shared preferences
    public boolean saveDeviceToken(String token) {
        SharedPreferences sharedPreferences = (_context).getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        Editor editor = sharedPreferences.edit();
        editor.putString(TAG_TOKEN, token);
        editor.apply();
        return true;
    }

    public static void SaveAddress(Context context, String address) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        Editor editor = sharedPreferences.edit();
        editor.putString(KEY_USER_ADDRESS, address);
        editor.apply();

    }

    public String getAddress(Context context) {
        SharedPreferences sharedPreferences = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        String address1 = sharedPreferences.getString(KEY_USER_ADDRESS, "");
        return address1;
    }

    //this method will fetch the device token from shared preferences

}
