package com.hnogreenfuels.shareholders.Model;

import java.util.List;

public class VoucherModel {
    private List<data> data;

    public static class data{
        private int id,restaurant_id,discount;
        private String name,start_date,end_data;
        private restaurant restautant;

        public static class restaurant {
            private String name;

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }
        }

        public restaurant getRestautant() {
            return restautant;
        }

        public void setRestautant(restaurant restautant) {
            this.restautant = restautant;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getStart_date() {
            return start_date;
        }

        public void setStart_date(String start_date) {
            this.start_date = start_date;
        }

        public String getEnd_data() {
            return end_data;
        }

        public void setEnd_data(String end_data) {
            this.end_data = end_data;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getRestaurant_id() {
            return restaurant_id;
        }

        public void setRestaurant_id(int restaurant_id) {
            this.restaurant_id = restaurant_id;
        }

        public int getDiscount() {
            return discount;
        }

        public void setDiscount(int discount) {
            this.discount = discount;
        }
    }
    public List<data> getData() {
        return data;
    }

    public void setData(List<data> data) {
        this.data = data;
    }
}
