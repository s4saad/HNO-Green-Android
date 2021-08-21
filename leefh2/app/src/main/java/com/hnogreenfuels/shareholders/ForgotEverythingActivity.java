package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.InputType;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
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

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ForgotEverythingActivity extends AppCompatActivity {

    private TextView tvLoginFE;
    private TextView tvFirstTimeShareHolderFE,emailDetail;
    private TextView tvForgotEverthingFE,questions,tvOR;
    private EditText lastName,taxId,ans,email;
    private Button btnFindShareholder,btnVerifyEmail;
    private APIInterface apiInterface;
    private LinearLayout prForgotEverything;
    private ArrayList questionList ;
    private ArrayAdapter<String> adapter;
    private int selected=-1;
    private ArrayList questionLisKey;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forgot_everything);
        Functions.initForOrientation(ForgotEverythingActivity.this);

        apiInterface = APIClient.getClient().create(APIInterface.class);

        tvLoginFE=findViewById(R.id.tvLoginFE);
        tvFirstTimeShareHolderFE=findViewById(R.id.tvFirstTimeShareHolderFE);
        tvForgotEverthingFE=findViewById(R.id.tvForgotEverthingFE);
        lastName=findViewById(R.id.edtLastNameFE);
        lastName.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        taxId=findViewById(R.id.edtTaxIDFE);
        taxId.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        ans=findViewById(R.id.edtAnsFE);
        ans.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        questions=findViewById(R.id.tvQuestionsFE);
        btnFindShareholder=findViewById(R.id.btnFindShareholder);
        prForgotEverything=findViewById(R.id.prForgotEverything);
        email=findViewById(R.id.edtEmailFE);
        email.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        emailDetail=findViewById(R.id.tvEmailMsg);
        btnVerifyEmail=findViewById(R.id.btnVerifyEmail);
        tvOR=findViewById(R.id.tvOR);

        questionList=new ArrayList();
        questionLisKey=new ArrayList();

        questions.setVisibility(View.GONE);
        ans.setVisibility(View.GONE);
        email.setVisibility(View.GONE);
        emailDetail.setVisibility(View.GONE);
        btnVerifyEmail.setVisibility(View.GONE);
        tvOR.setVisibility(View.GONE);

        questions.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new AlertDialog.Builder(ForgotEverythingActivity.this)
                        .setTitle("Questions")
                        .setAdapter(adapter, new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                                selected=which;
                                Log.d("TAG", "onClick: " + which);
                                questions.setText(questionList.get(which).toString());
                                if (which==1){

                                }
                                if (which==0){

                                }

                                dialog.dismiss();
                            }
                        }).create().show();
            }
        });

        btnFindShareholder.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (Functions.isEmpty(lastName))
                    lastName.setError("Enter Last Name");

                if (Functions.isEmpty(taxId))
                    taxId.setError("Enter Tax ID");
                if (!Functions.isEmpty(taxId)&&!Functions.isEmpty(taxId))
                {
                    if (selected==-1){
                        if (Constants.checkInternetConnection(ForgotEverythingActivity.this)){
                            jsonForgot();
                        }else {
                            Toast.makeText(ForgotEverythingActivity.this, "No internet connection", Toast.LENGTH_SHORT).show();
                        }

                    }else {
                        if (!Functions.isEmpty(ans) ){
                            jsonForgotWithQsAns();
                        }else {
                            ans.setError("Enter Answer");
                        }

                    }

                }

            }
        });

        btnVerifyEmail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if (Functions.isEmpty(email))
                    email.setError("Enter Email");

                if (!Functions.isEmpty(email))
                {
                    jsonVerifyEmail();
                }

            }
        });

        tvLoginFE.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(ForgotEverythingActivity.this,LoginActivity.class);
                startActivity(intent);
            }
        });

        tvFirstTimeShareHolderFE.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(ForgotEverythingActivity.this,FirstTimeShareHolderLoginActivity.class);
                startActivity(intent);
            }
        });

        tvForgotEverthingFE.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(ForgotEverythingActivity.this,ForgotActivity.class);
                startActivity(intent);
            }
        });
    }

    public void jsonForgot() {

        prForgotEverything.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"find_shareholder"+"&ssn="+taxId.getText().toString()+"&lastname="+lastName.getText().toString());
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("forgot>>", "onResponse: "+response.body().toString());

                prForgotEverything.setVisibility(View.GONE);

                if(response.body().getResponse_code()==200){

                    questions.setVisibility(View.VISIBLE);
                    ans.setVisibility(View.VISIBLE);
                    email.setVisibility(View.VISIBLE);
                    emailDetail.setVisibility(View.VISIBLE);
                    btnVerifyEmail.setVisibility(View.VISIBLE);
                    tvOR.setVisibility(View.VISIBLE);

                    for (int i=0;i<response.body().getData().getOptions().size();i++){
                        questionList.add(response.body().getData().getOptions().get(i).getName());
                    }

                    for (int i=0;i<response.body().getData().getOptions().size();i++){
                        questionLisKey.add(response.body().getData().getOptions().get(i).getKey());
                    }
                    adapter = new ArrayAdapter<String>(ForgotEverythingActivity.this,
                            android.R.layout.simple_spinner_dropdown_item, questionList);
                    emailDetail.setText(response.body().getData().getEmail_msg());
                    btnVerifyEmail.setText(response.body().getData().getEmail_button());

                    Toast.makeText(ForgotEverythingActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }else {
                    Toast.makeText(ForgotEverythingActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }
    public void jsonForgotWithQsAns() {

        prForgotEverything.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"find_shareholder"+"&ssn="+taxId.getText().toString()+"&lastname="+lastName.getText().toString()+"&"+questionLisKey.get(selected).toString()+"="+ans.getText().toString());
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("forgotEverything>>", "onResponse: "+response.body().toString());

                prForgotEverything.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){


                    Toast.makeText(ForgotEverythingActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();
                    Intent intent=new Intent(ForgotEverythingActivity.this,SetUsernamePasswordActivity.class);
                    intent.putExtra("api_key",response.body().getData().getApikey());
                    intent.putExtra("pin_code",String.valueOf(response.body().getData().getPincode()));
                    startActivity(intent);

                }else {
                    Toast.makeText(ForgotEverythingActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                    ans.setText("");
                    questions.setText("Questions");
                    questionList.clear();
                    for (int i=0;i<response.body().getData().getOptions().size();i++){
                        questionList.add(response.body().getData().getOptions().get(i).getName());
                    }

                    questionLisKey.clear();;
                    for (int i=0;i<response.body().getData().getOptions().size();i++){
                        questionLisKey.add(response.body().getData().getOptions().get(i).getKey());
                    }
                    adapter = new ArrayAdapter<String>(ForgotEverythingActivity.this,
                            android.R.layout.simple_spinner_dropdown_item, questionList);
                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }
    public void jsonVerifyEmail() {

        prForgotEverything.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"email_for_reset"+"&ssn="+taxId.getText().toString()+"&lastname="+lastName.getText().toString()+"&email="+email.getText().toString());
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("forgotEverything>>", "onResponse: "+response.body().toString());

                prForgotEverything.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){

                    Toast.makeText(ForgotEverythingActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();


                }else {
                    Toast.makeText(ForgotEverythingActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }
}