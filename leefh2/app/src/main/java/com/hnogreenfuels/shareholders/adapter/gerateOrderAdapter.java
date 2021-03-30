package com.hnogreenfuels.shareholders.adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.recyclerview.widget.RecyclerView;

import com.hnogreenfuels.shareholders.Model.GenetareOrderModel;
import com.hnogreenfuels.shareholders.R;
import com.tokopedia.expandable.BaseExpandableOption;
import com.tokopedia.expandable.ExpandableOptionRadio;

import java.util.List;

public class gerateOrderAdapter extends RecyclerView.Adapter<gerateOrderAdapter.ViewHolder> {

    private List<GenetareOrderModel.Data.PaymentMethod> mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;
    private int lastSelected=-1;



    // data is passed into the constructor
    public gerateOrderAdapter(Context context, List<GenetareOrderModel.Data.PaymentMethod> data) {
        this.mInflater = LayoutInflater.from(context);
        this.mData = data;
    }

    // inflates the row layout from xml when needed
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.item_payment, parent, false);
        return new ViewHolder(view);
    }

    // binds the data to the TextView in each row
    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        GenetareOrderModel.Data.PaymentMethod animal = mData.get(position);
        try {
//            holder.paymentName.setText(animal.getName());
//            holder.paymentDetails.setText(animal.getArgs().getDetails());
//            holder.lin.setOnClickListener(new View.OnClickListener() {
//                @Override
//                public void onClick(View view) {
//
//                    if (lastSelected==position){
//
//                    }
//
//
//                    if (lastSelected!=position){
//
//                        holder.img.setImageResource(R.drawable.green_circle);
//                        lastSelected=position;
//                        Log.d("TAG", "onClick:lastSelected==position ");
//
//                        for (int i=0;i<mData.size();i++){
//                            if (lastSelected!=position){
//                                holder.img.setImageResource(R.drawable.black_circle);
//                            }else {
//                                holder.img.setImageResource(R.drawable.green_circle);
//                            }
//                        }
//                    }else {
//                        lastSelected=position;
//                        holder.img.setImageResource(R.drawable.green_circle);
//                        Log.d("TAG", "onClick:");
//                    }
//                }
//            });

           if (lastSelected!=position){
               Log.d("Selected", "onBindViewHolder: ");
           }else {
               Log.d("Selected", "onBindViewHolder: ");
           }

            holder.baseExpandableOptionObject.setExpand(true);
            holder.baseExpandableOptionObject.toggle();
            holder.baseExpandableOptionObject.isExpanded();


            holder.baseExpandableOptionObject.setTitleText(animal.getName());

            holder.baseExpandableOptionObject.setExpandableListener(new BaseExpandableOption.ExpandableListener() {
                @Override
                public void onExpandViewChange(boolean isExpand) {
                    //do something when expand/collapse
                }
            });

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
//        TextView paymentName, paymentDetails;
//        LinearLayout lin;
//        ImageView img;
ExpandableOptionRadio baseExpandableOptionObject;

        ViewHolder(View itemView) {
            super(itemView);
//            paymentName = itemView.findViewById(R.id.paymentName);
//            paymentDetails = itemView.findViewById(R.id.paymentDetails);
//            lin=itemView.findViewById(R.id.lin);
//            img=itemView.findViewById(R.id.img);

            baseExpandableOptionObject=itemView.findViewById(R.id.radio1);
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
