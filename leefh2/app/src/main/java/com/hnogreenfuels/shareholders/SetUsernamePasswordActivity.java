package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Common.Functions;
import com.hnogreenfuels.shareholders.Model.LoginModel;
import com.hnogreenfuels.shareholders.Session.SessionManager;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class SetUsernamePasswordActivity extends AppCompatActivity {

    private EditText userName,pinCode,password,confirmPassword;
    private Button btnLogin;
    private LinearLayout prSetUserNamePassword;
    private APIInterface apiInterface;
    private String apiKey,pincode;
    private SessionManager sessionManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_set_username_password);

        userName=findViewById(R.id.edtUsernameS);
        pinCode=findViewById(R.id.edtPinCodeS);
        password=findViewById(R.id.edtPasswordS);
        confirmPassword=findViewById(R.id.edtConfirmPasswordS);
        prSetUserNamePassword=findViewById(R.id.prSetUserNamePassword);
        btnLogin=findViewById(R.id.btnSetUsernamePassword);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(SetUsernamePasswordActivity.this);

        Intent intent=getIntent();
        if (intent!=null)
        {
            if (intent.getStringExtra("page")!=null&&intent.getStringExtra("page").equals("0"))
            {
                apiKey=intent.getStringExtra("api_key");
            }else {
                apiKey=intent.getStringExtra("api_key");
                pincode=intent.getStringExtra("pin_code");

                pinCode.setText(pincode);
                pinCode.setVisibility(View.GONE);

            }

        }

        btnLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (Functions.isEmpty(userName))
                    userName.setError("Enter Username");

                if (Functions.isEmpty(pinCode))
                    pinCode.setError("Enter Pin Code");

                if (Functions.isEmpty(password))
                    password.setError("Enter Password");

                if (!Functions.isEmpty(password)&&!Functions.isEmpty(pinCode)&&!Functions.isEmpty(userName))
                {
                    if (password.getText().toString().equals(confirmPassword.getText().toString())){
                        if (Constants.checkInternetConnection(SetUsernamePasswordActivity.this)){
                            jsonSetUserPassword();
                        }else {
                            Toast.makeText(SetUsernamePasswordActivity.this, "No internet connection", Toast.LENGTH_SHORT).show();
                        }

                    }else {
                        Toast.makeText(SetUsernamePasswordActivity.this, "Enter Same Password", Toast.LENGTH_SHORT).show();
                    }
                }


            }
        });
    }

    public void jsonSetUserPassword() {

        prSetUserNamePassword.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"set_username_password"+"&apikey="+apiKey+"&username="+userName.getText().toString()+"&pincode="+pinCode.getText().toString()+"&password="+password.getText().toString()+"&re_password="+confirmPassword.getText().toString());
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("forgot>>", "onResponse: "+response.body().toString());

                prSetUserNamePassword.setVisibility(View.GONE);
                Log.d("api_key", "onResponse: "+apiKey);
                if(response.body().getResponse_code()==0){

                    sessionManager.setApiKet(response.body().getData().getApi_key());
                    sessionManager.setUserId(response.body().getData().getUser_id());
                    sessionManager.setDisplayName(response.body().getData().getDisplay_name());
                    sessionManager.setLogin(true);

                    Intent intent =new Intent(SetUsernamePasswordActivity.this,DrawerActivity.class);
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(intent);
                    Toast.makeText(SetUsernamePasswordActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }else {
                    Toast.makeText(SetUsernamePasswordActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }

//    @Override
//    public boolean onKeyDown(int keyCode, KeyEvent event) {
//        if (keyCode == KeyEvent.KEYCODE_BACK) {
//            //preventing default implementation previous to android.os.Build.VERSION_CODES.ECLAIR
//            return true;
//        }
//        return super.onKeyDown(keyCode, event);
//    }
//
//    @Override
//    public void onBackPressed() {
////        super.onBackPressed();
//    }
}