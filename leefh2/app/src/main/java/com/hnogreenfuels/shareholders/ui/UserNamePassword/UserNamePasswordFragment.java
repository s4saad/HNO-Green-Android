package com.hnogreenfuels.shareholders.ui.UserNamePassword;

import android.graphics.Color;
import android.os.Bundle;

import androidx.core.content.ContextCompat;
import androidx.fragment.app.Fragment;

import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
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
import com.hnogreenfuels.shareholders.Model.ProfileModel;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class UserNamePasswordFragment extends Fragment {

    private APIInterface apiInterface;
    private SessionManager sessionManager;
    private LinearLayout prUserNamePassword;
    private EditText userNameU;
    TextWatcher yourTextWatcherUserName;
    private TextView txtValidate;
    private boolean isValidate;
    private EditText edtOdlPassword,edtNewPasswordU,edtConfirmPasswordU;
    private Button btnUpdate;



    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v= inflater.inflate(R.layout.fragment_user_name_password, container, false);
        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(getActivity());

        prUserNamePassword=v.findViewById(R.id.prUserNamePassword);
        userNameU=v.findViewById(R.id.userNameU);
        txtValidate=v.findViewById(R.id.txtValidate);
        edtOdlPassword=v.findViewById(R.id.edtOdlPassword);
        edtNewPasswordU=v.findViewById(R.id.edtNewPasswordU);
        edtConfirmPasswordU=v.findViewById(R.id.edtConfirmPasswordU);
        btnUpdate=v.findViewById(R.id.btnUpdate);

        yourTextWatcherUserName = new TextWatcher() {

            @Override
            public void afterTextChanged(Editable s) {
                try {

                        jsonValidate();



                }catch (Exception e){

                }
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                // your logic here
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }
        };

        userNameU.addTextChangedListener(yourTextWatcherUserName);

        btnUpdate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(Functions.isEmpty(edtOdlPassword))
                    edtOdlPassword.setError("Enter Password");

                if (isValidate&&!Functions.isEmpty(edtOdlPassword)){
                    if (!Functions.isEmpty(edtNewPasswordU))
                    {
                        if (edtNewPasswordU.getText().toString().equals(edtConfirmPasswordU.getText().toString()))
                        {
                            jsonUpdate();
                        }else {
                            Toast.makeText(getActivity(), "Enter Same Password", Toast.LENGTH_SHORT).show();
                        }
                    }

                }

            }
        });

        jsonGetUserName();
        return v;
    }


    public void jsonGetUserName() {

        prUserNamePassword.setVisibility(View.VISIBLE);

        Call<ProfileModel> call = apiInterface.getUsername(Constants.BASE_URL + "get_username" + "&apikey=" + sessionManager.getApiKey());
        call.enqueue(new Callback<ProfileModel>() {
            @Override
            public void onResponse(Call<ProfileModel> call, Response<ProfileModel> response) {

                try {
                    Log.d("BuyShare>>", "onResponse: " + response.body().toString());

                    prUserNamePassword.setVisibility(View.GONE);

                    if (response.body().getResponse_code() == 0) {
                        userNameU.setText(response.body().getData().getUsername());
//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                    } else {
                        Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                    }
                }catch (Exception e){

                }


            }

            @Override
            public void onFailure(Call<ProfileModel> call, Throwable t) {


            }
        });
    }
    public void jsonValidate() {


        Call<ProfileModel> call = apiInterface.getUsername(Constants.BASE_URL + "available_username" + "&apikey=" + sessionManager.getApiKey()+"&username="+userNameU.getText().toString());
        call.enqueue(new Callback<ProfileModel>() {
            @Override
            public void onResponse(Call<ProfileModel> call, Response<ProfileModel> response) {

                try {
                    Log.d("Validate>>", "onResponse: " + response.body().toString());


                    if (response.body().getResponse_code() == 0) {

                        txtValidate.setVisibility(View.VISIBLE);
                        isValidate=true;
                        txtValidate.setTextColor(ContextCompat.getColor(getActivity(), R.color.colorPrimaryDark));
                        txtValidate.setText(response.body().getResponse_msg());
//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                    } else if (response.body().getResponse_code()==141){
                        txtValidate.setVisibility(View.GONE);
                        txtValidate.setText("");
                        isValidate=true;
                    }else {
                        txtValidate.setTextColor(Color.RED);
                        txtValidate.setText(response.body().getResponse_msg());
                        isValidate=false;
                    }
                }catch (Exception e){

                }


            }

            @Override
            public void onFailure(Call<ProfileModel> call, Throwable t) {


            }
        });
    }
    public void jsonUpdate() {

        String mofiledUrl = null;
        if(Functions.isEmpty(edtNewPasswordU))
            mofiledUrl="&password&re_password";

        if(Functions.isEmpty(edtConfirmPasswordU))
            mofiledUrl="&password&re_password";

        if (!Functions.isEmpty(edtConfirmPasswordU))
            mofiledUrl="&password="+edtNewPasswordU.getText().toString()+"&re_password="+edtConfirmPasswordU.getText().toString();

        prUserNamePassword.setVisibility(View.VISIBLE);
        Call<LoginModel> call = apiInterface.updateUserName(Constants.BASE_URL + "change_username_password" + "&apikey=" + sessionManager.getApiKey()
                +"&username="+userNameU.getText().toString()
                +"&old_password="+edtOdlPassword.getText().toString()
                +mofiledUrl);
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                try {
                    Log.d("Validate>>", "onResponse: " + response.body().toString());

                    prUserNamePassword.setVisibility(View.GONE);
                    if (response.body().getResponse_code() == 0) {

                        Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                        sessionManager.setApiKet(response.body().getData().getApi_key());
                        sessionManager.setUserId(response.body().getData().getUser_id());
                        sessionManager.setDisplayName(response.body().getData().getDisplay_name());
                        sessionManager.setLogin(true);
                    }else {
                        Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();
                    }
                }catch (Exception e){

                }


            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }
}