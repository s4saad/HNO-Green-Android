package com.hnogreenfuels.shareholders.Model;

import java.util.List;

public class pendingPurchaseModel {
    private int response_code;
    private String response_msg;
    private Data data;

    public class Data{
        private List<lists> list;
        private Totals totals;
        public class Totals{
            private int purchases;
            private String amount;
            private int shares;

            public int getPurchases() {
                return purchases;
            }

            public void setPurchases(int purchases) {
                this.purchases = purchases;
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

        public Totals getTotals() {
            return totals;
        }

        public void setTotals(Totals totals) {
            this.totals = totals;
        }

        public class lists{
            private String orderID;
            private String orderTrxRef;
            private String orderDate;
            private String sharePrice;
            private int shares;
            private String amount;
            private String paymentMethod;

            public String getOrderID() {
                return orderID;
            }

            public void setOrderID(String orderID) {
                this.orderID = orderID;
            }

            public String getOrderTrxRef() {
                return orderTrxRef;
            }

            public void setOrderTrxRef(String orderTrxRef) {
                this.orderTrxRef = orderTrxRef;
            }

            public String getOrderDate() {
                return orderDate;
            }

            public void setOrderDate(String orderDate) {
                this.orderDate = orderDate;
            }

            public String getSharePrice() {
                return sharePrice;
            }

            public void setSharePrice(String sharePrice) {
                this.sharePrice = sharePrice;
            }

            public int getShares() {
                return shares;
            }

            public void setShares(int shares) {
                this.shares = shares;
            }

            public String getAmount() {
                return amount;
            }

            public void setAmount(String amount) {
                this.amount = amount;
            }

            public String getPaymentMethod() {
                return paymentMethod;
            }

            public void setPaymentMethod(String paymentMethod) {
                this.paymentMethod = paymentMethod;
            }
        }

        public List<lists> getList() {
            return list;
        }

        public void setList(List<lists> list) {
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
