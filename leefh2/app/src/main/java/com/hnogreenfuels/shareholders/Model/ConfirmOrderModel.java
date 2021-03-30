package com.hnogreenfuels.shareholders.Model;

public class ConfirmOrderModel {
    private int response_code;
    private String response_msg;
    private Data data;

    public class Data{

        private Payment_Method payment_method;
        private String order_id;
        private String trx_reference;
        private String order_token;
        private double amount;
        private String shares;
        private double price;
        private String receiver;
        private String receiver_notes;
        private boolean someone;

        public String getReceiver() {
            return receiver;
        }

        public void setReceiver(String receiver) {
            this.receiver = receiver;
        }

        public String getReceiver_notes() {
            return receiver_notes;
        }

        public void setReceiver_notes(String receiver_notes) {
            this.receiver_notes = receiver_notes;
        }

        public boolean isSomeone() {
            return someone;
        }

        public void setSomeone(boolean someone) {
            this.someone = someone;
        }

        public class Payment_Method{

            private String id;
            private String name;
            private String slug;
            private ARGS args;

            public String getId() {
                return id;
            }

            public void setId(String id) {
                this.id = id;
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }

            public String getSlug() {
                return slug;
            }

            public void setSlug(String slug) {
                this.slug = slug;
            }

            public ARGS getArgs() {
                return args;
            }

            public void setArgs(ARGS args) {
                this.args = args;
            }

            public class ARGS{
                private String details;

                public String getDetails() {
                    return details;
                }

                public void setDetails(String details) {
                    this.details = details;
                }
            }
        }

        public Payment_Method getPayment_method() {
            return payment_method;
        }

        public void setPayment_method(Payment_Method payment_method) {
            this.payment_method = payment_method;
        }

        public String getOrder_id() {
            return order_id;
        }

        public void setOrder_id(String order_id) {
            this.order_id = order_id;
        }

        public String getTrx_reference() {
            return trx_reference;
        }

        public void setTrx_reference(String trx_reference) {
            this.trx_reference = trx_reference;
        }

        public String getOrder_token() {
            return order_token;
        }

        public void setOrder_token(String order_token) {
            this.order_token = order_token;
        }

        public double getAmount() {
            return amount;
        }

        public void setAmount(double amount) {
            this.amount = amount;
        }

        public String getShares() {
            return shares;
        }

        public void setShares(String shares) {
            this.shares = shares;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
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
