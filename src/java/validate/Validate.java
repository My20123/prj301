/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validate;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;
import java.util.regex.Pattern;

/**
 *
 * @author tra my
 */
public class Validate {
     public static boolean getYesNo(String msg)
    {
        String s = "";
        Scanner sc = new Scanner(System.in);
        boolean loop = true;
        do
        {
            System.out.print(msg);
            try
            {
                s = sc.next("[yn]");
                loop = false;
            }
            catch(Exception e)
            {
                System.out.println(e);
                sc.nextLine();
            }
        }while(loop);
        if(s.charAt(0) == 'y') return true;
        else return false;
    }
    
    public static String getString(String msg, boolean isEmpty)
    {
        String s = "";
        Scanner sc = new Scanner(System.in);
        boolean loop = true;
        do
        {
            System.out.print(msg);
            try
            {
                s = sc.nextLine();
                if(isEmpty)
                    loop = false;
                else if(!s.isEmpty())
                    loop = false;
            }
            catch(Exception e)
            {
                System.out.println(e);
                sc.nextLine();
            }
        }while(loop);
        System.out.println();
        return s.trim();
    }
    
    public static int getInt(String msg){
        int i = 0;
        Scanner sc = new Scanner(System.in);
        boolean loop = true;
        do
        {
            System.out.print(msg);
            try
            {
                i = Integer.parseInt(sc.nextLine());
                if(i<=0){
                    System.out.println("Invalid input!");
                    loop = true;
                } else loop = false;
            }
            catch(NumberFormatException e)
            {
                System.out.println("Need number format!");
                sc.nextLine();
            }
        }while(loop);
        System.out.println();
        return i;
    }
    
    public static Date getDate(String msg)
    {
        Date date = new Date();
        
        Scanner sc = new Scanner(System.in);
        boolean loop = true;
        do
        {
            System.out.print(msg);
            try
            {
                String sDate = sc.next();
                date=new SimpleDateFormat("dd/mm/yyyy").parse(sDate);  
                loop = false;
            }
            catch (Exception e) {
                // TODO Auto-generated catch block
                System.out.println(e);
           }
        }while(loop);
        return date;
        
    } 
    public static Date getTime(String msg)
    {
        Date date = new Date();
        
        Scanner sc = new Scanner(System.in);
        boolean loop = true;
        do
        {
            System.out.print(msg);
            try
            {
                String sDate = sc.next();
                date=new SimpleDateFormat("hh:mm:ss a").parse(sDate);  // 12-hour format with AM/PM
                loop = false;
            }
            catch (Exception e) {
                // TODO Auto-generated catch block
                System.out.println(e);
           }
        }while(loop);
        return date;
        
    } 
    
    public static String getPhone(String msg){
        String phone;
        Scanner sc = new Scanner(System.in);
        boolean loop = true;
        do{
            boolean isNumber=true;
            int count=0;
            System.out.println(msg);
            phone = sc.nextLine();
            if(phone == null){
                System.out.println("Invalid input!");
                continue;
            }
            for(char ch : phone.toCharArray()){
                if(!Character.isDigit(ch)){
                    isNumber = false;
                    break;
                }
                count++;
            }
            if(isNumber==true && count>=10){
                if(!phone.startsWith("03")&&!phone.startsWith("09")){
                    System.out.println("Invalid phone number!");
                }
                loop = false;
            }
            else
                System.out.println("Invalid phone number!");
        }while(loop);
        System.out.println();
        return phone;
    }
    
    public static String getEmail(String msg){
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\."+ 
                            "[a-zA-Z0-9_+&*-]+)*@" + 
                            "(?:[a-zA-Z0-9-]+\\.)+[a-z" + 
                            "A-Z]{2,7}$"; 
        Pattern pat = Pattern.compile(emailRegex);
        String email;
        Scanner sc = new Scanner(System.in);
        boolean loop = true;
        do{
            System.out.println(msg);
            email = sc.nextLine();
            if(email == null){
                System.out.println("Invalid input!");
                continue;
            }
            if(pat.matcher(email).matches())
                loop=false;
            else
                System.out.println("Invalid email!");
        } while(loop);
        System.out.println();
        return email;
    }
    }
