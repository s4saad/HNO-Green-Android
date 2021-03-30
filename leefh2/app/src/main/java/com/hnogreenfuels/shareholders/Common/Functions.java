package com.hnogreenfuels.shareholders.Common;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.text.TextUtils;
import android.util.Patterns;
import android.widget.EditText;

import androidx.annotation.NonNull;

import java.io.File;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;

public class Functions {


    //Set Orientation
    public static void initForOrientation(Activity activity)
    {
        //set orientation for all activity
        activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
    }

    public static boolean isValidEmail(CharSequence email) {
        return (!TextUtils.isEmpty(email) && Patterns.EMAIL_ADDRESS.matcher(email).matches());
    }

    public static boolean isEmpty(EditText etText) {
        if (etText.getText().toString().trim().length() > 0)
            return false;

        return true;
    }


    public static void showLoadingDialog(Context context , ProgressDialog progress) {

        if (progress == null) {
            progress = new ProgressDialog(context);
            progress.setTitle("Loading");
            progress.setMessage("Please wait");
        }
        progress.show();
    }

    public static void dismissLoadingDialog(ProgressDialog progress,Context context) {
        progress = new ProgressDialog(context);
        if (progress != null && progress.isShowing()) {
            progress.dismiss();
        }
    }

    @NonNull
    public static RequestBody createPartFromString(String descriptionString) {
        return RequestBody.create(
                descriptionString, MultipartBody.FORM);
    }
    @NonNull
    public static MultipartBody.Part profileImage(String path) {
        File file = new File(path);
//        int videoSize = Integer.parseInt(String.valueOf(file.length() / 1024));
//        Log.d("imageSize", String.valueOf(videoSize));
        RequestBody requestFile = RequestBody.create(MediaType.parse("image/*"), file);
        return MultipartBody.Part.createFormData("image", file.getName(), requestFile);
    }

}
