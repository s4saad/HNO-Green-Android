package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.DecelerateInterpolator;
import android.widget.ImageView;

import com.hnogreenfuels.shareholders.Common.Functions;
import com.hnogreenfuels.shareholders.Session.SessionManager;

public class SplashActivity extends AppCompatActivity {

    private SessionManager sessionManager;
    private ImageView imgLogo;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        Functions.initForOrientation(SplashActivity.this);

        sessionManager = new SessionManager(SplashActivity.this);
        imgLogo=findViewById(R.id.imgLogo);

        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {

//                if (sessionManager.isLoggedIn()) {
//                    Intent intent = new Intent(SplashActivity.this, DrawerActivity.class);
//                    startActivity(intent);
//                    finish();
//                }else {
                    Intent intent = new Intent(SplashActivity.this, LoginActivity.class);
                    startActivity(intent);
                    finish();

//                }

            }
        }, 3000);

        imgLogo.animate().alpha(0).setDuration(1000).setInterpolator(new DecelerateInterpolator()).withEndAction(new Runnable() {
            @Override
            public void run() {
                imgLogo.animate().alpha(1).setDuration(1000).setInterpolator(new AccelerateInterpolator()).withEndAction(new Runnable() {
                    @Override
                    public void run() {
                        imgLogo.animate().alpha(0).setDuration(1000).setInterpolator(new AccelerateInterpolator()).start();
                    }
                });
            }
        }).start();
    }

    @Override
    protected void onStart() {
        super.onStart();
    }
}