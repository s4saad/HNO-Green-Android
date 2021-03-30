package com.hnogreenfuels.shareholders.Model;

import java.util.List;

public class ProfileModel {
    private int response_code;
    private String response_msg;
    private Data data;

    public class Data{
        private String shareholder_id,username,email,ssn,firstname,middlename,lastname,suffix,company,
                type,address,city,state,country,zipcode,home,cell;

        private Selected_Profile selected_profile;
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

        public Selected_Profile getSelected_profile() {
            return selected_profile;
        }

        public void setSelected_profile(Selected_Profile selected_profile) {
            this.selected_profile = selected_profile;
        }

        public class Selected_Profile{
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

        public String getShareholder_id() {
            return shareholder_id;
        }

        public void setShareholder_id(String shareholder_id) {
            this.shareholder_id = shareholder_id;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getSsn() {
            return ssn;
        }

        public void setSsn(String ssn) {
            this.ssn = ssn;
        }

        public String getFirstname() {
            return firstname;
        }

        public void setFirstname(String firstname) {
            this.firstname = firstname;
        }

        public String getMiddlename() {
            return middlename;
        }

        public void setMiddlename(String middlename) {
            this.middlename = middlename;
        }

        public String getLastname() {
            return lastname;
        }

        public void setLastname(String lastname) {
            this.lastname = lastname;
        }

        public String getSuffix() {
            return suffix;
        }

        public void setSuffix(String suffix) {
            this.suffix = suffix;
        }

        public String getCompany() {
            return company;
        }

        public void setCompany(String company) {
            this.company = company;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getCity() {
            return city;
        }

        public void setCity(String city) {
            this.city = city;
        }

        public String getState() {
            return state;
        }

        public void setState(String state) {
            this.state = state;
        }

        public String getCountry() {
            return country;
        }

        public void setCountry(String country) {
            this.country = country;
        }

        public String getZipcode() {
            return zipcode;
        }

        public void setZipcode(String zipcode) {
            this.zipcode = zipcode;
        }

        public String getHome() {
            return home;
        }

        public void setHome(String home) {
            this.home = home;
        }

        public String getCell() {
            return cell;
        }

        public void setCell(String cell) {
            this.cell = cell;
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
