package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.Window;
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

public class LoginActivity extends AppCompatActivity {

    private APIInterface apiInterface;
    private EditText edtLogin;
    private EditText edtPassword;
    private Button btnLogin;
    private SessionManager sessionManager;
    private LinearLayout prLogin;
    private TextView tvForgotPassword;
    private TextView tvForgotEverthing;
    private TextView tvSignUpL;
    private String version="1";
    private TextView tvFirstTimeLogin;
    private String acknowledge;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        Functions.initForOrientation(LoginActivity.this);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(LoginActivity.this);

        edtLogin=findViewById(R.id.edtLogin);
        edtPassword=findViewById(R.id.edtPassword);
        btnLogin=findViewById(R.id.btnLogin);
        prLogin=findViewById(R.id.prLogin);
        tvForgotPassword=findViewById(R.id.tvForgotPassword);
        tvForgotEverthing=findViewById(R.id.tvForgotEverthing);
        tvSignUpL=findViewById(R.id.tvSignUpL);
        tvFirstTimeLogin=findViewById(R.id.tvFirstTimeLogin);

        tvFirstTimeLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(LoginActivity.this,FirstTimeShareHolderLoginActivity.class);
                startActivity(intent);
            }
        });

        btnLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!Functions.isEmpty(edtLogin)&&!Functions.isEmpty(edtPassword)){
                    if (Constants.checkInternetConnection(LoginActivity.this)){
                        jsonLogin(edtLogin.getText().toString(),edtPassword.getText().toString());
                    }else {
                        Toast.makeText(LoginActivity.this, "No internet connection", Toast.LENGTH_SHORT).show();
                    }
                }


                if (Functions.isEmpty(edtLogin))
                    edtLogin.setError("Enter Username");

                if(Functions.isEmpty(edtPassword))
                    edtPassword.setError("Enter Password");
            }
        });

        tvForgotPassword.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LoginActivity.this,ForgotActivity.class);
                startActivity(intent);
            }
        });


        tvForgotEverthing.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LoginActivity.this,ForgotEverythingActivity.class);
                startActivity(intent);
            }
        });

        tvSignUpL.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AlertDialog.Builder builder = new AlertDialog.Builder(LoginActivity.this);

                builder.setTitle("Acknowledge");
                builder.setMessage(acknowledge);

                builder.setPositiveButton("I Acknowledge", new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialog, int which) {
                        // Do nothing but close the dialog
                        Intent intent = new Intent(LoginActivity.this,SignupActivity.class);
                        startActivity(intent);
                        dialog.dismiss();


                    }
                });

                builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {

                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                        // Do nothing
                        dialog.dismiss();
                    }
                });

                AlertDialog alert = builder.create();
                alert.show();

            }
        });

        if (Constants.checkInternetConnection(LoginActivity.this)){
            jsonVersionCheck();
        }else {
            Toast.makeText(LoginActivity.this, "No internet connection", Toast.LENGTH_SHORT).show();
        }

    }


    public void jsonLogin(String username, final String password) {


        prLogin.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"login"+"&username="+username+"&password="+password);
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("login>>", "onResponse: "+response.body().toString());
                Log.d("Data>>>", "onResponse: "+response.body().getData());
                Log.d("response_code>>>", "onResponse: "+response.body().getResponse_code());
                Log.d("response_msg>>>", "onResponse: "+response.body().getResponse_msg());

                prLogin.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){

                    sessionManager.setApiKet(response.body().getData().getApi_key());
                    sessionManager.setUserId(response.body().getData().getUser_id());
                    sessionManager.setDisplayName(response.body().getData().getDisplay_name());
                    sessionManager.setInvite(response.body().getInvite());
                    sessionManager.setLogin(true);

                    if (response.body().getData().getUser_type().equals("shareholder")){
                        Toast.makeText(LoginActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();
                        Intent intent =new Intent(LoginActivity.this,DrawerActivity.class);
                        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                        finish();
                    }else if (response.body().getData().getUser_type().equals("administrator")){
                        Toast.makeText(LoginActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();
                        Intent intent =new Intent(LoginActivity.this,AdministratorActivity.class);
                        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                        finish();
                    }


                }else {
                    Toast.makeText(LoginActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }

    public void jsonVersionCheck() {

        prLogin.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"login"+"&apikey="+sessionManager.getApiKey()+"&version="+version);
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("version>>", "onResponse: "+response.body().toString());


                prLogin.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){
                    acknowledge=response.body().getAcknowledge().toString();
                    Constants.allPics=response.body().getPpics_all();
                    if (response.body().getUpdates().isAvailable()){
                        showDialog(LoginActivity.this, "You have a new "+response.body().getUpdates().getNew_verson_name()+" available to install. Please update your version before "+response.body().getUpdates().getLast_date() +" to keep yourself updated.",response.body().getUpdates().isRequired(),response.body().getData());

                    }else if (response.body().getData()!=null){
                        sessionManager.setApiKet(response.body().getData().getApi_key());
                        sessionManager.setUserId(response.body().getData().getUser_id());
                        sessionManager.setDisplayName(response.body().getData().getDisplay_name());

                        sessionManager.setLogin(true);

                        if (response.body().getData().getUser_type().equals("shareholder")){
                            Intent intent =new Intent(LoginActivity.this,DrawerActivity.class);
                            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                            startActivity(intent);
                            finish();
                        }else if (response.body().getData().getUser_type().equals("administrator")){
                            Intent intent =new Intent(LoginActivity.this,AdministratorActivity.class);
                            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                            startActivity(intent);
                            finish();
                        }
                    }

                }else {
                    acknowledge=response.body().getAcknowledge().toString();
                    Constants.allPics=response.body().getPpics_all();
//                    Toast.makeText(LoginActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();
                    if (response.body().getUpdates()!=null){
                        if (response.body().getUpdates().isAvailable()){
                            showDialog(LoginActivity.this, "You have a new "+response.body().getUpdates().getNew_verson_name() +" available to install. Please update your version before "+response.body().getUpdates().getLast_date()+" to keep yourself updated.",response.body().getUpdates().isRequired(),response.body().getData());

                        }else if (response.body().getData()!=null){
                            sessionManager.setApiKet(response.body().getData().getApi_key());
                            sessionManager.setUserId(response.body().getData().getUser_id());
                            sessionManager.setDisplayName(response.body().getData().getDisplay_name());
                            sessionManager.setLogin(true);

                            if (response.body().getData().getUser_type().equals("shareholder")){
                                Intent intent =new Intent(LoginActivity.this,DrawerActivity.class);
                                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                startActivity(intent);
                                finish();
                            }else if (response.body().getData().getUser_type().equals("administrator")){
                                Intent intent =new Intent(LoginActivity.this,AdministratorActivity.class);
                                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                startActivity(intent);
                                finish();
                            }
                        }

                    }

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {

                Log.d("version", "onFailure: "+t.getMessage());

            }
        });
    }

    public void showDialog(Activity activity, String msg, boolean required, final LoginModel.Data data){

        final Dialog dialog = new Dialog(activity);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setCancelable(false);
        dialog.setContentView(R.layout.dialouge_box);



        TextView text = (TextView) dialog.findViewById(R.id.text_dialog);
        text.setText(msg);

        Button btnSkip = (Button) dialog.findViewById(R.id.btnDialougeSkip);
        btnSkip.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (data==null){
                    dialog.dismiss();
                }else {
                    sessionManager.setApiKet(data.getApi_key());
                    sessionManager.setUserId(data.getUser_id());
                    sessionManager.setDisplayName(data.getDisplay_name());
                    sessionManager.setLogin(true);

                    if (data.getUser_type().equals("shareholder")){
                        Intent intent =new Intent(LoginActivity.this,DrawerActivity.class);
                        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                        finish();
                    }else if (data.getUser_type().equals("administrator")){
                        Intent intent =new Intent(LoginActivity.this,AdministratorActivity.class);
                        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                        finish();
                    }

                }

            }
        });


        Button btnUpdate = (Button) dialog.findViewById(R.id.btnDialougeUpdate);
        btnUpdate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });

        if (required){
            btnSkip.setVisibility(View.GONE);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
            params.weight = 1.0f;
            btnUpdate.setLayoutParams(params);
        }

        dialog.show();

    }
}