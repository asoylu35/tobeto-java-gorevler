package org.example;

public class OracleCustomerDal implements CustomerDal{
    @Override
    public void Add() {
        System.out.println("Oracle eklendi");
    }
}
