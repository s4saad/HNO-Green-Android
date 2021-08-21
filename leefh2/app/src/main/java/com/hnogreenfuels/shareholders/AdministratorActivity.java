package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.InputType;
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
import com.hnogreenfuels.shareholders.Model.AdministratorModel;
import com.hnogreenfuels.shareholders.Session.SessionManager;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class AdministratorActivity extends AppCompatActivity {

    private EditText refNo;
    private TextView logout;
    private Button btnFindDetails;
    private APIInterface apiInterface;
    private LinearLayout prAdministrator;
    private SessionManager sessionManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_administrator);

        refNo=findViewById(R.id.edtReferenceNo);
        refNo.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        logout=findViewById(R.id.tvLogout);
        btnFindDetails=findViewById(R.id.btnFindDetails);
        prAdministrator=findViewById(R.id.prAdministrator);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(AdministratorActivity.this);

        btnFindDetails.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (Functions.isEmpty(refNo))
                    refNo.setError("Enter Ref No");

                if (!Functions.isEmpty(refNo))
                {
                    if (Constants.checkInternetConnection(AdministratorActivity.this)){
                        jsonLogin();
                    }else {
                        Toast.makeText(AdministratorActivity.this, "No internet connection", Toast.LENGTH_SHORT).show();
                    }

                }
            }
        });
        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                sessionManager = new SessionManager(AdministratorActivity.this);
                sessionManager.logout();
                Intent intent =new Intent(AdministratorActivity.this, LoginActivity.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(intent);

                finish();
            }
        });

    }

    public void jsonLogin() {

        prAdministrator.setVisibility(View.VISIBLE);

        Call<AdministratorModel> call = apiInterface.Administrator(Constants.BASE_URL+"fetch_purchase"+"&apikey="+sessionManager.getApiKey()+"&trx_reference="+refNo.getText().toString());
        call.enqueue(new Callback<AdministratorModel>() {
            @Override
            public void onResponse(Call<AdministratorModel> call, Response<AdministratorModel> response) {

                Log.d("Administrator>>", "onResponse: "+response.body().toString());

                prAdministrator.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){

                    Constants.adminstratorDetails=response.body().getData();

                    Intent intent=new Intent(AdministratorActivity.this,DetailsActivity.class);
                    startActivity(intent);

                }else {
                    Toast.makeText(AdministratorActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<AdministratorModel> call, Throwable t) {
                prAdministrator.setVisibility(View.GONE);

                Log.d("TAG", "onFailure: "+t.getMessage());

            }
        });
    }
}