package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.app.Activity;
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
import com.hnogreenfuels.shareholders.Model.BuyShareModel;
import com.hnogreenfuels.shareholders.Model.GenetareOrderModel;
import com.hnogreenfuels.shareholders.Session.SessionManager;
import com.hnogreenfuels.shareholders.adapter.gerateOrderAdapter;
//import com.a2ztech.leefh2.adapter.transactionAdapter;
//import com.paypal.android.sdk.payments.PayPalConfiguration;
//import com.paypal.android.sdk.payments.PayPalPayment;
//import com.paypal.android.sdk.payments.PayPalService;
//import com.paypal.android.sdk.payments.PaymentActivity;
//import com.paypal.android.sdk.payments.PaymentConfirmation;
import com.braintreepayments.api.BraintreeFragment;
import com.braintreepayments.api.DataCollector;
import com.braintreepayments.api.dropin.DropInActivity;
import com.braintreepayments.api.dropin.DropInRequest;
import com.braintreepayments.api.dropin.DropInResult;
import com.braintreepayments.api.exceptions.InvalidArgumentException;
import com.braintreepayments.api.interfaces.BraintreeResponseListener;
import com.loopj.android.http.AsyncHttpClient;
import com.tokopedia.expandable.BaseExpandableOption;
import com.tokopedia.expandable.ExpandableOptionRadio;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class GenerateOrderActivity extends AppCompatActivity {

    private APIInterface apiInterface;
    private SessionManager sessionManager;
    private LinearLayout prGenerateOrder;
    private TextView transRef,sharePrice,shareToBuy,totalAmount,receiver,receiverNotes;
    private RecyclerView recyclerView;
    gerateOrderAdapter adapter;
    ExpandableOptionRadio baseExpandableOptionObject;
    ExpandableOptionRadio baseExpandableOptionObject1;
    ExpandableOptionRadio baseExpandableOptionObject2;
    ExpandableOptionRadio baseExpandableOptionObject3;
    ExpandableOptionRadio baseExpandableOptionObject4;
    TextView text1,text2,text3,text4,text5;
    String share;
    private Button btnProceed;
    private int selected=-1;
    private String trx;
    private String paymentMethodId;
    private ArrayList<GenetareOrderModel.Data.PaymentMethod> mList;
    private String clientToken;
    private String deviceData,someone,newuser,email,username,notes;
    private RelativeLayout rvReceiver,rvReceiverNote;

    ///Braintree
    AsyncHttpClient client;
    BraintreeFragment mBraintreeFragment;

    ////paypal
    private static final int PAYPAL_REQUEST_CODE = 7777;

//    private static PayPalConfiguration config ;
    Button btnPayNow;
//    TextView edtAmount;

    String amount = "";
    double fees;

//    @Override
//    protected void onDestroy() {
//        stopService(new Intent(this, PayPalService.class));
//        super.onDestroy();
//    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_generate_order);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(GenerateOrderActivity.this);
        prGenerateOrder=findViewById(R.id.prGenerateOrder);
        transRef=findViewById(R.id.transRefG);
        sharePrice=findViewById(R.id.sharePriceG);
        shareToBuy=findViewById(R.id.shareToBuyG);
        totalAmount=findViewById(R.id.TotalAmountG);
        recyclerView = findViewById(R.id.recPayment);
        btnProceed=findViewById(R.id.btnProceedG);
        rvReceiver=findViewById(R.id.rlReciver);
        rvReceiverNote=findViewById(R.id.rlReceiverNote);
        receiver=findViewById(R.id.tvReceiverG);
        receiverNotes=findViewById(R.id.tvReceiverNoteG);


        btnProceed.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (selected!=-1){

                    if (selected==0)
                    {
                        amount = totalAmount.getText().toString();
                        amount=String.valueOf(Double.parseDouble(amount)+fees);
                        Log.d("amount", "onClick: "+amount);

                        ///Paypal
//                        processPayment();
                        ///BrainTree
                        getClientToken(amount);

                    }else {
                        Intent intent =new Intent(GenerateOrderActivity.this,OrderDetailActivity.class);
                        intent.putExtra("trx",trx);
                        intent.putExtra("id",paymentMethodId);
                        startActivity(intent);
                    }


                }else {
                    Toast.makeText(GenerateOrderActivity.this, "Selected Payment Method", Toast.LENGTH_SHORT).show();
                }

            }
        });

        Intent intent = getIntent();
        if (intent!=null){
           share= intent.getStringExtra("share");
            someone= intent.getStringExtra("someone");
            newuser= intent.getStringExtra("newuser");
            email= intent.getStringExtra("email");
            username= intent.getStringExtra("username");
            notes= intent.getStringExtra("notes");
        }


        recyclerView.setLayoutManager(new LinearLayoutManager(GenerateOrderActivity.this,LinearLayoutManager.VERTICAL, false));
        baseExpandableOptionObject=findViewById(R.id.radio1);
        baseExpandableOptionObject1=findViewById(R.id.radio2);
        baseExpandableOptionObject2=findViewById(R.id.radio3);
        baseExpandableOptionObject3=findViewById(R.id.radio4);
        baseExpandableOptionObject4=findViewById(R.id.radio5);
        text1=findViewById(R.id.txt1);
        text2=findViewById(R.id.txt2);
        text3=findViewById(R.id.txt3);
        text4=findViewById(R.id.txt4);
        text5=findViewById(R.id.txt5);


        baseExpandableOptionObject.setExpand(true);
        baseExpandableOptionObject.toggle();
        baseExpandableOptionObject.isExpanded();




//set listener of expandable view when collapse or expand
        baseExpandableOptionObject.setExpandableListener(new BaseExpandableOption.ExpandableListener() {
            @Override
            public void onExpandViewChange(boolean isExpand) {

                selected=0;
                paymentMethodId=mList.get(0).getId();
            }
        });
        baseExpandableOptionObject1.setExpandableListener(new BaseExpandableOption.ExpandableListener() {
            @Override
            public void onExpandViewChange(boolean isExpand) {

                selected=1;
                paymentMethodId=mList.get(1).getId();
            }
        });
        baseExpandableOptionObject2.setExpandableListener(new BaseExpandableOption.ExpandableListener() {
            @Override
            public void onExpandViewChange(boolean isExpand) {

                selected=2;
                paymentMethodId=mList.get(2).getId();
            }
        });
        baseExpandableOptionObject3.setExpandableListener(new BaseExpandableOption.ExpandableListener() {
            @Override
            public void onExpandViewChange(boolean isExpand) {

                selected=3;
                paymentMethodId=mList.get(3).getId();
            }
        });
        baseExpandableOptionObject4.setExpandableListener(new BaseExpandableOption.ExpandableListener() {
            @Override
            public void onExpandViewChange(boolean isExpand) {

                selected=4;
                paymentMethodId=mList.get(4).getId();
            }
        });
//        recyclerView.addOnItemTouchListener(
//                new RecyclerItemClickListener(GenerateOrderActivity.this, recyclerView ,new RecyclerItemClickListener.OnItemClickListener() {
//                    @Override public void onItemClick(View view, int position) {
//
////
////                        RecyclerView.ViewHolder viewHolder = recyclerView.findViewHolderForItemId(position);
////                        View view1 = viewHolder.itemView;
////                        ImageView imageView = (ImageView)view1.findViewById(R.id.img);
////
////                        imageView.setImageResource(R.drawable.green_circle);
//
//                    }
//
//                    @Override public void onLongItemClick(View view, int position) {
//                        // do whatever
//                    }
//                })
//        );
        jsonBuyShare();
    }
    private void getClientToken(final String amount) {

        prGenerateOrder.setVisibility(View.VISIBLE);

        try {
            mBraintreeFragment = BraintreeFragment.newInstance(this, clientToken);
            // mBraintreeFragment is ready to use!
            DataCollector.collectDeviceData(mBraintreeFragment, new BraintreeResponseListener<String>() {
                @Override
                public void onResponse(String s) {
                    Log.d("DeviceData", "onResponse: "+s.toString());

                    deviceData=s;

                    DropInRequest dropInRequest = new DropInRequest().clientToken(clientToken);
                    dropInRequest.amount(amount);
                    startActivityForResult(dropInRequest.getIntent(GenerateOrderActivity.this), 512);

                }
            });
        } catch (InvalidArgumentException e) {
            // There was an issue with your authorization string.
        }

//        client = new AsyncHttpClient();
//        client.get(clientToken, new TextHttpResponseHandler() {
//            @Override
//            public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
//                Log.e("Error", throwable.getLocalizedMessage());
//            }
//
//            @Override
//            public void onSuccess(int statusCode, Header[] headers, String responseString) {
//
//                try {
//                    TokenResponse response = new Gson().fromJson(responseString,new TypeToken<TokenResponse>(){
//
//                    }.getType());
//
//                    try {
//
//                        DropInRequest dropInRequest = new DropInRequest().clientToken(response.getData().getClienttoken());
//                        dropInRequest.amount(amount);
//
//                        startActivityForResult(dropInRequest.getIntent(GenerateOrderActivity.this), 512);
//                        prGenerateOrder.setVisibility(View.GONE);
//                    }catch (Exception e){
//
//                    }
//                }catch (Exception e){
//
//                }
//
//            }
//        });
}
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 512) {
            if (resultCode == Activity.RESULT_OK) {
                prGenerateOrder.setVisibility(View.GONE);
                DropInResult result = data.getParcelableExtra(DropInResult.EXTRA_DROP_IN_RESULT);
// here you will get nonce for the payment
                String nNonce = result.getPaymentMethodNonce().getNonce();
// you also can check payment type is from paypal or Card
                String payment_type = result.getPaymentMethodType().getCanonicalName();


                if (nNonce != null && payment_type != null) {
                    Log.d("Payment", "Payment done, Send this nonce to server");
                    jsonCompletePaypal(nNonce);
//                    postNonceToYourServer(nNonce,payment_type,user_id);
                }

            } else if (resultCode == Activity.RESULT_CANCELED) {
                Log.d("Payment", "Payment cancelled by user, go back to previous activity");

            } else {
                // handle errors here, an exception may be available in
                Exception error = (Exception) data.getSerializableExtra(DropInActivity.EXTRA_ERROR);
                Log.d("Payment", "Get some unknown error, go back to previous activity"+error.getMessage());

            }
        }
    }
    private void processPayment() {

//        PayPalPayment payPalPayment = new PayPalPayment(new BigDecimal(String.valueOf(amount)),"USD",
//                "HNO",PayPalPayment.PAYMENT_INTENT_SALE).custom(trx);
//        Intent intent = new Intent(this, PaymentActivity.class);
//        intent.putExtra(PayPalService.EXTRA_PAYPAL_CONFIGURATION,config);
//        intent.putExtra(PaymentActivity.EXTRA_PAYMENT,payPalPayment);
//        startActivityForResult(intent,PAYPAL_REQUEST_CODE);
    }
//    @Override
//    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
//        if (requestCode == PAYPAL_REQUEST_CODE){
//            if (resultCode == RESULT_OK){
//                PaymentConfirmation confirmation = data.getParcelableExtra(PaymentActivity.EXTRA_RESULT_CONFIRMATION);
//                if (confirmation != null){
//                    try {
//                        String paymentDetails = confirmation.toJSONObject().toString(4);
//                        JSONObject jsonObject = new JSONObject(paymentDetails);
//                        jsonCompletePaypal(jsonObject.getJSONObject("response"));
////                        startActivity(new Intent(this,PaymentDetails.class)
////                                .putExtra("Payment Details",paymentDetails)
////                                .putExtra("Amount",amount));
//                    } catch (JSONException e){
//                        e.printStackTrace();
//                    }
//                }
//            } else if (resultCode == Activity.RESULT_CANCELED)
//                Toast.makeText(this, "Cancel", Toast.LENGTH_SHORT).show();
//        } else if (resultCode == PaymentActivity.RESULT_EXTRAS_INVALID)
//            Toast.makeText(this, "Invalid", Toast.LENGTH_SHORT).show();
//    }
    public void jsonBuyShare() {

        prGenerateOrder.setVisibility(View.VISIBLE);

        Call<GenetareOrderModel> call = apiInterface.generateOrder(Constants.BASE_URL + "generate_order" + "&apikey=" + sessionManager.getApiKey()+"&shares="+share+"&someone="+someone+"&newuser="+newuser+"&email="+email+"&username="+username+"&notes="+notes);
        call.enqueue(new Callback<GenetareOrderModel>() {
            @Override
            public void onResponse(Call<GenetareOrderModel> call, Response<GenetareOrderModel> response) {

//                Log.d("BuyShare>>", "onResponse: " + response.body().toString());

                prGenerateOrder.setVisibility(View.GONE);

                if (response.body().getResponse_code() == 0) {

                    try {
                        if (response.body().getData().getPayment_method()!=null){
                            adapter = new gerateOrderAdapter(GenerateOrderActivity.this, response.body().getData().getPayment_method());
                            recyclerView.setAdapter(adapter);

                             mList=new ArrayList();

                             if (response.body().getData().getPayment_method().get(0).getArgs().getMode().equals("sandbox")){
//                                ///Paypal
//                                 config = new PayPalConfiguration()
//                                         .environment(PayPalConfiguration.ENVIRONMENT_SANDBOX)
//                                         .clientId(Config.PAYPAL_CLIENT_ID);
                                 ///braintree
                                 clientToken=response.body().getData().getPayment_method().get(0).getArgs().getClient_token();

                                 fees=Double.parseDouble(response.body().getData().getPayment_method().get(0).getArgs().getFees());
                             }else {
//                                 config = new PayPalConfiguration()
//                                         .environment(PayPalConfiguration.ENVIRONMENT_PRODUCTION)
//                                         .clientId(Config.PAYPAL_CLIENT_ID);
                                 clientToken=response.body().getData().getPayment_method().get(0).getArgs().getClient_token();
                                 fees=Double.parseDouble(response.body().getData().getPayment_method().get(0).getArgs().getFees());

                             }


                            for (int i=0;i<response.body().getData().getPayment_method().size();i++){
                                mList.addAll(response.body().getData().getPayment_method());
                            }

                            for (int j=0;j<mList.size();j++){
                                if (j==0){

                                    baseExpandableOptionObject.setTitleText(mList.get(0).getName());
                                    text1.setText( Html.fromHtml(mList.get(0).getArgs().getDetails()));
                                }
                                if (j==1){
                                    baseExpandableOptionObject1.setTitleText(mList.get(1).getName());
                                    text2.setText( Html.fromHtml(mList.get(1).getArgs().getDetails()));
                                }
                                if (j==2){
                                    baseExpandableOptionObject2.setTitleText(mList.get(2).getName());
                                    text3.setText( Html.fromHtml(mList.get(2).getArgs().getDetails()));
                                }
                                if (j==3){
                                    baseExpandableOptionObject3.setTitleText(mList.get(3).getName());
                                    text4.setText( Html.fromHtml(mList.get(3).getArgs().getDetails()));
                                }
                                if (j==4){
                                    baseExpandableOptionObject4.setTitleText(mList.get(4).getName());
                                    text5.setText( Html.fromHtml(mList.get(4).getArgs().getDetails()));
                                }
                            }



                        }
                        trx=String.valueOf(response.body().getData().getTrx_reference());
                        transRef.setText(String.valueOf(response.body().getData().getTrx_reference()));
                        sharePrice.setText(response.body().getData().getPrice());
                        shareToBuy.setText(String.valueOf(response.body().getData().getShares()));
                        totalAmount.setText(String.valueOf(response.body().getData().getAmount()));


                        /*

                         */
                        if (response.body().getData().isSomeone()){
                            rvReceiver.setVisibility(View.VISIBLE);
                            rvReceiverNote.setVisibility(View.VISIBLE);

                            receiver.setText(response.body().getData().getReceiver());
                            receiverNotes.setText(response.body().getData().getReceiver_notes());
                        }

                    }catch (Exception e){

                    }

                } else {
                    Toast.makeText(GenerateOrderActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<GenetareOrderModel> call, Throwable t) {

                Toast.makeText(GenerateOrderActivity.this, ""+t.getMessage(), Toast.LENGTH_SHORT).show();
                Log.d("TAG", "onFailure: "+t.getMessage());
            }
        });
    }

    public void jsonCompletePaypal(String nonce) {

        prGenerateOrder.setVisibility(View.VISIBLE);

        try {
            Call<BuyShareModel> call = apiInterface.pubShare(Constants.BASE_URL + "complete_paypal" + "&apikey=" + sessionManager.getApiKey()+"&trx_reference="+trx+"&device_data="+deviceData+"&nonce="+nonce);
            call.enqueue(new Callback<BuyShareModel>() {
                @Override
                public void onResponse(Call<BuyShareModel> call, Response<BuyShareModel> response) {

                    try {
                        Log.d("BuyShare>>", "onResponse: " + response.body().toString());

                        prGenerateOrder.setVisibility(View.GONE);

                        if (response.body().getResponse_code() == 0) {


                            Toast.makeText(GenerateOrderActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();
                            Intent intent =new Intent(GenerateOrderActivity.this,DrawerActivity.class);
                            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                            startActivity(intent);

                        } else {
                            Toast.makeText(GenerateOrderActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                        }
                    }catch (Exception e){

                    }


                }

                @Override
                public void onFailure(Call<BuyShareModel> call, Throwable t) {


                }
            });
        }catch (Exception e){

        }

    }
}