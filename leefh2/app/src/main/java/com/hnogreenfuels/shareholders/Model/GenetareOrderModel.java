package com.hnogreenfuels.shareholders.Model;

import java.util.List;

public class GenetareOrderModel {
    private int response_code;
    private String response_msg;
    private Data data;


    public class Data {

        private List<PaymentMethod> payment_method;
        private int order_id;
        private int trx_reference;
        private String order_token;
        private double amount;
        private int shares;
        private String price;
        private String receiver;
        private String receiver_notes;
        private boolean someone;

        public void setAmount(double amount) {
            this.amount = amount;
        }

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

        public class PaymentMethod {
            private String id;
            private String name;
            private String slug;
            private Args args;
            private boolean selected;

            public boolean isSelected() {
                return selected;
            }

            public void setSelected(boolean selected) {
                this.selected = selected;
            }

            public class Args {
                private String mode;
                private String secret;
                private String client_id;
                private String fees;
                private String details;
                private String client_token;

                public String getClient_token() {
                    return client_token;
                }

                public void setClient_token(String client_token) {
                    this.client_token = client_token;
                }

                public String getMode() {
                    return mode;
                }

                public void setMode(String mode) {
                    this.mode = mode;
                }

                public String getSecret() {
                    return secret;
                }

                public void setSecret(String secret) {
                    this.secret = secret;
                }

                public String getClient_id() {
                    return client_id;
                }

                public void setClient_id(String client_id) {
                    this.client_id = client_id;
                }

                public String getFees() {
                    return fees;
                }

                public void setFees(String fees) {
                    this.fees = fees;
                }

                public String getDetails() {
                    return details;
                }

                public void setDetails(String details) {
                    this.details = details;
                }
            }

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

            public Args getArgs() {
                return args;
            }

            public void setArgs(Args args) {
                this.args = args;
            }
        }

        public int getOrder_id() {
            return order_id;
        }

        public void setOrder_id(int order_id) {
            this.order_id = order_id;
        }

        public int getTrx_reference() {
            return trx_reference;
        }

        public void setTrx_reference(int trx_reference) {
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

        public void setAmount(int amount) {
            this.amount = amount;
        }

        public int getShares() {
            return shares;
        }

        public void setShares(int shares) {
            this.shares = shares;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public List<PaymentMethod> getPayment_method() {
            return payment_method;
        }

        public void setPayment_method(List<PaymentMethod> payment_method) {
            this.payment_method = payment_method;
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
