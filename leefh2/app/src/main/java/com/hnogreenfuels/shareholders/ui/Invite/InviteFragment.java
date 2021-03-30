package com.hnogreenfuels.shareholders.ui.Invite;

import android.content.Intent;
import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hnogreenfuels.shareholders.BuildConfig;
import com.hnogreenfuels.shareholders.R;


public class InviteFragment extends Fragment {


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v= inflater.inflate(R.layout.fragment_invite, container, false);
//        ((AppCompatActivity) getActivity()).getSupportActionBar().hide();
//        Intent smsIntent = new Intent(Intent.ACTION_VIEW);
//        smsIntent.setType("vnd.android-dir/mms-sms");
//        smsIntent.putExtra("sms_body","Invitation URL here");
//        startActivity(smsIntent);
        try {
            Intent shareIntent = new Intent(Intent.ACTION_SEND);
            shareIntent.setType("text/plain");
            shareIntent.putExtra(Intent.EXTRA_SUBJECT, "HNO Portal");
            String shareMessage= "\nLet me recommend to you the HNO Shareholders Portal mobile app where you can view your HNO Green Fuels Shares, manage your profile & much more... Its easy & fast now!\n" +
                    "\n" +
                    "Download for Android:\n" +
                    "https://play.google.com/store/apps/details?id=" + BuildConfig.APPLICATION_ID  +
                    "\n" +
                    "\n" +
                    "Download for iOS:\n" +
                    "https://apps.apple.com/us/app/hno-shareholder-portal/id1538412452\n\n";
//            shareMessage = shareMessage + "https://play.google.com/store/apps/details?id=" + BuildConfig.APPLICATION_ID +"\n\n";
            shareIntent.putExtra(Intent.EXTRA_TEXT, shareMessage);
            startActivity(Intent.createChooser(shareIntent, "choose one"));
        } catch(Exception e) {
            //e.toString();
        }

        return  v;
    }
}