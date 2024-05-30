package org.example;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
   public static void main(String[] args) {
//     BaseLogger []loggers=new BaseLogger[]{new FileLogger(),new EmailLogger(),new DatabaseLogger(),new ConsoleLogger()};
//
//     for(BaseLogger logger:loggers){
//         logger.Log("Log mesajı");
//     }

       CustomerManager customerManager= new CustomerManager(new FileLogger());
       customerManager.Add();
    }
}