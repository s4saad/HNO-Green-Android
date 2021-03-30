package com.hnogreenfuels.shareholders.Model;

public class SummeryModel {

    private int response_code;
    private String response_msg;
    private Data data;

    public class Data{
        private String shares;
        private String sharePrice;
        private String amount;
        private String orderTrxRef;
        private String orderID;
        private String orderDate;
        private String paymentMethod;
        private String paymentDetails;

        public String getShares() {
            return shares;
        }

        public void setShares(String shares) {
            this.shares = shares;
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

        public String getOrderTrxRef() {
            return orderTrxRef;
        }

        public void setOrderTrxRef(String orderTrxRef) {
            this.orderTrxRef = orderTrxRef;
        }

        public String getOrderID() {
            return orderID;
        }

        public void setOrderID(String orderID) {
            this.orderID = orderID;
        }

        public String getOrderDate() {
            return orderDate;
        }

        public void setOrderDate(String orderDate) {
            this.orderDate = orderDate;
        }

        public String getPaymentMethod() {
            return paymentMethod;
        }

        public void setPaymentMethod(String paymentMethod) {
            this.paymentMethod = paymentMethod;
        }

        public String getPaymentDetails() {
            return paymentDetails;
        }

        public void setPaymentDetails(String paymentDetails) {
            this.paymentDetails = paymentDetails;
        }
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

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }
}
