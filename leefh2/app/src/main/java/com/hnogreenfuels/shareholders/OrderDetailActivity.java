package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Model.ConfirmOrderModel;
import com.hnogreenfuels.shareholders.Session.SessionManager;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class OrderDetailActivity extends AppCompatActivity {

    private TextView orderId,transactionRef,shares,amount,price,paymentMethod,details,receiver,receiverNotes;
    private Button btnConfirm;
    private LinearLayout prOrderDetails;
    private APIInterface apiInterface;
    private SessionManager sessionManager;
    private String strTrx,strPaymentMethod;
    private RelativeLayout rlReceiver,rlReceiverNotes;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order_detail);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(OrderDetailActivity.this);

        orderId=findViewById(R.id.orderIDO);
        transactionRef=findViewById(R.id.transactionRefO);
        shares=findViewById(R.id.sharesO);
        amount=findViewById(R.id.amountO);
        price=findViewById(R.id.priceO);
        paymentMethod=findViewById(R.id.paymentMethodO);
        btnConfirm=findViewById(R.id.btnConfirm);
        details=findViewById(R.id.detailO);
        prOrderDetails=findViewById(R.id.prOrderDetails);
        rlReceiver=findViewById(R.id.rlReceiverO);
        rlReceiverNotes=findViewById(R.id.rlReceiverNoteO);
        receiver=findViewById(R.id.receiverO);
        receiverNotes=findViewById(R.id.receiverNotesO);

        Intent intent=getIntent();
        if (intent!=null){
            strTrx=intent.getStringExtra("trx");
            strPaymentMethod=intent.getStringExtra("id");
        }

        btnConfirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                confirmOrder();
            }
        });

        jsonBuyShare();
    }


    public void jsonBuyShare() {

        prOrderDetails.setVisibility(View.VISIBLE);

        Call<ConfirmOrderModel> call = apiInterface.confirmOrder(Constants.BASE_URL + "confirm_order" + "&apikey=" + sessionManager.getApiKey()+"&trx_reference="+strTrx+"&pay_method="+strPaymentMethod);
        call.enqueue(new Callback<ConfirmOrderModel>() {
            @Override
            public void onResponse(Call<ConfirmOrderModel> call, Response<ConfirmOrderModel> response) {

                Log.d("BuyShare>>", "onResponse: " + response.body().toString());

                prOrderDetails.setVisibility(View.GONE);

                if (response.body().getResponse_code() == 0) {

                    orderId.setText(response.body().getData().getTrx_reference());
                    transactionRef.setText(response.body().getData().getTrx_reference());
                    shares.setText(response.body().getData().getShares());
                    amount.setText(String.valueOf(response.body().getData().getAmount()));
                    paymentMethod.setText(String.valueOf(response.body().getData().getPayment_method().getName()));
                    details.setText(Html.fromHtml(response.body().getData().getPayment_method().getArgs().getDetails()));
                    price.setText(String.valueOf(response.body().getData().getPrice()));
//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                    if (response.body().getData().isSomeone()){
                        rlReceiver.setVisibility(View.VISIBLE);
                        rlReceiverNotes.setVisibility(View.VISIBLE);

                        receiver.setText(response.body().getData().getReceiver());
                        receiverNotes.setText(response.body().getData().getReceiver_notes());
                    }

                } else {
                    Toast.makeText(OrderDetailActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<ConfirmOrderModel> call, Throwable t) {
                Toast.makeText(OrderDetailActivity.this, ""+t.getMessage(), Toast.LENGTH_SHORT).show();
                Log.d("TAG", "onFailure: "+t.getMessage());

            }
        });
    }
    public void confirmOrder() {

        prOrderDetails.setVisibility(View.VISIBLE);

        Call<ConfirmOrderModel> call = apiInterface.confirmOrder(Constants.BASE_URL + "complete_manual" + "&apikey=" + sessionManager.getApiKey()+"&trx_reference="+strTrx);
        call.enqueue(new Callback<ConfirmOrderModel>() {
            @Override
            public void onResponse(Call<ConfirmOrderModel> call, Response<ConfirmOrderModel> response) {

                Log.d("BuyShare>>", "onResponse: " + response.body().toString());

                prOrderDetails.setVisibility(View.GONE);

                if (response.body().getResponse_code() == 0) {

                    Toast.makeText(OrderDetailActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();
                    Intent intent =new Intent(OrderDetailActivity.this,DrawerActivity.class);
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(intent);

                } else {
                    Toast.makeText(OrderDetailActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<ConfirmOrderModel> call, Throwable t) {
                Toast.makeText(OrderDetailActivity.this, ""+t.getMessage(), Toast.LENGTH_SHORT).show();
                Log.d("TAG", "onFailure: "+t.getMessage());

            }
        });
    }
}