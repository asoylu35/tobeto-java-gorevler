package org.example;

public class ProductManager {
    public static void add(Product product){

        if(ProductValidator.isValid(product)) {
            System.out.println("Eklendi");
        }else{
            System.out.println("Ürün bilgileri geçersizdir.");
        }
        ProductValidator productValidator= new ProductValidator();
        productValidator.bisey();
    }
}
