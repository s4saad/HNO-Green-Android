package com.hnogreenfuels.shareholders.Model;

import java.util.List;

public class ShareholderUpdates {

    private int response_code;
    private String response_msg;


    private Data data;

    public class Data{
       private List<ListData> list;
       private Totals totals;

       public class Totals{
           private double totalUpdates;
           private double listedUpdates;

           public double getTotalUpdates() {
               return totalUpdates;
           }

           public void setTotalUpdates(double totalUpdates) {
               this.totalUpdates = totalUpdates;
           }

           public double getListedUpdates() {
               return listedUpdates;
           }

           public void setListedUpdates(double listedUpdates) {
               this.listedUpdates = listedUpdates;
           }
       }

        public Totals getTotals() {
            return totals;
        }

        public void setTotals(Totals totals) {
            this.totals = totals;
        }

        public class ListData{
            private String id;
            private String filename;
            private String filelink;
            private String date;
            private String description;

            public String getId() {
                return id;
            }

            public void setId(String id) {
                this.id = id;
            }

            public String getFilename() {
                return filename;
            }

            public void setFilename(String filename) {
                this.filename = filename;
            }

            public String getFilelink() {
                return filelink;
            }

            public void setFilelink(String filelink) {
                this.filelink = filelink;
            }

            public String getDate() {
                return date;
            }

            public void setDate(String date) {
                this.date = date;
            }

            public String getDescription() {
                return description;
            }

            public void setDescription(String description) {
                this.description = description;
            }
        }

        public List<ListData> getList() {
            return list;
        }

        public void setList(List<ListData> list) {
            this.list = list;
        }
    }

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }

    public int getResponse_code() {
        return response_code;
    }

    public void setResponse_code(int response_code) {
        this.response_code = response_code;
    }

    public String getResponse_msg() {
        return response_msg;
    }

    public void setResponse_msg(String response_msg) {
        this.response_msg = response_msg;
    }
}
