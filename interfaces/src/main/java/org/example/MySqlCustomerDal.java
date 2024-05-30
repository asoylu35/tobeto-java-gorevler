package org.example;

public class MySqlCustomerDal implements CustomerDal,Repository{
    @Override
    public void Add() {
        System.out.println("My sql eklendi");
    }
}
