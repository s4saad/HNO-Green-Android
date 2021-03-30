package com.hnogreenfuels.shareholders.adapter;

import android.app.DownloadManager;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.hnogreenfuels.shareholders.Model.ShareholderUpdates;
import com.hnogreenfuels.shareholders.R;

import java.util.List;
import java.util.Objects;

public class ShareholderUpdatesAdapter extends RecyclerView.Adapter<ShareholderUpdatesAdapter.ViewHolder> {

    private List<ShareholderUpdates.Data.ListData> mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;
    private Context context;

    // data is passed into the constructor
    public ShareholderUpdatesAdapter(Context context, List<ShareholderUpdates.Data.ListData> data) {
        this.mInflater = LayoutInflater.from(context);
        this.mData = data;
        this.context=context;
    }

    // inflates the row layout from xml when needed
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.item_file_download, parent, false);
        return new ViewHolder(view);
    }

    // binds the data to the TextView in each row
    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        final ShareholderUpdates.Data.ListData animal = mData.get(position);
        holder.date.setText(animal.getDate());
        holder.fileName.setText(animal.getFilename());
        holder.description.setText(animal.getDescription());
        holder.fileLinkS.setText(animal.getFilelink());

        holder.btnDownload.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                downloadFile(animal.getFilelink()) ;

                Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(animal.getFilelink()));
                context.startActivity(browserIntent);
            }
        });
    }
    public void downloadFile(String filelink) {
        String DownloadUrl = filelink;
        DownloadManager.Request request1 = new DownloadManager.Request(Uri.parse(DownloadUrl));
        request1.setDescription("File");   //appears the same in Notification bar while downloading
        request1.setTitle("File1.mp3");
        request1.setVisibleInDownloadsUi(false);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
            request1.allowScanningByMediaScanner();
            request1.setNotificationVisibility(DownloadManager.Request.VISIBILITY_HIDDEN);
        }
        request1.setDestinationInExternalFilesDir(context.getApplicationContext(), "/File", "Question1.mp3");

        DownloadManager manager1 = (DownloadManager) context.getSystemService(Context.DOWNLOAD_SERVICE);
        Objects.requireNonNull(manager1).enqueue(request1);
        if (DownloadManager.STATUS_SUCCESSFUL == 8) {
//            DownloadSuccess();
        }
    }
    // total number of rows
    @Override
    public int getItemCount() {
        return mData.size();
    }


    // stores and recycles views as they are scrolled off screen
    public class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        TextView date,fileName,description,fileLinkS;
        Button btnDownload;

        ViewHolder(View itemView) {
            super(itemView);
            date = itemView.findViewById(R.id.tvDateS);
            fileName=itemView.findViewById(R.id.fileNameS);
            description=itemView.findViewById(R.id.descriptionS);
            fileLinkS=itemView.findViewById(R.id.fileLinkS);
            btnDownload=itemView.findViewById(R.id.btnDownload);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
            if (mClickListener != null) mClickListener.onItemClick(view, getAdapterPosition());
        }
    }

    // convenience method for getting data at click position
//    String getItem(int id) {
//        return mData.get(id);
//    }

    // allows clicks events to be caught
//    void setClickListener(FragmentActivity itemClickListener) {
//        this.mClickListener = itemClickListener;
//    }

    // parent activity will implement this method to respond to click events
    public interface ItemClickListener {
        void onItemClick(View view, int position);
    }
}
