package com.hnogreenfuels.shareholders;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import com.tokopedia.expandable.BaseExpandableOption;
import com.tokopedia.expandable.ExpandableOptionRadio;

public class DemoExpandleListActivity extends AppCompatActivity {

    ExpandableOptionRadio baseExpandableOptionObject;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_demo_expandle_list);

        baseExpandableOptionObject=findViewById(R.id.radio1);


        baseExpandableOptionObject.setExpand(true);
        baseExpandableOptionObject.toggle();
        baseExpandableOptionObject.isExpanded();

        baseExpandableOptionObject.setTitleText("expandable radio");

//set listener of expandable view when collapse or expand
        baseExpandableOptionObject.setExpandableListener(new BaseExpandableOption.ExpandableListener() {
            @Override
            public void onExpandViewChange(boolean isExpand) {
                //do something when expand/collapse
            }
        });
    }
}