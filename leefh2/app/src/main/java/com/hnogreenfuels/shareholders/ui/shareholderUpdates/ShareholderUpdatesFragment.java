package com.hnogreenfuels.shareholders.ui.shareholderUpdates;

import android.os.Bundle;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Model.ShareholderUpdates;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;
import com.hnogreenfuels.shareholders.adapter.ShareholderUpdatesAdapter;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ShareholderUpdatesFragment extends Fragment {

    private ShareholderUpdatesAdapter adapter;
    private LinearLayout prShareholderUpdates;
    private SessionManager sessionManager;
    private APIInterface apiInterface;
    private RecyclerView recyclerView;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View v = inflater.inflate(R.layout.fragment_file_download, container, false);

        prShareholderUpdates=v.findViewById(R.id.prShareholderUpdates);
        recyclerView = v.findViewById(R.id.rvShareholderUpdates);


        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(getActivity());
        // data to populate the RecyclerView with


        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false));
        jsonTransaction();
        return v;
    }

    public void jsonTransaction() {

        prShareholderUpdates.setVisibility(View.VISIBLE);

        Call<ShareholderUpdates> call = apiInterface.shareholderupdates(Constants.BASE_URL+"list_shareholder_updates"+"&apikey="+sessionManager.getApiKey());
        call.enqueue(new Callback<ShareholderUpdates>() {
            @Override
            public void onResponse(Call<ShareholderUpdates> call, Response<ShareholderUpdates> response) {

                Log.d("transactions>>", "onResponse: "+response.body().toString());

                prShareholderUpdates.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){

                    try {
                        if (response.body().getData().getList()!=null){
                            adapter = new ShareholderUpdatesAdapter(getActivity(), response.body().getData().getList());
                            recyclerView.setAdapter(adapter);

                        }

                    }catch (Exception e){

                    }


//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }else {
                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<ShareholderUpdates> call, Throwable t) {


            }
        });
    }
}