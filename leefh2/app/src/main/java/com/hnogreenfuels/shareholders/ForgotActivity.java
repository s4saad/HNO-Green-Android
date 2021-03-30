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

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ForgotActivity extends AppCompatActivity {

    private EditText edtEmail;
    private EditText edtLastDigits;
    private EditText edtLastName;
    private Button btnVerify;
    private LinearLayout prForgot;
    private APIInterface apiInterface;
    private TextView tvLoginForgot;
    private TextView tvFirstTimeShareHolder;
    private TextView tvForgotEverthingF;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forgot);
        Functions.initForOrientation(ForgotActivity.this);

        apiInterface = APIClient.getClient().create(APIInterface.class);

        edtEmail = findViewById(R.id.edtEmailForgot);
        edtLastDigits = findViewById(R.id.edtLastDigitForgot);
        edtLastName = findViewById(R.id.edtLastNameForgot);
        btnVerify = findViewById(R.id.btnVerifyForgot);
        prForgot=findViewById(R.id.prForgot);
        tvLoginForgot=findViewById(R.id.tvLoginForgot);
        tvFirstTimeShareHolder=findViewById(R.id.tvFirstTimeShareHolder);
        tvForgotEverthingF=findViewById(R.id.tvForgotEverthingF);

        btnVerify.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!Functions.isEmpty(edtEmail)
                        && !Functions.isEmpty(edtLastDigits)
                        && !Functions.isEmpty(edtLastName))
                {
                    if (Functions.isValidEmail(edtEmail.getText()))
                    {
                        if (Constants.checkInternetConnection(ForgotActivity.this)){
                            jsonForgot(edtLastDigits.getText().toString(),edtLastName.getText().toString(),edtEmail.getText().toString());
                        }else {
                            Toast.makeText(ForgotActivity.this, "No internet connection", Toast.LENGTH_SHORT).show();
                        }

                    }else {
                        edtEmail.setError("Enter valid Email");
                    }

                }


                if (Functions.isEmpty(edtEmail))
                    edtEmail.setError("Enter Email");

                if (Functions.isEmpty(edtLastDigits))
                    edtLastDigits.setError("Enter Last Digit");

                if (Functions.isEmpty(edtLastName))
                    edtLastName.setError("Enter Last Name");
            }
        });


        tvLoginForgot.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(ForgotActivity.this,LoginActivity.class);
                startActivity(intent);
            }
        });

        tvFirstTimeShareHolder.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(ForgotActivity.this,FirstTimeShareHolderLoginActivity.class);
                startActivity(intent);
            }
        });

        tvForgotEverthingF.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(ForgotActivity.this,ForgotEverythingActivity.class);
                startActivity(intent);
            }
        });
    }

    public void jsonForgot(String ssn, String lastname,String email) {

        prForgot.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"forgot_password"+"&ssn="+ssn+"&lastname="+lastname+"&email="+email);
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("forgot>>", "onResponse: "+response.body().toString());

                prForgot.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){


                    Toast.makeText(ForgotActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }else {
                    Toast.makeText(ForgotActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }
}