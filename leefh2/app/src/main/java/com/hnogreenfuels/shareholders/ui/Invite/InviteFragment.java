package com.hnogreenfuels.shareholders.ui.Invite;

import android.content.Intent;
import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hnogreenfuels.shareholders.BuildConfig;
import com.hnogreenfuels.shareholders.LoginActivity;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;


public class InviteFragment extends Fragment {
    private SessionManager sessionManager;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v= inflater.inflate(R.layout.fragment_invite, container, false);
        sessionManager = new SessionManager(getActivity());
//        ((AppCompatActivity) getActivity()).getSupportActionBar().hide();
//        Intent smsIntent = new Intent(Intent.ACTION_VIEW);
//        smsIntent.setType("vnd.android-dir/mms-sms");
//        smsIntent.putExtra("sms_body","Invitation URL here");
//        startActivity(smsIntent);
        Log.d("Invitee", "onCreateView: "+sessionManager.getInvite());
        try {
            Intent shareIntent = new Intent(Intent.ACTION_SEND);
            shareIntent.setType("text/plain");
            shareIntent.putExtra(Intent.EXTRA_SUBJECT, "HNO Portal");
            String shareMessage= sessionManager.getInvite();
//            shareMessage = shareMessage + "https://play.google.com/store/apps/details?id=" + BuildConfig.APPLICATION_ID +"\n\n";
            shareIntent.putExtra(Intent.EXTRA_TEXT, shareMessage);
            startActivity(Intent.createChooser(shareIntent, "choose one"));
        } catch(Exception e) {
            //e.toString();
        }

        return  v;
    }
}