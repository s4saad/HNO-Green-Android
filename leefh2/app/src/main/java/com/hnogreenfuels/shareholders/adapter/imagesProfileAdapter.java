package com.hnogreenfuels.shareholders.adapter;

import android.app.Dialog;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.recyclerview.widget.RecyclerView;

import com.hnogreenfuels.shareholders.Model.LoginModel;
import com.hnogreenfuels.shareholders.Model.ProfileModel;
import com.hnogreenfuels.shareholders.R;
import com.hnogreenfuels.shareholders.SignupActivity;
import com.hnogreenfuels.shareholders.ui.profile.ProfileFragment;
import com.squareup.picasso.Picasso;

import java.util.List;

public class imagesProfileAdapter extends RecyclerView.Adapter<imagesProfileAdapter.ViewHolder> {

    private List<LoginModel.Ppics_All> mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;
    private int lastSelected=-1;
    private Context context;
    private Dialog dialog;
    private ImageView profileImage;



    // data is passed into the constructor
    public imagesProfileAdapter(Context context, List<LoginModel.Ppics_All> data, Dialog dialog, ImageView imgProfile) {
        this.mInflater = LayoutInflater.from(context);
        this.mData = data;
        this.context=context;
        this.dialog=dialog;
        this.profileImage=imgProfile;
    }

    // inflates the row layout from xml when needed
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.item_image, parent, false);
        return new ViewHolder(view);
    }

    // binds the data to the TextView in each row
    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final LoginModel.Ppics_All animal = mData.get(position);
        try {

            Picasso.with(context).load(animal.getLink()).into(holder.imgItemList);

            holder.imgItemList.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    dialog.cancel();

                    Picasso.with(context).load(animal.getLink()).into(profileImage);


                    SignupActivity.selectedImageCode=animal.getCode();
                }
            });

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
        ImageView imgItemList;
//        LinearLayout lin;


        ViewHolder(View itemView) {
            super(itemView);
            imgItemList = itemView.findViewById(R.id.itemImage);
//            paymentDetails = itemView.findViewById(R.id.paymentDetails);
//            lin=itemView.findViewById(R.id.lin);
//            img=itemView.findViewById(R.id.img);


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
