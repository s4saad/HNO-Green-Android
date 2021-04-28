package com.hnogreenfuels.shareholders.ui.profile;

import android.app.Dialog;
import android.content.DialogInterface;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;

import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.navigation.NavigationView;
import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Common.Functions;
import com.hnogreenfuels.shareholders.Model.ProfileModel;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;
import com.hnogreenfuels.shareholders.adapter.imagesAdapter;
import com.squareup.picasso.Picasso;
import com.ybs.countrypicker.CountryPicker;
import com.ybs.countrypicker.CountryPickerListener;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import static com.hnogreenfuels.shareholders.DrawerActivity.imageViewProfile;

public class ProfileFragment extends Fragment {

    private APIInterface apiInterface;
    private SessionManager sessionManager;
    private LinearLayout prProfile;
    private EditText shareHolderId;
    private EditText taxID;
    private EditText email;
    private EditText firstName;
    private EditText middileName;
    private EditText lastName;
    private EditText suffix;
    private EditText address;
    private EditText cell;
    private EditText type;
    private EditText city;
    private EditText state;
    private TextView country;
    private EditText zipcode;
    private EditText home;
    private Button btnEdit;
    private EditText username;
    private EditText edtGroupName;
    private TextView spinner;
    private static final String[] paths = {"Individual", "Company / Group"};
    private ArrayAdapter<String> adapter;
    private int selected=-1;
    private TextView tvfirstName,tvmiddleName,tvGroupName;
    private ImageView imgProfile;
    private  Dialog dialog;
    private RecyclerView rvTest;
    public static String selectedImageCode;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_profile, container, false);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(getActivity());


        prProfile = v.findViewById(R.id.prProfile);
        shareHolderId = v.findViewById(R.id.edtShareHolderIdP);
        taxID = v.findViewById(R.id.edtTaxIDP);
        email = v.findViewById(R.id.edtEmailP);
        firstName = v.findViewById(R.id.edtFirsrNameP);
        middileName = v.findViewById(R.id.edtMiddleNameP);
        lastName = v.findViewById(R.id.edtLasrNameP);
        suffix = v.findViewById(R.id.edtSuffixP);
        imgProfile=v.findViewById(R.id.imgProfile);

        address = v.findViewById(R.id.edtAddressP);
        cell = v.findViewById(R.id.edtCellP);
        username=v.findViewById(R.id.edtUsernameP);
        tvfirstName=v.findViewById(R.id.tvfirstName);
        tvmiddleName=v.findViewById(R.id.tvmiddleName);

        tvGroupName=v.findViewById(R.id.tvGroupName);
        edtGroupName=v.findViewById(R.id.edtGrounpName);

        tvGroupName.setVisibility(View.GONE);
        edtGroupName.setVisibility(View.GONE);

        spinner = v.findViewById(R.id.edtTypeP);
        city = v.findViewById(R.id.edtCityP);
        state = v.findViewById(R.id.edtStateP);
        country = v.findViewById(R.id.edtCountryP);
        zipcode = v.findViewById(R.id.edtZipCodeP);
        home = v.findViewById(R.id.edtHomeP);

        btnEdit=v.findViewById(R.id.btnEdit);

        ///drawer image


        adapter = new ArrayAdapter<String>(getActivity(),
                android.R.layout.simple_spinner_dropdown_item, paths);

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
                picker.show(getActivity().getSupportFragmentManager(), "COUNTRY_PICKER");
            }
        });
        btnEdit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if (Functions.isEmpty(username))
                    username.setError("Enter Username");
                if (Functions.isEmpty(email))
                    email.setError("Enter Email");

                if (Functions.isEmpty(taxID))
                    taxID.setError("Enter tax");
//                if (selected==-1)
//                    Toast.makeText(SignupActivity.this, "Select Shareholder Type", Toast.LENGTH_SHORT).show();

//                if (selected==0){
//                    if (Functions.isEmpty(firstName))
//                        firstName.setError("Enter First Name");
//                }
//
//                if (selected==1){
//                    if (Functions.isEmpty(middleName))
//                        middleName.setError("Enter Middle Name");
//                }

//                if (selected==1){
//                    if (Functions.isEmpty(comapny))
//                        comapny.setError("Enter Company");
//                }


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

                if (Functions.isEmpty(zipcode)|zipcode.getText().length()<1)
                    zipcode.setError("Enter Zip Code");

                if (!Functions.isEmpty(username)
                        &&!Functions.isEmpty(email)
                        &&!Functions.isEmpty(taxID)
                        &&!Functions.isEmpty(lastName)
                        &&!Functions.isEmpty(address)
                        &&address.getText().length()>=5
                        &&!Functions.isEmpty(city)
                        &&city.getText().length()>=2
                        &&!Functions.isEmpty(state)
                        &&state.getText().length()>=1
                        &&!Functions.isEmpty(zipcode)
                        &&zipcode.getText().length()>=1){

                    if (selected==1){
                        if (Functions.isEmpty(edtGroupName))
                            edtGroupName.setError("Enter Group Name");
                        if (!Functions.isEmpty(edtGroupName))
                        {
                            jsonEditProfile();
                        }
                    }else {
                        jsonEditProfile();
                    }

                }

            }
        });

        dialog = new Dialog(getActivity());
        dialog.getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        dialog.getWindow().setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        dialog.setContentView(R.layout.item_image_list);
        dialog.setCanceledOnTouchOutside(true);
        dialog.setCancelable(true);


        rvTest = (RecyclerView) dialog.findViewById(R.id.imagesRecycler);
        rvTest.setHasFixedSize(true);
        rvTest.setLayoutManager(new LinearLayoutManager(getActivity()));
//                rvTest.addItemDecoration(new SimpleDividerItemDecoration(context, R.drawable.divider));


        imgProfile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.show();
            }
        });
        spinner.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new AlertDialog.Builder(getActivity())
                        .setTitle("Shareholder Type")
                        .setAdapter(adapter, new DialogInterface.OnClickListener() {

                            @Override
                            public void onClick(DialogInterface dialog, int which) {

                                selected=which;
                                Log.d("TAG", "onClick: " + which);
                                spinner.setText(paths[which]);
                                if (which==1){
//                                    firstName.setVisibility(View.GONE);
                                    middileName.setVisibility(View.GONE);
//                                    tvfirstName.setVisibility(View.GONE);
                                    tvmiddleName.setVisibility(View.GONE);

                                    tvGroupName.setVisibility(View.VISIBLE);
                                    edtGroupName.setVisibility(View.VISIBLE);
                                }
                                if (which==0){
                                    firstName.setVisibility(View.VISIBLE);
                                    middileName.setVisibility(View.VISIBLE);
                                    tvfirstName.setVisibility(View.VISIBLE);
                                    tvmiddleName.setVisibility(View.VISIBLE);


                                    tvGroupName.setVisibility(View.GONE);
                                    edtGroupName.setVisibility(View.GONE);
                                }

                                dialog.dismiss();
                            }
                        }).create().show();
            }
        });

        jsonProfile();
        return v;
    }


    public void jsonProfile() {

        prProfile.setVisibility(View.VISIBLE);

        Call<ProfileModel> call = apiInterface.profile(Constants.BASE_URL + "view_profile" + "&apikey=" + sessionManager.getApiKey());
        call.enqueue(new Callback<ProfileModel>() {
            @Override
            public void onResponse(Call<ProfileModel> call, Response<ProfileModel> response) {

                Log.d("profile>>", "onResponse: " + response.body().toString());

                prProfile.setVisibility(View.GONE);

                if (response.body().getResponse_code() == 0) {

                    shareHolderId.setText(response.body().getData().getShareholder_id());
                    taxID.setText(response.body().getData().getSsn());
                    email.setText(response.body().getData().getEmail());
                    firstName.setText(response.body().getData().getFirstname());
                    middileName.setText(response.body().getData().getMiddlename());
                    lastName.setText(response.body().getData().getLastname());
                    suffix.setText(response.body().getData().getSuffix());
                    edtGroupName.setText(response.body().getData().getCompany());
                    address.setText(response.body().getData().getAddress());
                    cell.setText(response.body().getData().getCell());
                    username.setText(response.body().getData().getUsername());

                    spinner.setText(response.body().getData().getType());
                    city.setText(response.body().getData().getCity());
                    state.setText(response.body().getData().getState());
                    country.setText(response.body().getData().getCountry());
                    zipcode.setText(response.body().getData().getZipcode());
                    home.setText(response.body().getData().getHome());

                    Picasso.with(getActivity()).load(response.body().getData().getSelected_profile().getLink()).into(imgProfile);
                    selectedImageCode=response.body().getData().getSelected_profile().getCode();

                    Log.d("images_list", "onResponse: "+response.body().getData().getPpics_all());
                    imagesAdapter rvAdapter = new imagesAdapter(getActivity(), response.body().getData().getPpics_all(),dialog,imgProfile);
                    rvTest.setAdapter(rvAdapter);

                    Picasso.with(getActivity()).load(response.body().getData().getSelected_profile().getLink()).into(imageViewProfile);
//                  Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                } else {

                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<ProfileModel> call, Throwable t) {


            }
        });
    }
    public void jsonEditProfile() {

        prProfile.setVisibility(View.VISIBLE);

        Call<ProfileModel> call = apiInterface.profile(Constants.BASE_URL + "edit_profile" + "&apikey=" + sessionManager.getApiKey()+"&email="+email.getText().toString()+"&firstname="+firstName.getText().toString()+"&middlename="+middileName.getText().toString()+"&company="+edtGroupName.getText().toString()+"&lastname="+lastName.getText().toString()+"&suffix="+suffix.getText().toString()+"&address="+address.getText().toString()+"&city="+city.getText().toString()+"&state="+state.getText().toString()+"&country="+country.getText().toString()+"&zipcode="+zipcode.getText().toString()+"&cell="+cell.getText().toString()+"&home="+home.getText().toString()+"&profile="+selectedImageCode);
        call.enqueue(new Callback<ProfileModel>() {
            @Override
            public void onResponse(Call<ProfileModel> call, Response<ProfileModel> response) {

                Log.d("profile>>", "onResponse: " + response.body().toString());

                prProfile.setVisibility(View.GONE);

                if (response.body().getResponse_code() == 0) {


                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                } else {
                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<ProfileModel> call, Throwable t) {


            }
        });
    }
}