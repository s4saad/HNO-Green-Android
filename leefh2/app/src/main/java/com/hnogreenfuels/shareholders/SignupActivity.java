package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.app.Dialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.text.InputType;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Common.Functions;
import com.hnogreenfuels.shareholders.Model.LoginModel;
import com.hnogreenfuels.shareholders.adapter.imagesAdapter;
import com.hnogreenfuels.shareholders.adapter.imagesProfileAdapter;
import com.squareup.picasso.Picasso;
import com.ybs.countrypicker.CountryPicker;
import com.ybs.countrypicker.CountryPickerListener;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import static com.hnogreenfuels.shareholders.DrawerActivity.imageViewProfile;

public class SignupActivity extends AppCompatActivity {

    private LinearLayout prSignup;
    private APIInterface apiInterface;
    private TextView spinner;
    private static final String[] paths = {"Individual", "Company / Group"};
    private ArrayAdapter<String> adapter;
    private EditText username, email, password, confirmPassword, tax, firstName, middleName,
            comapny, lastName, address, city, state, zipCode, homeNo, cellNo,suffix;
    private Button btnSignup;
    private int selected=-1;
    private TextView country;
    private  Dialog dialog;
    private RecyclerView rvTest;
    public static String selectedImageCode;
    private ImageView imgProfile;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);

        Functions.initForOrientation(SignupActivity.this);
        apiInterface = APIClient.getClient().create(APIInterface.class);

        btnSignup=findViewById(R.id.btnSignup);
        prSignup=findViewById(R.id.prSignup);
        spinner = findViewById(R.id.spinner);
        adapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_dropdown_item, paths);

        username = findViewById(R.id.userNameS);
//        username.setInputType(InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        username.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);
        email = findViewById(R.id.emailS);
        email.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);
        password = findViewById(R.id.passwordS);
        password.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        confirmPassword = findViewById(R.id.confirmPasswordS);
        confirmPassword.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        tax = findViewById(R.id.taxS);
        tax.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        firstName = findViewById(R.id.firstNameS);
        firstName.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        middleName = findViewById(R.id.middleNameS);
        middleName.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        comapny = findViewById(R.id.companyS);
        comapny.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        lastName = findViewById(R.id.lastNameS);
        lastName.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        address = findViewById(R.id.addressS);
        address.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        city = findViewById(R.id.cityS);
        city.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        state = findViewById(R.id.stateS);
        state.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        country = findViewById(R.id.countryS);
        country.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        zipCode = findViewById(R.id.codeS);
        zipCode.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        homeNo = findViewById(R.id.homeNoS);
        homeNo.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        cellNo = findViewById(R.id.cellNoS);
        cellNo.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        suffix=findViewById(R.id.suffixS);
        suffix.setInputType(InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD);

        imgProfile=findViewById(R.id.imgProfileS);

        spinner.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new AlertDialog.Builder(SignupActivity.this)
                        .setTitle("Shareholder Type")
                        .setAdapter(adapter, new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                                selected=which;
                                Log.d("TAG", "onClick: " + which);
                                spinner.setText(paths[which]);
                                if (which==1){
//                                    firstName.setVisibility(View.GONE);
                                    middleName.setVisibility(View.GONE);
                                    comapny.setVisibility(View.VISIBLE);
                                }
                                if (which==0){
                                    firstName.setVisibility(View.VISIBLE);
                                    middleName.setVisibility(View.VISIBLE);
                                    comapny.setVisibility(View.GONE);
                                }

                                dialog.dismiss();
                            }
                        }).create().show();
            }
        });


        country.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                final CountryPicker picker = CountryPicker.newInstance("Select Country");  // dialog title
                picker.setListener(new CountryPickerListener() {
                    @Override
                    public void onSelectCountry(String name, String code, String dialCode, int flagDrawableResID) {
                        // Implement your code here
                        country.setText(name);
                        picker.dismiss();
                    }
                });
                picker.show(getSupportFragmentManager(), "COUNTRY_PICKER");
            }
        });
        btnSignup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if (Functions.isEmpty(username))
                    username.setError("Enter Username");
                if (Functions.isEmpty(email))
                    email.setError("Enter Email");
                if (Functions.isEmpty(password))
                    password.setError("Enter Password");
                if (Functions.isEmpty(confirmPassword))
                    confirmPassword.setError("Enter Confirm Password");
                if (Functions.isEmpty(tax))
                    tax.setError("Enter tax");
                if (selected==-1)
                    Toast.makeText(SignupActivity.this, "Select Shareholder Type", Toast.LENGTH_SHORT).show();

                if (selected==0){
                    if (Functions.isEmpty(firstName))
                        firstName.setError("Enter First Name");
                }

                if (selected==1){
                    if (Functions.isEmpty(middleName))
                        middleName.setError("Enter Middle Name");
                }

                if (selected==1){
                    if (Functions.isEmpty(comapny))
                        comapny.setError("Enter Company");
                }


                if (Functions.isEmpty(lastName))
                    lastName.setError("Enter Last Name");
//                if (Functions.isEmpty(suffix))
//                    suffix.setError("Enter Suffix");
                if (Functions.isEmpty(address)||address.getText().length()<5)
                    address.setError("Enter Address");
//                if (address.getText().length()<5)
//                    address.setError("Enter Address");
                if (Functions.isEmpty(city)||city.getText().length()<2)
                    city.setError("Enter City");
                if (Functions.isEmpty(state)||state.getText().length()<1)
                    state.setError("Enter State");
//                if (Functions.isEmpty(country))
//                    country.setError("Enter Country");
                if (Functions.isEmpty(zipCode)|zipCode.getText().length()<1)
                    zipCode.setError("Enter Zip Code");
//                if (Functions.isEmpty(homeNo))
//                    homeNo.setError("Enter Home No");
//                if (Functions.isEmpty(cellNo))
//                    cellNo.setError("Enter Cell No");

                if (!Functions.isEmpty(password)){
                    if (!password.getText().toString().equals(confirmPassword.getText().toString())){
                        Toast.makeText(SignupActivity.this, "Enter Same Password", Toast.LENGTH_SHORT).show();
                    }
                }

                if (!Functions.isValidEmail(email.getText()))
                {
                    email.setError("Enter valid Email");
                }
                if (!Functions.isEmpty(username)
                        &&!Functions.isEmpty(email)
                        &&!Functions.isEmpty(password)
                        &&!Functions.isEmpty(confirmPassword)
                        &&!Functions.isEmpty(tax)
                        &&selected!=-1
                        &&!Functions.isEmpty(lastName)
                        &&!Functions.isEmpty(address)
                        &&address.getText().length()>=5
                        &&!Functions.isEmpty(city)
                        &&city.getText().length()>=2
                        &&!Functions.isEmpty(state)
                        &&state.getText().length()>=1
                        &&!Functions.isEmpty(zipCode)
                        &&zipCode.getText().length()>=1
                        &&password.getText().toString().equals(confirmPassword.getText().toString())){

                    if (Constants.checkInternetConnection(SignupActivity.this)){
                        Log.d("TAG", "jsonSignUP: "+firstName.getText().toString());
                        jsonSignUP();
                    }else {
                        Toast.makeText(SignupActivity.this, "No internet connection", Toast.LENGTH_SHORT).show();
                    }
                   ;
                }

            }
        });

        dialog = new Dialog(SignupActivity.this);
        dialog.getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        dialog.getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        dialog.setContentView(R.layout.item_image_list);
        dialog.setCanceledOnTouchOutside(true);
        dialog.setCancelable(true);


        rvTest = (RecyclerView) dialog.findViewById(R.id.imagesRecycler);
        rvTest.setHasFixedSize(true);
        rvTest.setLayoutManager(new LinearLayoutManager(SignupActivity.this));
//                rvTest.addItemDecoration(new SimpleDividerItemDecoration(context, R.drawable.divider));




        imagesProfileAdapter rvAdapter = new imagesProfileAdapter(SignupActivity.this, Constants.allPics,dialog,imgProfile);
        rvTest.setAdapter(rvAdapter);

        imgProfile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.show();
            }
        });
    }

    public void jsonSignUP() {

        Log.d("TAG", "jsonSignUP: "+firstName.getText().toString());

        prSignup.setVisibility(View.VISIBLE);

        Call<LoginModel> call = apiInterface.login(Constants.BASE_URL+"signup"+"&username="+username.getText().toString()+"&password="+Uri.encode(password.getText().toString())+"&re_password="+Uri.encode(confirmPassword.getText().toString())+"&email="+email.getText().toString()+"&ssn="+tax.getText().toString()+"&type="+paths[selected]+"&firstname="+firstName.getText().toString()+"&middlename="+middleName.getText().toString()+"&company&lastname="+lastName.getText().toString()+"&suffix="+suffix.getText().toString()+"&address="+address.getText().toString()+"&city="+city.getText().toString()+"&state="+state.getText().toString()+"&country="+country.getText().toString()+"&zipcode="+zipCode.getText().toString()+"&cell="+cellNo.getText().toString()+"&home="+homeNo.getText().toString()+"&profile="+selectedImageCode+"&company="+comapny.getText().toString());
        call.enqueue(new Callback<LoginModel>() {
            @Override
            public void onResponse(Call<LoginModel> call, Response<LoginModel> response) {

                Log.d("signUp>>", "onResponse: "+response.body().toString());

                prSignup.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){


                    Toast.makeText(SignupActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();
                    Intent intent =new Intent(SignupActivity.this,LoginActivity.class);
                    startActivity(intent);
                }else {
                    Toast.makeText(SignupActivity.this, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<LoginModel> call, Throwable t) {


            }
        });
    }

}