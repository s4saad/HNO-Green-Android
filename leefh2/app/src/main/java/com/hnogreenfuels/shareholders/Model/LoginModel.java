package com.hnogreenfuels.shareholders.Model;

import java.util.List;

public class LoginModel {
    private int response_code;
    private String response_msg;
    private Data data;
    private Updates updates;
    private String invite;

    public String getInvite() {
        return invite;
    }

    public void setInvite(String invite) {
        this.invite = invite;
    }

    private String acknowledge;
    private List<Ppics_All> ppics_all;
    public List<Ppics_All> getPpics_all() {
        return ppics_all;
    }

    public void setPpics_alls(List<Ppics_All> ppics_alls) {
        this.ppics_all = ppics_alls;
    }

    public class Ppics_All{
        private String code;
        private String link;


        public String getCode() {
            return code;
        }

        public void setCode(String code) {
            this.code = code;
        }

        public String getLink() {
            return link;
        }

        public void setLink(String link) {
            this.link = link;
        }
    }
    public String getAcknowledge() {
        return acknowledge;
    }

    public void setAcknowledge(String acknowledge) {
        this.acknowledge = acknowledge;
    }

    public class Updates{
        private boolean available;
        private boolean required;
        private String last_date;
        private String new_verson_name;
        private String new_verson_display_number;
        private String new_verson_code;

        public boolean isAvailable() {
            return available;
        }

        public void setAvailable(boolean available) {
            this.available = available;
        }

        public boolean isRequired() {
            return required;
        }

        public void setRequired(boolean required) {
            this.required = required;
        }

        public String getLast_date() {
            return last_date;
        }

        public void setLast_date(String last_date) {
            this.last_date = last_date;
        }

        public String getNew_verson_name() {
            return new_verson_name;
        }

        public void setNew_verson_name(String new_verson_name) {
            this.new_verson_name = new_verson_name;
        }

        public String getNew_verson_display_number() {
            return new_verson_display_number;
        }

        public void setNew_verson_display_number(String new_verson_display_number) {
            this.new_verson_display_number = new_verson_display_number;
        }

        public String getNew_verson_code() {
            return new_verson_code;
        }

        public void setNew_verson_code(String new_verson_code) {
            this.new_verson_code = new_verson_code;
        }
    }

    public Updates getUpdates() {
        return updates;
    }

    public void setUpdates(Updates updates) {
        this.updates = updates;
    }

    public class Data {
        private String user_id;
        private String api_key;
        private String apikey;
        private String display_name;
        private String user_type;
        private List<Options> options;
        private String email_msg;
        private String email_button;
        private String pincode;
        private String invite;

        public String getInvite() {
            return invite;
        }

        public void setInvite(String invite) {
            this.invite = invite;
        }

        public String getPincode() {
            return pincode;
        }

        public void setPincode(String pincode) {
            this.pincode = pincode;
        }

        public String getEmail_msg() {
            return email_msg;
        }

        public void setEmail_msg(String email_msg) {
            this.email_msg = email_msg;
        }

        public String getEmail_button() {
            return email_button;
        }

        public void setEmail_button(String email_button) {
            this.email_button = email_button;
        }

        public class Options{
            private String key;
            private String name;

            public String getKey() {
                return key;
            }

            public void setKey(String key) {
                this.key = key;
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }
        }

        public List<Options> getOptions() {
            return options;
        }

        public void setOptions(List<Options> options) {
            this.options = options;
        }

        public String getApikey() {
            return apikey;
        }

        public void setApikey(String apikey) {
            this.apikey = apikey;
        }

        public String getUser_id() {
            return user_id;
        }

        public void setUser_id(String user_id) {
            this.user_id = user_id;
        }

        public String getApi_key() {
            return api_key;
        }

        public void setApi_key(String api_key) {
            this.api_key = api_key;
        }

        public String getDisplay_name() {
            return display_name;
        }

        public void setDisplay_name(String display_name) {
            this.display_name = display_name;
        }

        public String getUser_type() {
            return user_type;
        }

        public void setUser_type(String user_type) {
            this.user_type = user_type;
        }
    }


    public LoginModel() {
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
