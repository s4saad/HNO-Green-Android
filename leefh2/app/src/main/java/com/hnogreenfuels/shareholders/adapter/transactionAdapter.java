package com.hnogreenfuels.shareholders.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.hnogreenfuels.shareholders.Model.TransactionsModel;
import com.hnogreenfuels.shareholders.R;

import java.util.List;

public class transactionAdapter extends RecyclerView.Adapter<transactionAdapter.ViewHolder> {

    private List<TransactionsModel.Data.list> mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;

    // data is passed into the constructor
    public transactionAdapter(Context context, List<TransactionsModel.Data.list> data) {
        this.mInflater = LayoutInflater.from(context);
        this.mData = data;
    }

    // inflates the row layout from xml when needed
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.item_transaction, parent, false);
        return new ViewHolder(view);
    }

    // binds the data to the TextView in each row
    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        TransactionsModel.Data.list animal = mData.get(position);
        try {
            holder.tvPurchaseDateV.setText(animal.getPurchaseDate());
            holder.tvAccountPerShareV.setText(animal.getSharePrice());
            holder.tvTotalSharesV.setText(String.valueOf(animal.getShares()));
            holder.tvTotalAmountV.setText(animal.getAmount());
            holder.tvDetailT.setText(animal.getNotes());
        } catch (Exception e) {

        }

    }

    // total number of rows
    @Override
    public int getItemCount() {
        return mData.size();
    }


    // stores and recycles views as they are scrolled off screen
    public class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView tvPurchaseDateS, tvPurchaseDateV,
                tvAccountPerShareS, tvAccountPerShareV,
                tvTotalSharesS, tvTotalSharesV,
                tvTotalAmountS, tvTotalAmountV,tvDetailT;


        ViewHolder(View itemView) {
            super(itemView);
            tvPurchaseDateS = itemView.findViewById(R.id.tvPurchaseDateS);
            tvPurchaseDateV = itemView.findViewById(R.id.tvPurchaseDateV);
            tvAccountPerShareS = itemView.findViewById(R.id.tvAccountPerShareS);
            tvAccountPerShareV = itemView.findViewById(R.id.tvAccountPerShareV);
            tvTotalSharesS = itemView.findViewById(R.id.tvTotalSharesS);
            tvTotalSharesV = itemView.findViewById(R.id.tvTotalSharesV);
            tvTotalAmountS = itemView.findViewById(R.id.tvTotalAmountS);
            tvTotalAmountV = itemView.findViewById(R.id.tvTotalAmountV);
            tvDetailT=itemView.findViewById(R.id.tvDetailT);

            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
            if (mClickListener != null) mClickListener.onItemClick(view, getAdapterPosition());
        }
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
