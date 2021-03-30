package com.hnogreenfuels.shareholders.adapter;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.recyclerview.widget.RecyclerView;

import com.hnogreenfuels.shareholders.APIServices.APIClient;
import com.hnogreenfuels.shareholders.APIServices.APIInterface;
import com.hnogreenfuels.shareholders.Common.Constants;
import com.hnogreenfuels.shareholders.Model.pendingPurchaseModel;
import com.hnogreenfuels.shareholders.PurchaseSummeryActivity;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.Session.SessionManager;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class transactionPendingAdapter extends RecyclerView.Adapter<transactionPendingAdapter.ViewHolder> {

    private List<pendingPurchaseModel.Data.lists> mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;
    private SessionManager sessionManager;
    private APIInterface apiInterface;
    private Context context;

    // data is passed into the constructor
    public transactionPendingAdapter(Context context, List<pendingPurchaseModel.Data.lists> data) {
        this.mInflater = LayoutInflater.from(context);
        this.mData = data;
        apiInterface = APIClient.getClient().create(APIInterface.class);
        sessionManager = new SessionManager(context);
        this.context=context;
    }

    // inflates the row layout from xml when needed
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.item_pending_transaction, parent, false);
        return new ViewHolder(view);
    }

    // binds the data to the TextView in each row
    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final pendingPurchaseModel.Data.lists animal = mData.get(position);
        try {
            holder.tvOrderDatePP.setText(animal.getOrderDate());
            holder.tvSharePricePP.setText(animal.getSharePrice());
            holder.tvTotalSharesPP.setText(String.valueOf(animal.getShares()));
            holder.tvTotalAmountPP.setText(animal.getAmount());
            holder.tvPaymentMethodPP.setText(animal.getPaymentMethod());

            holder.btncancelOrder.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {


                    AlertDialog.Builder builder = new AlertDialog.Builder(context);

                    builder.setTitle("Confirm");
                    builder.setMessage("Are you sure?");

                    builder.setPositiveButton("YES", new DialogInterface.OnClickListener() {

                        public void onClick(DialogInterface dialog, int which) {
                            // Do nothing but close the dialog
                            Log.d("TAG", "onClick: "+mData.get(position));
                            mData.remove(position);
                            notifyItemRemoved(position);
                            notifyItemRangeChanged(position, mData.size());
//                    holder.itemView.setVisibility(View.GONE);
                            jsonCancelPendingTransaction(animal.getOrderID(),position);
                            dialog.dismiss();

                        }
                    });

                    builder.setNegativeButton("NO", new DialogInterface.OnClickListener() {

                        @Override
                        public void onClick(DialogInterface dialog, int which) {

                            // Do nothing
                            dialog.dismiss();
                        }
                    });

                    AlertDialog alert = builder.create();
                    alert.show();

                }
            });

            holder.btnPayNow.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent=new Intent(context, PurchaseSummeryActivity.class);
                           intent.putExtra("OrderId",mData.get(position).getOrderID());
                           context.startActivity(intent);
                }
            });

        } catch (Exception e) {

        }

    }
    public void jsonCancelPendingTransaction(String orderID, final int position) {



        Call<pendingPurchaseModel> call = apiInterface.pendingPurchases(Constants.BASE_URL + "cancel_pending_purchase" + "&apikey=" + sessionManager.getApiKey() + "&order_id=" + orderID);
        call.enqueue(new Callback<pendingPurchaseModel>() {
            @Override
            public void onResponse(Call<pendingPurchaseModel> call, Response<pendingPurchaseModel> response) {

                Log.d("pendingTransactions>>", "onResponse: " + response.body().toString());



                if (response.body().getResponse_code() == 0) {

                    try {
//                        adapter.notifyDataSetChanged();

                        Toast.makeText(context, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();


                    } catch (Exception e) {

                    }


//                    Toast.makeText(getActivity(), response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                } else {
                    Toast.makeText(context, response.body().getResponse_msg(), Toast.LENGTH_SHORT).show();

                }

            }

            @Override
            public void onFailure(Call<pendingPurchaseModel> call, Throwable t) {


            }
        });
    }
    // total number of rows
    @Override
    public int getItemCount() {
        return mData.size();
    }


    // stores and recycles views as they are scrolled off screen
    public class ViewHolder extends RecyclerView.ViewHolder {
        TextView tvOrderDatePP, tvSharePricePP,
                tvTotalSharesPP, tvTotalAmountPP,
                tvPaymentMethodPP;
        Button btnPayNow,btncancelOrder;


        ViewHolder(View itemView) {
            super(itemView);
            tvOrderDatePP = itemView.findViewById(R.id.tvOrderDatePP);
            tvSharePricePP = itemView.findViewById(R.id.tvSharePricePP);
            tvTotalSharesPP = itemView.findViewById(R.id.tvTotalSharesPP);
            tvTotalAmountPP = itemView.findViewById(R.id.tvTotalAmountPP);
            tvPaymentMethodPP = itemView.findViewById(R.id.tvPaymentMethodPP);
            btnPayNow=itemView.findViewById(R.id.btnPaynow);
            btncancelOrder=itemView.findViewById(R.id.btnCancelOrder);
            btncancelOrder.setTag("cancel");

//            itemView.setOnClickListener(this);
        }

//        @Override
//        public void onClick(View view) {
//            if (mClickListener != null) mClickListener.onItemClick(view, getAdapterPosition());
//        }
    }


    // allows clicks events to be caught
//    void setClickListener(FragmentActivity itemClickListener) {
//        this.mClickListener = itemClickListener;
//    }

    // parent activity will implement this method to respond to click events
    public interface ItemClickListener {
        void onItemClick(View view, int position);
    }
}
