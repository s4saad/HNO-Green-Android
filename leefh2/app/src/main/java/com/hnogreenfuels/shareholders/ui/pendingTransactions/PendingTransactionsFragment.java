package com.hnogreenfuels.shareholders.ui.pendingTransactions;

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

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Model.pendingPurchaseModel;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;
import com.hnogreenfuels.shareholders.adapter.transactionPendingAdapter;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class PendingTransactionsFragment extends Fragment {

    private GalleryViewModel galleryViewModel;
    transactionPendingAdapter adapter;
    private SessionManager sessionManager;
    private APIInterface apiInterface;
    private LinearLayout prTransactions;
    private RecyclerView recyclerView;
    private TextView tvTotalTransaction;
    private TextView tvTotalAmount;
    private TextView tvTotalShares;
    private List<pendingPurchaseModel.Data.lists> mList;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        galleryViewModel =
                ViewModelProviders.of(this).get(GalleryViewModel.class);
        View root = inflater.inflate(R.layout.fragment_pending_transactions, container, false);
        final TextView textView = root.findViewById(R.id.text_gallery);


        mList = new ArrayList<>();

        prTransactions = root.findViewById(R.id.prPendingTransactions);
        recyclerView = root.findViewById(R.id.rvPendingTransaction);
        tvTotalAmount = root.findViewById(R.id.tvTotalPendingAmount);
        tvTotalTransaction = root.findViewById(R.id.tvTotalPendingTransaction);
        tvTotalShares = root.findViewById(R.id.tvTotalPendingShares);

        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(getActivity());
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false));

//        recyclerView.addOnItemTouchListener(
//                new RecyclerItemClickListener(getActivity(), recyclerView, new RecyclerItemClickListener.OnItemClickListener() {
//                    @Override
//                    public void onItemClick(View view, int position) {
//
//                        Button button=view.findViewById(R.id.btnCancelOrder);
////
//
//
////                       if (R.id.btnCancelOrder==button.getId())
////                       {
////                           Log.d("print", "onItemClick: "+button.getId()+"  "+R.id.btnCancelOrder);
////                           jsonCancelPendingTransaction(mList.get(position).getOrderID(),position);
////                       }
//                        if (R.id.btnCancelOrder!=button.getId()) {
//                           Intent intent=new Intent(getActivity(), PurchaseSummeryActivity.class);
//                           intent.putExtra("OrderId",mList.get(position).getOrderID());
//                           startActivity(intent);
//                       }
//
//                    }
//
//                    @Override
//                    public void onLongItemClick(View view, int position) {
//                        // do whatever
//                    }
//                })
//        );



        galleryViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                textView.setText(s);
            }
        });
        jsonPendingTransaction();
        return root;
    }

    public void jsonPendingTransaction() {

        prTransactions.setVisibility(View.VISIBLE);

        Call<pendingPurchaseModel> call = apiInterface.pendingPurchases(Constants.BASE_URL + "list_pending_purchase" + "&apikey=" + sessionManager.getApiKey());
        call.enqueue(new Callback<pendingPurchaseModel>() {
            @Override
            public void onResponse(Call<pendingPurchaseModel> call, Response<pendingPurchaseModel> response) {

                Log.d("pendingTransactions>>", "onResponse: " + response.body().toString());

                prTransactions.setVisibility(View.GONE);

                if (response.body().getResponse_code() == 0) {

                    try {
                        if (response.body().getData().getList() != null) {
                           mList.addAll(response.body().getData().getList());
                            adapter = new transactionPendingAdapter(getActivity(), response.body().getData().getList());
                            recyclerView.setAdapter(adapter);
                            adapter.notifyDataSetChanged();

                        }
                        tvTotalAmount.setText(response.body().getData().getTotals().getAmount());
                        tvTotalTransaction.setText(String.valueOf(response.body().getData().getTotals().getPurchases()));
                        tvTotalShares.setText(String.valueOf(response.body().getData().getTotals().getShares()));


                    } catch (Exception e) {

                    }


//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                } else {
                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<pendingPurchaseModel> call, Throwable t) {


            }
        });
    }

    public void jsonCancelPendingTransaction(String orderID, final int position) {

        prTransactions.setVisibility(View.VISIBLE);

        Call<pendingPurchaseModel> call = apiInterface.pendingPurchases(Constants.BASE_URL + "cancel_pending_purchase" + "&apikey=" + sessionManager.getApiKey() + "&order_id=" + orderID);
        call.enqueue(new Callback<pendingPurchaseModel>() {
            @Override
            public void onResponse(Call<pendingPurchaseModel> call, Response<pendingPurchaseModel> response) {

                Log.d("pendingTransactions>>", "onResponse: " + response.body().toString());

                prTransactions.setVisibility(View.GONE);

                if (response.body().getResponse_code() == 0) {

                    try {
//                        adapter.notifyDataSetChanged();
                        mList.remove(position);
                        recyclerView.removeViewAt(position);
                        adapter.notifyItemRemoved(position);
                        adapter.notifyItemRangeChanged(position, mList.size());
                        Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();


                    } catch (Exception e) {

                    }


//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                } else {
                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<pendingPurchaseModel> call, Throwable t) {


            }
        });
    }
}