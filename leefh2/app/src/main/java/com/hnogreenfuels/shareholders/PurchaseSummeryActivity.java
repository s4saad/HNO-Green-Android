package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Model.SummeryModel;
import com.hnogreenfuels.shareholders.Session.SessionManager;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class PurchaseSummeryActivity extends AppCompatActivity {

    private TextView RefID,OrderDate,Shares,SharesAmount,SharePrice,PaymentMethod,Details;
    private APIInterface apiInterface;
    private SessionManager sessionManager;
    private LinearLayout prSummery;
    private String orderId;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_purchase_summery);


        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(PurchaseSummeryActivity.this);

        Intent intent=getIntent();
        if (intent!=null){
            orderId=intent.getStringExtra("OrderId");
        }

        RefID=findViewById(R.id.RefIDP);
        OrderDate=findViewById(R.id.OrderDateP);
        Shares=findViewById(R.id.SharesP);
        SharesAmount=findViewById(R.id.SharePriceP);
        SharePrice=findViewById(R.id.SharePriceP);
        PaymentMethod=findViewById(R.id.paymentMethodP);
        Details=findViewById(R.id.DetailsP);
        prSummery=findViewById(R.id.prSummery);
        jsonBuyShare();

    }

    public void jsonBuyShare() {

        prSummery.setVisibility(View.VISIBLE);

        Call<SummeryModel> call = apiInterface.summery(Constants.BASE_URL + "view_pending_purchase" + "&apikey=" + sessionManager.getApiKey()+"&order_id="+orderId);
        call.enqueue(new Callback<SummeryModel>() {
            @Override
            public void onResponse(Call<SummeryModel> call, Response<SummeryModel> response) {

                try {
                    Log.d("BuyShare>>", "onResponse: " + response.body().toString());

                    prSummery.setVisibility(View.GONE);

                    if (response.body().getResponse_code() == 0) {
                        RefID.setText(response.body().getData().getOrderTrxRef());
                        OrderDate.setText(response.body().getData().getOrderDate());
                        Shares.setText(response.body().getData().getShares());
                        SharesAmount.setText(response.body().getData().getAmount());
                        SharePrice.setText(response.body().getData().getSharePrice());
                        PaymentMethod.setText(response.body().getData().getPaymentMethod());
                        Details.setText(Html.fromHtml(response.body().getData().getPaymentDetails()));

                    } else {
                        Toast.makeText(PurchaseSummeryActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                    }
                }catch (Exception e){

                }


            }

            @Override
            public void onFailure(Call<SummeryModel> call, Throwable t) {


            }
        });
    }
}