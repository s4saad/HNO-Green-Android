package com.hnogreenfuels.shareholders.Model;

import java.util.List;

public class TransactionsModel {

    private int response_code;
    private String response_msg;
    private Data data;

    public class Data{
        private List<list> list;
        private Totals totals;

        public class Totals{
            private int transactions;
            private String amount;
            private int shares;

            public int getTransactions() {
                return transactions;
            }

            public void setTransactions(int transactions) {
                this.transactions = transactions;
            }

            public String getAmount() {
                return amount;
            }

            public void setAmount(String amount) {
                this.amount = amount;
            }

            public int getShares() {
                return shares;
            }

            public void setShares(int shares) {
                this.shares = shares;
            }
        }

        public class list {
            private String purchaseDate;
            private String sharePrice;
            private String amount;
            private String notes;
            private int shares;

            public String getPurchaseDate() {
                return purchaseDate;
            }

            public void setPurchaseDate(String purchaseDate) {
                this.purchaseDate = purchaseDate;
            }

            public String getSharePrice() {
                return sharePrice;
            }

            public void setSharePrice(String sharePrice) {
                this.sharePrice = sharePrice;
            }

            public String getAmount() {
                return amount;
            }

            public void setAmount(String amount) {
                this.amount = amount;
            }

            public String getNotes() {
                return notes;
            }

            public void setNotes(String notes) {
                this.notes = notes;
            }

            public int getShares() {
                return shares;
            }

            public void setShares(int shares) {
                this.shares = shares;
            }
        }

        public Totals getTotals() {
            return totals;
        }

        public void setTotals(Totals totals) {
            this.totals = totals;
        }

        public List<Data.list> getList() {
            return list;
        }

        public void setList(List<Data.list> list) {
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
