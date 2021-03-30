//package com.a2ztech.leefh2;
//
//import androidx.annotation.NonNull;
//import androidx.annotation.Nullable;
//import androidx.appcompat.app.AppCompatActivity;
//
//import android.app.Activity;
//import android.content.Context;
//import android.content.Intent;
//import android.graphics.Color;
//import android.net.ConnectivityManager;
//import android.os.Bundle;
//import android.util.Log;
//import android.view.Gravity;
//import android.view.View;
//import android.widget.EditText;
//import android.widget.ImageView;
//import android.widget.LinearLayout;
//import android.widget.RelativeLayout;
//import android.widget.TextView;
//import android.widget.Toast;
//
//import com.example.deliveryance.Common.Functions;
//import com.facebook.AccessToken;
//import com.facebook.CallbackManager;
//import com.facebook.FacebookCallback;
//import com.facebook.FacebookException;
//import com.facebook.FacebookSdk;
//import com.facebook.login.LoginManager;
//
//import com.example.deliveryance.Common.Constants;
//import com.example.deliveryance.Model.LoginPojo;
//import com.example.deliveryance.Session.SessionManager;
//import com.example.deliveryance.APIServices.APIClient;
//import com.example.deliveryance.APIServices.APIInterface;
//import com.facebook.login.LoginResult;
//import com.gmail.samehadar.iosdialog.IOSDialog;
//import com.google.android.gms.auth.api.signin.GoogleSignIn;
//import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
//import com.google.android.gms.auth.api.signin.GoogleSignInClient;
//import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
//import com.google.android.gms.common.api.ApiException;
//import com.google.android.gms.tasks.OnCompleteListener;
//import com.google.android.gms.tasks.Task;
//import com.google.android.material.snackbar.Snackbar;
//import com.google.firebase.auth.AuthCredential;
//import com.google.firebase.auth.AuthResult;
//import com.google.firebase.auth.FacebookAuthProvider;
//import com.google.firebase.auth.FirebaseAuth;
//import com.google.firebase.auth.FirebaseUser;
//import com.google.firebase.auth.GoogleAuthProvider;
//import com.hbb20.CountryCodePicker;
//
//import java.util.Collections;
//import java.util.HashMap;
//
//import butterknife.BindView;
//import butterknife.ButterKnife;
//import butterknife.OnClick;
//import es.dmoral.toasty.Toasty;
//import retrofit2.Call;
//import retrofit2.Callback;
//import retrofit2.Response;
//
//public class LoginActivitycc extends AppCompatActivity {
//
//    private static final String TAG = "LoginActivity";
//    private static final int MY_SMS_CODE = 186;
//    private static final int RC_SIGN_IN = 101;
//    @BindView(R.id.sign_in_txt)
//    TextView signInTxt;
//    @BindView(R.id.sign_up_txt)
//    TextView signUpTxt;
//    @BindView(R.id.login_phone_num_edt)
//    EditText loginPhoneNumEdt;
//    @BindView(R.id.login_password_edt)
//    EditText loginPasswordEdt;
//    @BindView(R.id.login_forgot_pswd_txt)
//    TextView loginForgotPswdTxt;
//    @BindView(R.id.sign_in_linear)
//    LinearLayout signInLinear;
//    @BindView(R.id.signup_phone_num_edt)
//    EditText signupPhoneNumEdt;
//    @BindView(R.id.sign_up_verified_txt)
//    TextView signUpVerifiedTxt;
//    @BindView(R.id.signup_email_edt)
//    EditText signupEmailEdt;
//    @BindView(R.id.signup_password_edt)
//    EditText signupPasswordEdt;
//    @BindView(R.id.signup_linear)
//    LinearLayout signupLinear;
//    @BindView(R.id.forgot_phone_num_edt)
//    EditText forgotPhoneNumEdt;
//    @BindView(R.id.forgot_linear)
//    LinearLayout forgotLinear;
//    @BindView(R.id.otp_mbl_num_txt)
//    TextView otpMblNumTxt;
//    @BindView(R.id.forgot_otp1_edt)
//    EditText forgotOtp1Edt;
//    @BindView(R.id.forgot_otp2_edt)
//    EditText forgotOtp2Edt;
//    @BindView(R.id.forgot_otp3_edt)
//    EditText forgotOtp3Edt;
//    @BindView(R.id.forgot_otp4_edt)
//    EditText forgotOtp4Edt;
//    @BindView(R.id.forgot_otp5_edt)
//    EditText forgotOtp5Edt;
//    @BindView(R.id.forgot_otp6_edt)
//    EditText forgotOtp6Edt;
//    @BindView(R.id.resend_otp_txt)
//    TextView resendOtpTxt;
//    @BindView(R.id.forgot_otp_linear)
//    LinearLayout forgotOtpLinear;
//    @BindView(R.id.forgot_new_password_edt)
//    EditText forgotNewPasswordEdt;
//    @BindView(R.id.forgot_confirm_password_edt)
//    EditText forgotConfirmPasswordEdt;
//    @BindView(R.id.forgot_new_pswd_linear)
//    LinearLayout forgotNewPswdLinear;
//    @BindView(R.id.signin_card_relative)
//    RelativeLayout signinCardRelative;
//    @BindView(R.id.card_relative)
//    RelativeLayout cardRelative;
//    @BindView(R.id.login_linear)
//    LinearLayout loginLinear;
//    @BindView(R.id.submit_txt)
//    TextView submitTxt;
//    @BindView(R.id.login_social_linear)
//    LinearLayout loginSocialLinear;
//    @BindView(R.id.social_googel_img)
//    TextView socialGoogelImg;
//    @BindView(R.id.social_fb_img)
//    TextView socialFbImg;
//
//    String lastCardStr = "";
//    String password;
//    String strFirebaseId;
//    APIInterface apiInterface;
//    SessionManager sessionManager;
//    @BindView(R.id.login_up_img)
//    ImageView loginUpImg;
//    @BindView(R.id.login_layout)
//    RelativeLayout loginLayout;
//    private String refreshedToken;
//    private String otpStr = "";
//    private String phoneStr = "";
//    private String verifiedMobile;
//    private boolean fromVerification;
//    private IOSDialog iosDialog;
//    @BindView(R.id.ccp)
//    CountryCodePicker ccp;
//    @BindView(R.id.ccp1)
//    CountryCodePicker ccp1;
//    @BindView(R.id.cc)
//    CountryCodePicker cc;
//
//    //Social Login
//    private FirebaseAuth mAuth;
//    // private GoogleSignInClient mGoogleSignInClient;
//    private GoogleSignInOptions gso;
//    public static int APP_REQUEST_CODE = 99;
//    public static int GOOGLE_REQUEST_CODE = 100;
//    public static int FORGOT_REQUEST_CODE = 199;
//    String phoneNumber = "";
//    FirebaseUser user;
//    String requredText;
//    String emailStr;
//    /*----------Facebook Login---------*/
//    // CallbackManager callbackManager;
//    String clickedValuefbGl = "";
//    private CallbackManager callbackManager;
//    GoogleSignInClient mGoogleSignInClient;
//
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_login);
//
//        Functions.initForOrientation(LoginActivitycc.this);
//
//        ButterKnife.bind(LoginActivitycc.this);
//        apiInterface = APIClient.getClient().create(APIInterface.class);
//        sessionManager = new SessionManager(LoginActivitycc.this);
//        mAuth = FirebaseAuth.getInstance();
//
//        iosDialog = new IOSDialog.Builder(this)
//                .setCancelable(false)
//                .setSpinnerClockwise(false)
//                .setMessageContentGravity(Gravity.END)
//                .setSpinnerColor(getResources().getColor(R.color.colorAccent))
//                .setTitle("Please Wait...")
//                .setTitleColor(Color.WHITE)
//                .build();
//
//        /*
//        Check Internet Connection
//         */
//        if (!Constants.checkInternetConnection(this)) {
//            Snackbar.make(findViewById(android.R.id.content), Constants.CHECK_NETWORK_ERROR, Snackbar.LENGTH_SHORT)
//                    .show();
//        }
//
//         /*
//        Facebook Initialization
//         */
//        FacebookSdk.sdkInitialize(getApplicationContext());
//        callbackManager = CallbackManager.Factory.create();
//
//         /*
//        Configure Google Sign In
//         */
//        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
//                .requestIdToken(getString(R.string.default_web_client_id))
//                .requestEmail()
//                .build();
//        mGoogleSignInClient = GoogleSignIn.getClient(this, gso);
//
//        visibilityChanges(Constants.Keywords.sign_in);
//    }
//
//    @OnClick({R.id.sign_in_txt, R.id.sign_up_txt, R.id.login_forgot_pswd_txt, R.id.otp_mbl_num_txt,
//            R.id.resend_otp_txt, R.id.sign_up_verified_txt, R.id.signup_phone_num_edt, R.id.submit_txt, R.id.social_googel_img, R.id.social_fb_img})
//    public void onViewClicked(View view) {
//        switch (view.getId()) {
//            case R.id.sign_in_txt:
//                visibilityChanges(Constants.Keywords.sign_in);
//                break;
//            case R.id.sign_up_txt:
//                fromVerification = false;
//                visibilityChanges(Constants.Keywords.sign_up);
//                break;
//            case R.id.login_forgot_pswd_txt:
//                lastCardStr = Constants.Keywords.forgot_pswd;
//                visibilityChanges(Constants.Keywords.forgot_pswd);
//                break;
//            case R.id.signup_phone_num_edt:
//                signupPhoneNumEdt.setError(null);
//                break;
//            case R.id.sign_up_verified_txt:
//                if (isNetworkConnected()) {
//                    if (!signUpVerifiedTxt.getText().toString().equalsIgnoreCase("Verified")) {
//
//                        Log.d(TAG, "onViewClicked: VerifyText");
//
//                        if (signupPhoneNumEdt.getText().toString().length() < 8) {
//
//                            Log.d(TAG, "onViewClicked: NumberNotValid");
//
//                            signupPhoneNumEdt.setError("Enter Valid Mobile Number", null);
//                        } else {
//
//                            Log.d(TAG, "onViewClicked: Mobile" + phoneNumber);
//                            phoneNumber = ccp.getSelectedCountryCodeWithPlus() + signupPhoneNumEdt.getText().toString();
//                            Log.v("FphoneNumber", phoneNumber + " ");
//                            Intent intent = new Intent(LoginActivitycc.this, OtpVerificationActivity.class);
//                            intent.putExtra("phonenumber", phoneNumber);
//                            startActivityForResult(intent, APP_REQUEST_CODE);
//                        }
//                    }
//                }
//                break;
//            case R.id.otp_mbl_num_txt:
//                if (lastCardStr.equalsIgnoreCase(Constants.Keywords.sign_up)) {
//                    visibilityChanges(Constants.Keywords.sign_up);
//                } else if (lastCardStr.equalsIgnoreCase(Constants.Keywords.forgot_pswd)) {
//                    visibilityChanges(Constants.Keywords.forgot_pswd);
//                }
//                break;
//            case R.id.resend_otp_txt:
//                resendOtpTxt.setVisibility(View.GONE);
//                HashMap<String, String> map = new HashMap<>();
//                map.put(Constants.Params.phone, phoneStr);
//                // jsonRequestOtp("send_otp", map);
//                break;
//            case R.id.submit_txt:
//                if (isNetworkConnected()) {
//                    submitBtn();
//                }
//                break;
//            case R.id.social_googel_img:
//                clickedValuefbGl = "1";
//                if (isNetworkConnected()) {
//                    signInWithGoogle();
//                }
//
//                break;
//            case R.id.social_fb_img:
//                clickedValuefbGl = "2";
//
//                if (isNetworkConnected()) {
//                    signInWithFacebook();
//                }
//                break;
//        }
//    }
//
//    private void signInWithGoogle() {
//        Intent signInIntent = mGoogleSignInClient.getSignInIntent();
//        startActivityForResult(signInIntent, 101);
//    }
//
//    private void signInWithFacebook() {
//         /*
//         Callback Facebook registration
//         */
//        LoginManager.getInstance().logInWithReadPermissions(LoginActivitycc.this, Collections.singleton("email"));//user_status, publish_actions..
//        LoginManager.getInstance().registerCallback(callbackManager, new FacebookCallback<LoginResult>() {
//            @Override
//            public void onSuccess(LoginResult loginResult) {
//                Log.d(TAG, "onSuccess: ");
//                handleFacebookAccessToken(loginResult.getAccessToken());
//            }
//
//            @Override
//            public void onCancel() {
//                Toast.makeText(LoginActivitycc.this, "Sign In canceled", Toast.LENGTH_SHORT).show();
//            }
//
//            @Override
//            public void onError(FacebookException error) {
//                Toast.makeText(LoginActivitycc.this, "Something bad happened", Toast.LENGTH_SHORT).show();
//            }
//        });
//
//
//    }
//
//    private void handleFacebookAccessToken(AccessToken token) {
//
//        AuthCredential credential = FacebookAuthProvider.getCredential(token.getToken());
//        mAuth.signInWithCredential(credential)
//                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
//                    @Override
//                    public void onComplete(@NonNull Task<AuthResult> task) {
//                        if (task.isSuccessful()) {
//                            FirebaseUser user = mAuth.getCurrentUser();
//                            if (AccessToken.getCurrentAccessToken() != null)
//                                if (user != null) {
//                                    String email = user.getEmail();
//                                    String name = user.getDisplayName();
//
//                                    String image = user.getPhotoUrl().toString();
//                                    String address = "facebook";
//                                    Log.d(TAG, "onComplete: " + email
//                                            + name + image + address);
//                                    //SignUpWithApi(email,"facebook","facebook",name,address);
//                                } else {
//                                    Toast.makeText(LoginActivitycc.this, "cant't access token", Toast.LENGTH_SHORT).show();
//
//                                }
//                        }
//                    }
//
//                });
//    }
//
//    public void visibilityChanges(String show) {
//
//        switch (show) {
//            case Constants.Keywords.sign_in:
//                loginPhoneNumEdt.setText("");
//                loginPasswordEdt.setText("");
//                signInLinear.setVisibility(View.VISIBLE);
//                signupLinear.setVisibility(View.GONE);
//                forgotLinear.setVisibility(View.GONE);
//                forgotOtpLinear.setVisibility(View.GONE);
//                forgotNewPswdLinear.setVisibility(View.GONE);
//                loginSocialLinear.setVisibility(View.VISIBLE);
//                signInTxt.setTextColor(Color.WHITE);
//                signUpTxt.setTextColor(getResources().getColor(R.color.lit_grey));
//                submitTxt.setText("Sign In");
//                loginUpImg.setImageResource(R.drawable.cocktails_bg);
//                break;
//            case Constants.Keywords.sign_up:
//                if (!fromVerification) {
//                    Log.e(TAG, "visibilityChanges:fromVerification " + fromVerification);
//                    signupPhoneNumEdt.setText("");
//                    signupEmailEdt.setText("");
//                    signupPasswordEdt.setText("");
//                }
//                lastCardStr = Constants.Keywords.sign_up;
//                signInLinear.setVisibility(View.GONE);
//                signupLinear.setVisibility(View.VISIBLE);
//                forgotLinear.setVisibility(View.GONE);
//                forgotOtpLinear.setVisibility(View.GONE);
//                forgotNewPswdLinear.setVisibility(View.GONE);
//                loginSocialLinear.setVisibility(View.GONE);
//                signUpTxt.setTextColor(Color.WHITE);
//                signInTxt.setTextColor(getResources().getColor(R.color.lit_grey));
//                submitTxt.setText("Sign Up");
//                loginUpImg.setImageResource(R.drawable.cocktails_bg);
//                break;
//            case Constants.Keywords.forgot_pswd:
//                lastCardStr = Constants.Keywords.forgot_pswd;
//                signInLinear.setVisibility(View.GONE);
//                signupLinear.setVisibility(View.GONE);
//                forgotLinear.setVisibility(View.VISIBLE);
//                forgotOtpLinear.setVisibility(View.GONE);
//                forgotNewPswdLinear.setVisibility(View.GONE);
//                loginSocialLinear.setVisibility(View.GONE);
//                submitTxt.setText("Get OTP");
//                loginUpImg.setImageResource(R.drawable.cocktails_bg);
//                break;
//            case Constants.Keywords.verification:
//                signupPhoneNumEdt.setError(null);
//                otpMblNumTxt.setText(phoneStr);
//                signInLinear.setVisibility(View.GONE);
//                signupLinear.setVisibility(View.GONE);
//                forgotLinear.setVisibility(View.GONE);
//                forgotOtpLinear.setVisibility(View.VISIBLE);
//                forgotNewPswdLinear.setVisibility(View.GONE);
//                loginSocialLinear.setVisibility(View.GONE);
//                submitTxt.setText("Verify");//Setting button name
//                loginUpImg.setImageResource(R.drawable.verification_up_img);
//                break;
//            case Constants.Keywords.new_pswd:
//                signInLinear.setVisibility(View.GONE);
//                signupLinear.setVisibility(View.GONE);
//                forgotLinear.setVisibility(View.GONE);
//                forgotOtpLinear.setVisibility(View.GONE);
//                forgotNewPswdLinear.setVisibility(View.VISIBLE);
//                loginSocialLinear.setVisibility(View.GONE);
//                submitTxt.setText("Next");
//                loginUpImg.setImageResource(R.drawable.new_pswd_up_img);
//                break;
//        }
//    }
//
//    public void submitBtn() {
//
//        //Login
//        if (signInLinear.getVisibility() == View.VISIBLE) {
//
//            if (loginPhoneNumEdt.getText().toString().length() < 5) {
//                loginPhoneNumEdt.setError("Enter valid Mobile Number");
//            } else if (loginPasswordEdt.getText().toString().length() < 6) {
//                loginPasswordEdt.setError("Enter Valid Password");
//            } else {
//                password = loginPasswordEdt.getText().toString().trim();
//                HashMap<String, String> map = new HashMap<>();
//                map.put("phone", cc.getSelectedCountryCodeWithPlus() +loginPhoneNumEdt.getText().toString().trim());
//                map.put("password", loginPasswordEdt.getText().toString().trim());
//                Log.d(TAG, "submitBtn: number"+cc.getSelectedCountryCodeWithPlus() +loginPhoneNumEdt.getText().toString().trim());
//                jsonLoginRegisterForgot("login", map);
//            }
//        }
//
//        //Signup
//        if (signupLinear.getVisibility() == View.VISIBLE) {
//
//            if (signupPhoneNumEdt.getText().toString().length() < 8) {
//                signupPhoneNumEdt.setError("Enter valid Mobile Number");
//            } else if (!signUpVerifiedTxt.getText().toString().equalsIgnoreCase("Verified")) {
//                // CommonFunctions.shortToast(getApplicationContext(), "Verify Your Phone Number");
//            }
//            else if (!Functions.isValidEmail(signupEmailEdt.getText().toString())) {
//                signupEmailEdt.setError("Enter Valid Email");
//            }
//            else if (signupPasswordEdt.getText().toString().length() < 5) {
//                signupPasswordEdt.setError("Enter Valid Password");
//            } else {
//                HashMap<String, String> map = new HashMap<>();
//                map.put("email", signupEmailEdt.getText().toString().trim());
//                map.put("password", signupPasswordEdt.getText().toString().trim());
//                map.put("phone", ccp.getSelectedCountryCodeWithPlus()+signupPhoneNumEdt.getText().toString().trim());
//                map.put("name", "");
//                map.put("image","");
//                jsonLoginRegisterForgot("register", map);
//
//                //                map.put("firebase_id", strFirebaseId);
//                Log.i(TAG, "register param: " + map);
//            }
//
//        }
//
//        //Forgot password
//        if (forgotLinear.getVisibility() == View.VISIBLE) {
//            fromVerification = true;
//            phoneStr = forgotPhoneNumEdt.getText().toString();
//            if (phoneStr.length() < 8) {
//                forgotPhoneNumEdt.setError("Valid Mobile Number");
//            } else {
//                               phoneNumber = ccp1.getSelectedCountryCodeWithPlus() + forgotPhoneNumEdt.getText().toString();
//                Log.v("phoneNumber", phoneNumber + " ");
//                Intent intent = new Intent(LoginActivitycc.this, OtpVerificationActivity.class);
//                intent.putExtra("phonenumber", phoneNumber);
//                intent.putExtra("from","forgot");
//                Log.d(TAG, "submitBtn:forgot ");
//                startActivity(intent);
//            }
////
//        } else if (forgotOtpLinear.getVisibility() == View.VISIBLE) { //OTP verificaton Linear
//            if (lastCardStr.equalsIgnoreCase(Constants.Keywords.sign_up)) {
//                confirmOtp();
//            } else if (lastCardStr.equalsIgnoreCase(Constants.Keywords.forgot_pswd)) {
//                 confirmOtp();
//            }
//
//        } else if (forgotNewPswdLinear.getVisibility() == View.VISIBLE) { //REset password screen
//            fromVerification = true;
//            String pswd1 = forgotNewPasswordEdt.getText().toString();
//            String pswd2 = forgotConfirmPasswordEdt.getText().toString();
//
//            if (pswd1.length() < 8) {
//                forgotNewPasswordEdt.setError("Enter Valid Password");
//            } else if (!pswd1.contentEquals(pswd2)) {
//                forgotConfirmPasswordEdt.setError("Password Mismatch");
//            }
//            else {
//                HashMap<String, String> map = new HashMap<>();
//                map.put(Constants.Params.phone, phoneStr);
//                map.put(Constants.Params.password, pswd1);
//                // jsonRequestOtp("reset_password", map);
//            }
//
//        }
//
//    }
//
//    public void confirmOtp() {
//
//        String otp1, otp2, otp3, otp4, otp5, otp6;
//        otp1 = forgotOtp1Edt.getText().toString().trim();
//        otp2 = forgotOtp2Edt.getText().toString().trim();
//        otp3 = forgotOtp3Edt.getText().toString().trim();
//        otp4 = forgotOtp4Edt.getText().toString().trim();
//        otp5 = forgotOtp5Edt.getText().toString().trim();
//        otp6 = forgotOtp6Edt.getText().toString().trim();
//
//        String otp_str = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
//        otp_str.trim();
//
//        if (otpStr.equalsIgnoreCase(otp_str)) {
//
//            Log.d(TAG, "confirmOtp: otpRecieved"+otp_str);
//
//            fromVerification =true;
//            if (lastCardStr.equalsIgnoreCase(Constants.Keywords.sign_up)) {
//                visibilityChanges(Constants.Keywords.sign_up);
//                clearVerificationCode();
//                signUpVerifiedTxt.setText("Verified");
//                verifiedMobile = phoneStr;
//                signUpVerifiedTxt.setError(null);
//                signUpVerifiedTxt.setTextColor(getResources().getColor(R.color.colorAccent));
//                signupPhoneNumEdt.setTag(signupPhoneNumEdt.getKeyListener());
////                signupPhoneNumEdt.setKeyListener(null);
//                //signupPhoneNumEdt.addTextChangedListener(this);
//            } else if (lastCardStr.equalsIgnoreCase(Constants.Keywords.forgot_pswd)) {
//                visibilityChanges(Constants.Keywords.new_pswd);
//            }
//
//        } else
//            Snackbar.make(findViewById(R.id.login_layout), "Enter Valid OTP", Snackbar.LENGTH_SHORT).show();
//
//
//    }
//    private void clearVerificationCode() {
//        forgotOtp1Edt.setText("");
//        forgotOtp2Edt.setText("");
//        forgotOtp3Edt.setText("");
//        forgotOtp4Edt.setText("");
//        forgotOtp5Edt.setText("");
//        forgotOtp6Edt.setText("");
//    }
//    public void jsonLoginRegisterForgot(String type, HashMap<String, String> map) {
//
//
//        iosDialog.show();
//        Call<LoginPojo> call = apiInterface.registerOrLoginApi(type, map);
//        call.enqueue(new Callback<LoginPojo>() {
//            @Override
//            public void onResponse(Call<LoginPojo> call, Response<LoginPojo> response) {
//
//                if (response.code() == 200) {
//
//                    if (response.body().isStatus()) {
//                        iosDialog.cancel();
//                        Toast.makeText(LoginActivitycc.this, "Success", Toast.LENGTH_SHORT).show();
//                        sessionManager.createLoginSession(response.body().getUser_id(),null,null,null,null,null,null);
//                       // Constants.Params.user_id=String.valueOf(response.body().getUser_id());
//                        Intent intent = new Intent(LoginActivitycc.this, HomeActivity.class);
//                        startActivity(intent);
//                        finish();
//                    }else {
//                        iosDialog.cancel();
//                        Toasty.error(LoginActivitycc.this,""+response.body().getMessage(),Toast.LENGTH_SHORT).show();
//                    }
//                } else {
//
//                    iosDialog.cancel();
//                    Toasty.error(LoginActivitycc.this,"SomeThing Went Wrong",Toast.LENGTH_SHORT).show();
//                }
//            }
//
//            @Override
//            public void onFailure(Call<LoginPojo> call, Throwable t) {
//                Log.e(TAG, "onFailure: " + t.getMessage());
//                iosDialog.cancel();
//                Toasty.error(LoginActivitycc.this,"Server Error",Toast.LENGTH_SHORT).show();
//
//            }
//        });
//    }
//
//    private void firebaseAuthWithGoogle(final GoogleSignInAccount account) {
//        AuthCredential credential = GoogleAuthProvider.getCredential(account.getIdToken(), null);
//        mAuth.signInWithCredential(credential)
//                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() {
//                    @Override
//                    public void onComplete(@NonNull Task<AuthResult> task) {
//                        if (task.isSuccessful()) {
//                            // Sign in success, update UI with the signed-in user's information
//                            FirebaseUser user = mAuth.getCurrentUser();
//
//                            Log.d("googlelogin", "onComplete: " + account.getEmail() + account.getDisplayName());
//
//                        } else {
//                            // If sign in fails, display a message to the user.
//                            Toast.makeText(LoginActivitycc.this, "Login failed", Toast.LENGTH_SHORT).show();
//                        }
//
//                        // ...
//                    }
//                });
//    }
//
//    @Override
//    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
//        super.onActivityResult(requestCode, resultCode, data);
//        if (requestCode == APP_REQUEST_CODE) {
//            if (resultCode == Activity.RESULT_OK) {
//                signUpVerifiedTxt.setText("Verified");
//                signUpVerifiedTxt.setEnabled(false);
//                loginPhoneNumEdt.setEnabled(false);
//                strFirebaseId = data.getStringExtra("firebaseId");
//            }
//
//        }
//        if (requestCode == 101) {
//            Task<GoogleSignInAccount> task = GoogleSignIn.getSignedInAccountFromIntent(data);
//            try {
//                // Google Sign In was successful, authenticate with Firebase
//                GoogleSignInAccount account = task.getResult(ApiException.class);
//                firebaseAuthWithGoogle(account);
//            } catch (ApiException e) {
//                // Google Sign In failed, update UI appropriately
//                // ...
//            }
//        }
//    }
//
//    //for internet connection
//
//    public boolean isNetworkConnected() {
//        ConnectivityManager cm = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
//
//        return cm.getActiveNetworkInfo() != null && cm.getActiveNetworkInfo().isConnected();
//
//
//    }
//}
