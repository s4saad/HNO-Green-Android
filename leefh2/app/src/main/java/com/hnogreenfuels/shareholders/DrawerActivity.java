package com.hnogreenfuels.shareholders;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.widget.ImageView;
import android.widget.TextView;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Common.Functions;
import com.hnogreenfuels.shareholders.Model.ProfileModel;
import com.hnogreenfuels.shareholders.Session.SessionManager;
import com.google.android.material.navigation.NavigationView;
import com.squareup.picasso.Picasso;

import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class DrawerActivity extends AppCompatActivity {

    private AppBarConfiguration mAppBarConfiguration;
    private SessionManager sessionManager;
    private APIInterface apiInterface;
    private  TextView navUsername;
    private TextView navShareholderId;
    public static ImageView imageViewProfile;
    public static String stSelectedImage;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_drawer);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        Functions.initForOrientation(DrawerActivity.this);


        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(DrawerActivity.this);
//        FloatingActionButton fab = findViewById(R.id.fab);
//        fab.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
//                        .setAction("Action", null).show();
//            }
//        });
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        NavigationView navigationView = findViewById(R.id.nav_view);

        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        mAppBarConfiguration = new AppBarConfiguration.Builder(
                R.id.nav_transaction, R.id.nav_gallery, R.id.nav_buy_shares,R.id.nav_profile,R.id.nav_shareholder_update,R.id.nav_username_password,R.id.nav_transfer_shares,R.id.nav_logout)
                .setDrawerLayout(drawer)
                .build();
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        NavigationUI.setupActionBarWithNavController(this, navController, mAppBarConfiguration);
        NavigationUI.setupWithNavController(navigationView, navController);


        View headerView = navigationView.getHeaderView(0);
        navUsername = (TextView) headerView.findViewById(R.id.drawerName);
        navShareholderId = (TextView) headerView.findViewById(R.id.drawerShareholderId);
        imageViewProfile=headerView.findViewById(R.id.imageViewProfile);


        jsonProfile();

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.drawer, menu);
        return true;
    }

    @Override
    public boolean onSupportNavigateUp() {
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        return NavigationUI.navigateUp(navController, mAppBarConfiguration)
                || super.onSupportNavigateUp();
    }
    public void jsonProfile() {



        Call<ProfileModel> call = apiInterface.profile(Constants.BASE_URL + "view_profile" + "&apikey=" + sessionManager.getApiKey());
        call.enqueue(new Callback<ProfileModel>() {
            @Override
            public void onResponse(Call<ProfileModel> call, Response<ProfileModel> response) {

                Log.d("profile>>", "onResponse: " + response.body().toString());



                if (response.body().getResponse_code() == 0) {


                    navUsername.setText(response.body().getData().getFirstname()+" "+response.body().getData().getMiddlename()+" "+response.body().getData().getLastname());
                    navShareholderId.setText(response.body().getData().getShareholder_id());

                    Picasso.with(DrawerActivity.this).load(response.body().getData().getSelected_profile().getLink()).into(imageViewProfile);

//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                } else {

                }

            }

            @Override
            public void onFailure(Call<ProfileModel> call, Throwable t) {


            }
        });
    }


//    @Override
//    public boolean onOptionsItemSelected(MenuItem item)
//    {
//        Log.d("item", "onOptionsItemSelected: "+item.getItemId());
//      return true;
//    }
}