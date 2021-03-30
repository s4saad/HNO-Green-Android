package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
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

public class FirstTimeShareHolderLoginActivity extends AppCompatActivity {

    private EditText lastName,temporaryPin,last4DigitTax;
    private APIInterface apiInterface;
    private SessionManager sessionManager;
    private LinearLayout prFirstTimeShareholder;
    private Button btnLoginFirstTime;
    private TextView tvForgotPassword,tvLogin,tvForgotEverything;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_first_time_share_holder_login);
        Functions.initForOrientation(FirstTimeShareHolderLoginActivity.this);

        lastName=findViewById(R.id.edtLastName);
        temporaryPin=findViewById(R.id.edtTemporaryPin);
        last4DigitTax=findViewById(R.id.edtTaxIDF);
        prFirstTimeShareholder=findViewById(R.id.prFirstTimeShareholder);
        btnLoginFirstTime=findViewById(R.id.btnLoginFirstTime);
        tvForgotPassword=findViewById(R.id.tvForgotPasswordFS);
        tvForgotEverything=findViewById(R.id.tvForgotEverthingFS);
        tvLogin=findViewById(R.id.tvLoginfFS);



        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(FirstTimeShareHolderLoginActivity.this);

        tvForgotPassword.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(FirstTimeShareHolderLoginActivity.this,ForgotActivity.class);
                startActivity(intent);
            }
        });
        tvForgotEverything.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(FirstTimeShareHolderLoginActivity.this,ForgotEverythingActivity.class);
                startActivity(intent);
            }
        });
        tvLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(FirstTimeShareHolderLoginActivity.this,LoginActivity.class);
                startActivity(intent);
            }
        });
        btnLoginFirstTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {


                if (Functions.isEmpty(lastName))
                    lastName.setError("Enter Last Name");

//                if (Functions.isEmpty(temporaryPin))
//                    temporaryPin.setError("Enter Pin");

                if (Functions.isEmpty(last4DigitTax))
                    last4DigitTax.setError("Enter Tax ID");

                if (!Functions.isEmpty(last4DigitTax)&&!Functions.isEmpty(lastName)){
                    if (Constants.checkInternetConnection(FirstTimeShareHolderLoginActivity.this)){
                        jsonLogin();
                    }else {
                        Toast.makeText(FirstTimeShareHolderLoginActivity.this, "No internet connection", Toast.LENGTH_SHORT).show();
                    }

                }

            }
        });
    }

    public void jsonLogin() {

        prFirstTimeShareholder.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"first_time_login"+"&ssn="+last4DigitTax.getText().toString()+"&lastname="+lastName.getText().toString()+"&pincode="+"1122");
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("login>>", "onResponse: "+response.body().toString());

                prFirstTimeShareholder.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){

                    Intent intent =new Intent(FirstTimeShareHolderLoginActivity.this,SetUsernamePasswordActivity.class);
                    intent.putExtra("api_key",response.body().getData().getApikey());
                    intent.putExtra("page","0");
                    startActivity(intent);

                }else {
                    Toast.makeText(FirstTimeShareHolderLoginActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }




}