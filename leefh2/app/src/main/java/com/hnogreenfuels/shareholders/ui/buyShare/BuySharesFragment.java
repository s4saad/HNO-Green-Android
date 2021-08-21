package com.hnogreenfuels.shareholders.ui.buyShare;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.GenerateOrderActivity;
import com.hnogreenfuels.shareholders.Model.BuyShareModel;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class BuySharesFragment extends Fragment {

    private SlideshowViewModel slideshowViewModel;
    private APIInterface apiInterface;
    private SessionManager sessionManager;
    private LinearLayout prBuyShare;
    private EditText sharePrice,shareToBuy,totalAmount;
    private Button btnCheckOut;
    private double intSharePrice;
    TextWatcher yourTextWatcherTotal;
     TextWatcher yourTextWatcherBuy;
     private CheckBox chBuyShares,chBuyShares2;
     private LinearLayout lnTransferShares;
     private TextView tvUsername,tvEmail;
     private EditText edtUsername,edtEmail,edtMessage;
     private String someone="false",newuser="false";


    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        slideshowViewModel =
                ViewModelProviders.of(this).get(SlideshowViewModel.class);
        View root = inflater.inflate(R.layout.fragment_buyshare, container, false);


        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(getActivity());

        prBuyShare = root.findViewById(R.id.prBuyShare);

        sharePrice=root.findViewById(R.id.sharePriceB);
        sharePrice.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        shareToBuy=root.findViewById(R.id.ShareToBuyB);
        shareToBuy.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        totalAmount=root.findViewById(R.id.TotalAmountB);
        totalAmount.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        btnCheckOut=root.findViewById(R.id.btnCheckOutB);
        btnCheckOut.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        chBuyShares=root.findViewById(R.id.chBuyShares);
        chBuyShares.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        lnTransferShares=root.findViewById(R.id.lnTranferShare);

        chBuyShares2=root.findViewById(R.id.chBuyShares2);
        chBuyShares2.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        tvUsername=root.findViewById(R.id.tvUsername);
        tvUsername.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        tvEmail=root.findViewById(R.id.tvEmailB);
        tvEmail.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        edtUsername=root.findViewById(R.id.edtUserNameB);
        edtUsername.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        edtEmail=root.findViewById(R.id.edtEmailB);
        edtEmail.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        edtMessage=root.findViewById(R.id.edtMessageB);
        edtMessage.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);


        chBuyShares2.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {

                if (b){
                    tvUsername.setVisibility(View.GONE);
                    edtUsername.setVisibility(View.GONE);

                    tvEmail.setVisibility(View.VISIBLE);
                    edtEmail.setVisibility(View.VISIBLE);

                    newuser="true";
                }else {
                    tvUsername.setVisibility(View.VISIBLE);
                    edtUsername.setVisibility(View.VISIBLE);

                    tvEmail.setVisibility(View.GONE);
                    edtEmail.setVisibility(View.GONE);

                    newuser="false";
                }
            }
        });

        chBuyShares.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                Log.d("TAG", "onCheckedChanged: "+b);

                if (b){
                    AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());

                    builder.setMessage("Please acknowledge that once this purchase and transfer process completed successfully, you can not get these share back");

                    builder.setPositiveButton("I Acknowledge", new DialogInterface.OnClickListener() {

                        public void onClick(DialogInterface dialog, int which) {
                            // Do nothing but close the dialog
                            dialog.dismiss();

                            lnTransferShares.setVisibility(View.VISIBLE);

                            someone="true";
                        }
                    });

                    builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {

                        @Override
                        public void onClick(DialogInterface dialog, int which) {

                            // Do nothing
                            dialog.dismiss();

                            chBuyShares.setChecked(false);
                        }
                    });

                    AlertDialog alert = builder.create();
                    alert.show();
                }else {
                    lnTransferShares.setVisibility(View.GONE);
                    someone="false";
                }
            }
        });


        final TextView textView = root.findViewById(R.id.text_slideshow);
        slideshowViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                textView.setText(s);
            }
        });

         yourTextWatcherBuy = new TextWatcher() {

            @Override
            public void afterTextChanged(Editable s) {
                // your logic here
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                // your logic here
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

                try {
                    totalAmount.removeTextChangedListener(yourTextWatcherTotal);
                    if (s.toString().equals("")){
                        try {
                            totalAmount.setText("");
                        }catch (Exception e){

                        }

                    }else {
                        try {
                            double value=Double.valueOf(s.toString())*intSharePrice;
                            double roundOff = Math.round(value * 100.0) / 100.0;
                            totalAmount.setText(String.valueOf(roundOff));
                        }catch (Exception e){

                        }

                    }

                }catch (Exception e){

                }
            }
        };

        yourTextWatcherTotal = new TextWatcher() {

            @Override
            public void afterTextChanged(Editable s) {
                // your logic here
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                // your logic here
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

                try {
                    shareToBuy.removeTextChangedListener(yourTextWatcherBuy);
                    if (s.toString().equals("")){
                        try {
                            shareToBuy.setText("");
                        }catch (Exception e){

                        }

                    }else {
                        try {
                            double value=Double.valueOf(s.toString())/intSharePrice;

                            shareToBuy.setText(String.format("%.0f", value));
                        }catch (Exception e){

                        }

                    }

                }catch (Exception e){

                }

            }
        };


        shareToBuy.addTextChangedListener(yourTextWatcherBuy);

        totalAmount.addTextChangedListener(yourTextWatcherTotal);

        shareToBuy.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                try {
                    totalAmount.removeTextChangedListener(yourTextWatcherTotal);
                    shareToBuy.addTextChangedListener(yourTextWatcherBuy);

                } catch (Exception e) {

                }
                return false;
            }
        });

//        shareToBuy.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                totalAmount.removeTextChangedListener(yourTextWatcherTotal);
//                shareToBuy.addTextChangedListener(yourTextWatcherBuy);
//
//            }
//        });

        totalAmount.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                try {
                    shareToBuy.removeTextChangedListener(yourTextWatcherBuy);
                    totalAmount.addTextChangedListener(yourTextWatcherTotal);

                }catch (Exception e){

                }
                return false;
            }
        });
//        totalAmount.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                shareToBuy.removeTextChangedListener(yourTextWatcherBuy);
//                totalAmount.addTextChangedListener(yourTextWatcherTotal);
//            }
//        });


        btnCheckOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (shareToBuy.getText().toString().equals("")||totalAmount.getText().toString().equals("")){
                    Toast.makeText(getActivity(), "Fields are Empty", Toast.LENGTH_SHORT).show();
                }else {
                    Intent intent=new Intent(getActivity(), GenerateOrderActivity.class);
                    intent.putExtra("share",shareToBuy.getText().toString());
                    intent.putExtra("someone",someone);
                    intent.putExtra("newuser",newuser);
                    intent.putExtra("email",edtEmail.getText().toString());
                    intent.putExtra("username",edtUsername.getText().toString());
                    intent.putExtra("notes",edtMessage.getText().toString());
                    startActivity(intent);
                }

            }
        });

        jsonBuyShare();
        return root;
//        if a user type in Number of Shares Field, Formula for total amount will be:
//        Amount: Share Price x Number of Shares
//
//        If a user type in Amount Field, Formula for Number of Shares will be:
//        Number of Shares: Amount / Share Price
    }

    public void jsonBuyShare() {

        prBuyShare.setVisibility(View.VISIBLE);

        Call<BuyShareModel> call = apiInterface.pubShare(Constants.BASE_URL + "share_price" + "&apikey=" + sessionManager.getApiKey());
        call.enqueue(new Callback<BuyShareModel>() {
            @Override
            public void onResponse(Call<BuyShareModel> call, Response<BuyShareModel> response) {

                try {
                    Log.d("BuyShare>>", "onResponse: " + response.body().toString());

                    prBuyShare.setVisibility(View.GONE);

                    if (response.body().getResponse_code() == 0) {

                        sharePrice.setText(response.body().getData().getPrice());
                        intSharePrice=Double.valueOf(response.body().getData().getPrice());
//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

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