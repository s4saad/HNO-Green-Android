package com.hnogreenfuels.shareholders.ui.TransferShares;

import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;

import android.text.InputType;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.AdministratorActivity;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.DrawerActivity;
import com.hnogreenfuels.shareholders.LoginActivity;
import com.hnogreenfuels.shareholders.Model.BuyShareModel;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;
import com.hnogreenfuels.shareholders.SignupActivity;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


public class TransferSharesFragment extends Fragment {


    private EditText userName,NoOfShares,Message,Email;
    private Button btnTransferShares;
    private CheckBox checkBox;
    private LinearLayout progressBar;
    private APIInterface apiInterface;
    private SessionManager sessionManager;
    private String newUser;
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v= inflater.inflate(R.layout.fragment_transfer_shares, container, false);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(getActivity());

        userName=v.findViewById(R.id.edtUsernameTS);
        userName.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        NoOfShares=v.findViewById(R.id.edtNoOfSharesTS);
        NoOfShares.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        Message=v.findViewById(R.id.edtMessageToRecieveTS);
        Message.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        Email=v.findViewById(R.id.edtEmailTS);
        Email.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        btnTransferShares=v.findViewById(R.id.btnTransferShares);
        checkBox=v.findViewById(R.id.chTransferShares);
        progressBar=v.findViewById(R.id.prTransferShares);

        newUser="false";

        btnTransferShares.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());

                builder.setMessage("Once the transfer completed, you can not get these shares back, Are you sure that you want to make this transfer?");

                builder.setPositiveButton("Yes", new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialog, int which) {
                        // Do nothing but close the dialog
                        dialog.dismiss();
                        jsonTransferShares();


                    }
                });

                builder.setNegativeButton("No", new DialogInterface.OnClickListener() {

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

        checkBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                Log.d("TAG", "onCheckedChanged: "+b);

                if (b==true){
                    Email.setVisibility(View.VISIBLE);
                    userName.setVisibility(View.GONE);
                    newUser="true";
                }else {
                    Email.setVisibility(View.GONE);
                    userName.setVisibility(View.VISIBLE);
                    newUser="false";
                }
            }
        });


        return v;
    }

    public void jsonTransferShares() {

        progressBar.setVisibility(View.VISIBLE);



        Call<BuyShareModel> call = apiInterface.pubShare(Constants.BASE_URL + "transfer_shares" + "&apikey=" + sessionManager.getApiKey()+"&shares="+NoOfShares.getText().toString()+"&newuser="+newUser+"&email="+Email.getText().toString()+"&username="+userName.getText().toString()+"&notes="+Message.getText().toString());
        call.enqueue(new Callback<BuyShareModel>() {
            @Override
            public void onResponse(Call<BuyShareModel> call, Response<BuyShareModel> response) {

                try {
                    Log.d("BuyShare>>", "onResponse: " + response.body().toString());

                    progressBar.setVisibility(View.GONE);


                    if (response.body().getResponse_code() == 0) {

//
                        Intent intent =new Intent(getActivity(), DrawerActivity.class);
                                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                                startActivity(intent);
                                getActivity().finish();
                        Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();


                    } else {
                        Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                    }
                }catch (Exception e){

                }


            }

            @Override
            public void onFailure(Call<BuyShareModel> call, Throwable t) {


            }
        });
    }
}