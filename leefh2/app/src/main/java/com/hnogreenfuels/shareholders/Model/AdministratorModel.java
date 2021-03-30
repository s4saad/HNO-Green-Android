package com.hnogreenfuels.shareholders.Model;

import java.util.List;

public class AdministratorModel {

    private int response_code;
    private String response_msg;
    private Data data;

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }

    public class Data{
        private String trx_reference;
        private String order_date;
        private String order_id;
        private String shareholder_id;
        private String shareholder_name;
        private String shareholder_email;
        private String shares;
        private String share_price;
        private String total_amount;
        private String status;
        private String display_status;
        private String pay_method_slug;
        private String pay_method_name;
        private List<PaymentMethod> pay_method_available;
        private String notes;
        private boolean editable;
        private List<Buttons> buttons;

        public class PaymentMethod{
            private String slug;
            private String name;

            public String getSlug() {
                return slug;
            }

            public void setSlug(String slug) {
                this.slug = slug;
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }
        }
        public String getTrx_reference() {
            return trx_reference;
        }

        public void setTrx_reference(String trx_reference) {
            this.trx_reference = trx_reference;
        }

        public String getOrder_date() {
            return order_date;
        }

        public void setOrder_date(String order_date) {
            this.order_date = order_date;
        }

        public String getOrder_id() {
            return order_id;
        }

        public void setOrder_id(String order_id) {
            this.order_id = order_id;
        }

        public String getShareholder_id() {
            return shareholder_id;
        }

        public void setShareholder_id(String shareholder_id) {
            this.shareholder_id = shareholder_id;
        }

        public String getShareholder_name() {
            return shareholder_name;
        }

        public void setShareholder_name(String shareholder_name) {
            this.shareholder_name = shareholder_name;
        }

        public String getShareholder_email() {
            return shareholder_email;
        }

        public void setShareholder_email(String shareholder_email) {
            this.shareholder_email = shareholder_email;
        }

        public String getShares() {
            return shares;
        }

        public void setShares(String shares) {
            this.shares = shares;
        }

        public String getShare_price() {
            return share_price;
        }

        public void setShare_price(String share_price) {
            this.share_price = share_price;
        }

        public String getTotal_amount() {
            return total_amount;
        }

        public void setTotal_amount(String total_amount) {
            this.total_amount = total_amount;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getDisplay_status() {
            return display_status;
        }

        public void setDisplay_status(String display_status) {
            this.display_status = display_status;
        }

        public String getPay_method_slug() {
            return pay_method_slug;
        }

        public void setPay_method_slug(String pay_method_slug) {
            this.pay_method_slug = pay_method_slug;
        }

        public String getPay_method_name() {
            return pay_method_name;
        }

        public void setPay_method_name(String pay_method_name) {
            this.pay_method_name = pay_method_name;
        }

        public List<PaymentMethod> getPay_method_available() {
            return pay_method_available;
        }

        public void setPay_method_available(List<PaymentMethod> pay_method_available) {
            this.pay_method_available = pay_method_available;
        }

        public String getNotes() {
            return notes;
        }

        public void setNotes(String notes) {
            this.notes = notes;
        }

        public boolean isEditable() {
            return editable;
        }

        public void setEditable(boolean editable) {
            this.editable = editable;
        }

        public List<Buttons> getButtons() {
            return buttons;
        }

        public void setButtons(List<Buttons> buttons) {
            this.buttons = buttons;
        }

        public class Buttons{
            private String slug;
            private String name;
            private boolean show;

            public void setSlug(String slug) {
                this.slug = slug;
            }

            public void setName(String name) {
                this.name = name;
            }

            public void setShow(boolean show) {
                this.show = show;
            }

            public String getSlug() {
                return slug;
            }

            public String getName() {
                return name;
            }

            public boolean isShow() {
                return show;
            }
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
}
