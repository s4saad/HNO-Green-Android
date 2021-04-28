package com.hnogreenfuels.shareholders.ui.transaction;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.iid.FirebaseInstanceId;
import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Model.TransactionsModel;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;
import com.hnogreenfuels.shareholders.adapter.transactionAdapter;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class TransactionsFragment extends Fragment {

    private HomeViewModel homeViewModel;
    transactionAdapter adapter;
    private SessionManager sessionManager;
    private APIInterface apiInterface;
    private LinearLayout prTransactions;
    private RecyclerView recyclerView;
    private TextView tvTotalTransaction;
    private TextView tvTotalAmount;
    private TextView tvTotalShares;


    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        homeViewModel =
                ViewModelProviders.of(this).get(HomeViewModel.class);
        View root = inflater.inflate(R.layout.fragment_transactions, container, false);
        final TextView textView = root.findViewById(R.id.text_home);
        prTransactions=root.findViewById(R.id.prTransactions);
        recyclerView = root.findViewById(R.id.rvTransaction);
        tvTotalAmount=root.findViewById(R.id.tvTotalAmount);
        tvTotalTransaction=root.findViewById(R.id.tvTotalTransaction);
        tvTotalShares=root.findViewById(R.id.tvTotalShares);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(getActivity());




        // set up the RecyclerView
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity(),LinearLayoutManager.VERTICAL, false));

        homeViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                textView.setText(s);
            }
        });
        if (Constants.checkInternetConnection(getActivity())){
            jsonTransaction();
        }else {
            Toast.makeText(getActivity(), "No internet connection", Toast.LENGTH_SHORT).show();
        }


        return root;
    }

    public void jsonTransaction() {

        prTransactions.setVisibility(View.VISIBLE);

        Call<TransactionsModel> call = apiInterface.transactions(Constants.BASE_URL+"list_transactions"+"&apikey="+sessionManager.getApiKey()+"&device_key="+FirebaseInstanceId.getInstance().getToken());
        call.enqueue(new Callback<TransactionsModel>() {
            @Override
            public void onResponse(Call<TransactionsModel> call, Response<TransactionsModel> response) {

                Log.d("transactions>>", "onResponse: "+response.body().toString());

                prTransactions.setVisibility(View.GONE);

                if(response.body().getResponse_code()==0){

                    try {
                        if (response.body().getData().getList()!=null){
                            adapter = new transactionAdapter(getActivity(), response.body().getData().getList());
                            recyclerView.setAdapter(adapter);

                        }
                        tvTotalAmount.setText(response.body().getData().getTotals().getAmount());
                        tvTotalTransaction.setText(String.valueOf(response.body().getData().getTotals().getTransactions()));
                        tvTotalShares.setText(String.valueOf(response.body().getData().getTotals().getShares()));

                    }catch (Exception e){

                    }


//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }else {
                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<TransactionsModel> call, Throwable t) {


            }
        });
    }
}