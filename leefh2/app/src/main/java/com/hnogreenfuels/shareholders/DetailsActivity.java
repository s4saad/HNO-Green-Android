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
import com.hnogreenfuels.shareholders.Model.LoginModel;
import com.hnogreenfuels.shareholders.Session.SessionManager;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class DetailsActivity extends AppCompatActivity {

    private EditText RefNo, initOrderDate, OrderId, shareholderId, shareholderName, shareholderEmail,
            shares, eachSharePrice, totalAmount, purchaseStatus;
    private TextView paymentMethod;
    private ArrayList paymentMethodList;
    private ArrayList paymentMethodListSlug;
    private TextView note,tvHeadingPayment,edtNonSelectPaymentMethod;

    private ArrayAdapter<String> adapter;
    private int selected = -1;
    private APIInterface apiInterface;
    private LinearLayout prDetails;
    private Button btnMove, btnComplete, btnCancel, btnFindAnother;
    private SessionManager sessionManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_details);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(DetailsActivity.this);

        RefNo = findViewById(R.id.edtReferenceNoD);
        RefNo.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        initOrderDate = findViewById(R.id.edtInitOrderDateD);
        initOrderDate.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        OrderId = findViewById(R.id.edtOrderIdD);
        OrderId.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        shareholderId = findViewById(R.id.edtShareHolderIdD);
        shareholderId.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        shareholderName = findViewById(R.id.edtShareHolderNameD);
        shareholderName.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        shareholderEmail = findViewById(R.id.edtShareholderEmailD);
        shareholderEmail.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        shares = findViewById(R.id.edtSharesD);
        shares.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        eachSharePrice = findViewById(R.id.edtSharesPriceD);
        eachSharePrice.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        totalAmount = findViewById(R.id.edtTotalAmountD);
        totalAmount.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        purchaseStatus = findViewById(R.id.edtPurchaseStatusD);
        purchaseStatus.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        prDetails = findViewById(R.id.prDetails);
        note = findViewById(R.id.tvNote);
        btnMove = findViewById(R.id.btnMoveToPending);
        btnComplete = findViewById(R.id.btnCompletePurchase);
        btnCancel = findViewById(R.id.btnCancelOrderD);
        btnFindAnother = findViewById(R.id.btnFindAnother);
        tvHeadingPayment=findViewById(R.id.tvHeadingPayment);

        edtNonSelectPaymentMethod=findViewById(R.id.edtNonSelectPaymentMethod);
        edtNonSelectPaymentMethod.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);


        paymentMethod = findViewById(R.id.tvSelectPaymentMethodD);
        paymentMethodList = new ArrayList();
        paymentMethodListSlug=new ArrayList();

        btnMove.setText(Constants.adminstratorDetails.getButtons().get(0).getName());
        btnCancel.setText(Constants.adminstratorDetails.getButtons().get(1).getName());
        btnComplete.setText(Constants.adminstratorDetails.getButtons().get(2).getName());

        if (Constants.adminstratorDetails.getPay_method_available()!=null){
            edtNonSelectPaymentMethod.setVisibility(View.GONE);
            for (int i=0;i<Constants.adminstratorDetails.getPay_method_available().size();i++)
            {
                paymentMethodList.add(Constants.adminstratorDetails.getPay_method_available().get(i).getName());
            }
            for (int i=0;i<Constants.adminstratorDetails.getPay_method_available().size();i++)
            {
                paymentMethodListSlug.add(Constants.adminstratorDetails.getPay_method_available().get(i).getSlug());
            }
        }else {
            paymentMethod.setVisibility(View.GONE);
            edtNonSelectPaymentMethod.setVisibility(View.VISIBLE);
            edtNonSelectPaymentMethod.setText(Constants.adminstratorDetails.getPay_method_name());
        }



        if (!Constants.adminstratorDetails.getButtons().get(0).isShow()) {
            btnMove.setVisibility(View.GONE);
        }
        if (!Constants.adminstratorDetails.getButtons().get(1).isShow()) {
            btnCancel.setVisibility(View.GONE);
        }
        if (!Constants.adminstratorDetails.getButtons().get(2).isShow()) {
            btnComplete.setVisibility(View.GONE);
        }


        btnMove.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                AlertDialog.Builder builder = new AlertDialog.Builder(DetailsActivity.this);

                builder.setTitle("Confirm");
                builder.setMessage("Are you sure?");

                builder.setPositiveButton("YES", new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialog, int which) {
                        // Do nothing but close the dialog

                        if (Constants.adminstratorDetails.getPay_method_available()!=null){
//                    if (selected!=-1){
                            jsonLogin(Constants.adminstratorDetails.getButtons().get(0).getSlug());
//                    }else {
//                        Toast.makeText(DetailsActivity.this, "Select Payment Method", Toast.LENGTH_SHORT).show();
//                    }
                        }else {
                            jsonLogin(Constants.adminstratorDetails.getButtons().get(0).getSlug());
                        }

                        dialog.dismiss();


                    }
                });

                builder.setNegativeButton("NO", new DialogInterface.OnClickListener() {

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


        btnCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                AlertDialog.Builder builder = new AlertDialog.Builder(DetailsActivity.this);

                builder.setTitle("Confirm");
                builder.setMessage("Are you sure?");

                builder.setPositiveButton("YES", new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialog, int which) {
                        // Do nothing but close the dialog

                        dialog.dismiss();

                        if (Constants.adminstratorDetails.getPay_method_available()!=null){
//                    if (selected!=-1){
                            jsonLogin(Constants.adminstratorDetails.getButtons().get(1).getSlug());
//                    }else {
//                        Toast.makeText(DetailsActivity.this, "Select Payment Method", Toast.LENGTH_SHORT).show();
//                    }
                        }else {
                            jsonLogin(Constants.adminstratorDetails.getButtons().get(1).getSlug());
                        }
                    }
                });

                builder.setNegativeButton("NO", new DialogInterface.OnClickListener() {

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
        btnComplete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                AlertDialog.Builder builder = new AlertDialog.Builder(DetailsActivity.this);

                builder.setTitle("Confirm");
                builder.setMessage("Are you sure?");

                builder.setPositiveButton("YES", new DialogInterface.OnClickListener() {

                    public void onClick(DialogInterface dialog, int which) {
                        // Do nothing but close the dialog

                        if (Constants.adminstratorDetails.getPay_method_available()!=null){
                            if (selected!=-1){
                                jsonLogin(Constants.adminstratorDetails.getButtons().get(2).getSlug());
                            }else {
                                Toast.makeText(DetailsActivity.this, "Select Payment Method", Toast.LENGTH_SHORT).show();
                            }}else {
                            jsonLogin(Constants.adminstratorDetails.getButtons().get(2).getSlug());
                        }

                        dialog.dismiss();


                    }
                });

                builder.setNegativeButton("NO", new DialogInterface.OnClickListener() {

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

        btnFindAnother.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent =new Intent(DetailsActivity.this,AdministratorActivity.class);
                startActivity(intent);
            }
        });
        adapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_dropdown_item, paymentMethodList);

        RefNo.setText(Constants.adminstratorDetails.getTrx_reference());
        initOrderDate.setText(Constants.adminstratorDetails.getOrder_date());
        OrderId.setText(Constants.adminstratorDetails.getOrder_id());
        shareholderId.setText(Constants.adminstratorDetails.getShareholder_id());
        shareholderName.setText(Constants.adminstratorDetails.getShareholder_name());
        shareholderEmail.setText(Constants.adminstratorDetails.getShareholder_email());
        shares.setText(Constants.adminstratorDetails.getShares());
        eachSharePrice.setText(Constants.adminstratorDetails.getShare_price());
        totalAmount.setText(Constants.adminstratorDetails.getTotal_amount());
        purchaseStatus.setText(Constants.adminstratorDetails.getDisplay_status());
        note.setText(Constants.adminstratorDetails.getNotes());
        paymentMethod.setText(Constants.adminstratorDetails.getPay_method_name());

        if (!Constants.adminstratorDetails.isEditable()) {
            note.setEnabled(false);
        }


        paymentMethod.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new AlertDialog.Builder(DetailsActivity.this)
                        .setTitle("Select Payment Method")
                        .setAdapter(adapter, new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                                selected = which;
                                Log.d("TAG", "onClick: " + which);
                                Log.d("TAG", "onClick: " + paymentMethodList.get(which).toString());
                                paymentMethod.setText(paymentMethodList.get(which).toString());


                                dialog.dismiss();
                            }
                        }).create().show();
            }
        });


    }

    public void jsonLogin(String slug) {

        prDetails.setVisibility(View.VISIBLE);
        String selectedPaymentMethod;
        if (Constants.adminstratorDetails.getPay_method_available()!=null){
            if(selected==-1){
                selectedPaymentMethod=" ";
            }else {
                selectedPaymentMethod=  paymentMethodListSlug.get(selected).toString();
            }

        }else {
            selectedPaymentMethod=Constants.adminstratorDetails.getPay_method_slug().toString();
        }
        Log.d("TAG", "onClick: " +"&click_action="+slug+"&pay_method="+selectedPaymentMethod+"&notes="+note.getText().toString());
        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"process_purchase"+"&apikey="+sessionManager.getApiKey()+"&trx_reference="+RefNo.getText().toString()+"&click_action="+slug+"&pay_method="+selectedPaymentMethod+"&notes="+note.getText().toString());
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {


                prDetails.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){

                    Toast.makeText(DetailsActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();


                }else {
                    Toast.makeText(DetailsActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {

                prDetails.setVisibility(View.GONE);

            }
        });
    }

}