//
//  currencyClass.swift
//  moneyCounterTrial
//
//  Created by V PUGAZHENTHI on 25/08/20.
//  Copyright © 2020 V PUGAZHENTHI. All rights reserved.
//

import Foundation
import UIKit

let egpDollarImage = #imageLiteral(resourceName: "EGP-dollar")
let egpFlagImage = #imageLiteral(resourceName: "EGP")

let jmdDollarImage = #imageLiteral(resourceName: "JMD-dollar")
let jmdFlagImage = #imageLiteral(resourceName: "JMD")

let ronDollarImage = #imageLiteral(resourceName: "RON-dollar")
let ronFlagImage = #imageLiteral(resourceName: "RON")

let inrDollarImage = #imageLiteral(resourceName: "INR-dollar")
let inrFlagImage = #imageLiteral(resourceName: "INR")

let twdDollarImage = #imageLiteral(resourceName: "TWD-dollar")
let twdFlagImage = #imageLiteral(resourceName: "TWD")

let bynDollarImage = #imageLiteral(resourceName: "RUB-dollar")
let bynFlagImage = #imageLiteral(resourceName: "BYN")

let hufDollarImage = #imageLiteral(resourceName: "HUF-dollar")
let hufFlagImage = #imageLiteral(resourceName: "HUF")

let czkDollarImage = #imageLiteral(resourceName: "CZK-dollar")
let czkFlagImage = #imageLiteral(resourceName: "CZK")

let ilsDollarImage = #imageLiteral(resourceName: "ILS-dollar")
let ilsFlagImage = #imageLiteral(resourceName: "ILS")

let usdDollarImage = #imageLiteral(resourceName: "USD-dollar")
let usdFlagImage = #imageLiteral(resourceName: "USD")

let eurDollarImage = #imageLiteral(resourceName: "EUR-dollar")
let eurFlagImage = #imageLiteral(resourceName: "EUR")

let ausDollarImage = #imageLiteral(resourceName: "AUD-dollar")
let ausFlagImage = #imageLiteral(resourceName: "AUD")

let sgdDollarImage = #imageLiteral(resourceName: "USD-dollar")
let sgdFlagImage = #imageLiteral(resourceName: "SGD")

let myrDollarImage = #imageLiteral(resourceName: "MYR-dollar")
let myrFlagImage = #imageLiteral(resourceName: "MYR")

let hkdDollarImage = #imageLiteral(resourceName: "HKD-dollar")
let hkdFlagImage = #imageLiteral(resourceName: "HKD")

let sekDollarImage = #imageLiteral(resourceName: "NOK-dollar")
let sekFlagImage = #imageLiteral(resourceName: "SEK")

let chfDollarImage = #imageLiteral(resourceName: "CHF-dollar")
let chfFlagImage = #imageLiteral(resourceName: "CHF")

let cadDollarImage = #imageLiteral(resourceName: "USD-dollar")
let cadFlagImage = #imageLiteral(resourceName: "CAD")

let gbpDollarImage = #imageLiteral(resourceName: "GBP-dollar")
let gbpFlagImage = #imageLiteral(resourceName: "GBP")

 
let nzdDollarImage = #imageLiteral(resourceName: "USD-dollar")
let nzdFlagImage = #imageLiteral(resourceName: "NZD")

let nokDollarImage = #imageLiteral(resourceName: "NOK-dollar")
let nokFlagImage = #imageLiteral(resourceName: "NOK")

let arsDollarImage = #imageLiteral(resourceName: "USD-dollar")
let arsFlagImage = #imageLiteral(resourceName: "ARS")

let cnyDollarImage = #imageLiteral(resourceName: "CNY-dollar")
let cnyFlagImage = #imageLiteral(resourceName: "CNY")

let zarDollarImage = #imageLiteral(resourceName: "ZAR-dollar")
let zarFlagImage = #imageLiteral(resourceName: "ZAR")

let mxnDollarImage = #imageLiteral(resourceName: "USD-dollar")
let mxnFlagImage = #imageLiteral(resourceName: "MXN")

let rubDollarImage = #imageLiteral(resourceName: "RUB-dollar")
let rubFlagImage = #imageLiteral(resourceName: "RUB")

let dopDollarImage = #imageLiteral(resourceName: "DOP-dollar")
let dopFlagImage = #imageLiteral(resourceName: "DOP")

let mvrDollarImage = #imageLiteral(resourceName: "MVR-dollar")
let mvrFlagImage = #imageLiteral(resourceName: "MVR")

let jpyDollarImage = #imageLiteral(resourceName: "CNY-dollar")
let jpyFlagImage = #imageLiteral(resourceName: "JPY")

let kwdDollarImage = #imageLiteral(resourceName: "KWD-dollar")
let kwdFlagImage = #imageLiteral(resourceName: "KWD")

let sarDollarImage = #imageLiteral(resourceName: "KWD-dollar")
let sarFlagImage = #imageLiteral(resourceName: "KWD")

let krwDollarImage = #imageLiteral(resourceName: "KRW-dollar")
let krwFlagImage = #imageLiteral(resourceName: "KRW")

let murDollarImage = #imageLiteral(resourceName: "MUR-dollar")
let murFlagImage = #imageLiteral(resourceName: "MUR")

let cupDollarImage = #imageLiteral(resourceName: "PHP-dollar")
let cupFlagImage = #imageLiteral(resourceName: "CUC")

let plnDollarImage = #imageLiteral(resourceName: "PLN-dollar-1")
let plnFlagImage = #imageLiteral(resourceName: "PLN")

let penDollarImage = #imageLiteral(resourceName: "PEN-dollar")
let penFlagImage = #imageLiteral(resourceName: "PEN")

let phpDollarImage = #imageLiteral(resourceName: "PHP-dollar")
let phpFlagImage = #imageLiteral(resourceName: "PHP")

let clpDollarImage = #imageLiteral(resourceName: "MXN-dollar")
let clpFlagImage = #imageLiteral(resourceName: "CLP")

let brlDollarImage = #imageLiteral(resourceName: "BRl-dollar")
let brlFlagImage = #imageLiteral(resourceName: "BRL")

let tryDollarImage = #imageLiteral(resourceName: "TRY-dollar")
let tryFlagImage = #imageLiteral(resourceName: "TRY")

let uyuDollarImage = #imageLiteral(resourceName: "UYU-dollar")
let uyuFlagImage = #imageLiteral(resourceName: "UYU")

let thbDollarImage = #imageLiteral(resourceName: "THB-dollar")
let thbFlagImage = #imageLiteral(resourceName: "THB")

let copDollarImage = #imageLiteral(resourceName: "USD-dollar")
let copFlagImage = #imageLiteral(resourceName: "COP")
struct GLOBAL {
    var inrCurrency : [String] = [ ]
    var inr:NSArray = []
    var inrDollar:NSArray = []
    var inrCent:NSArray = []
    var inrSymbol:NSArray = []
    var inrImageArray:[UIImage] = []
    var inrCurrencyName = " "
}

class CurrencyModel: NSObject {
    struct TWD {
        var inrCurrency : [String] = ["NT$2000","NT$1000","NT$500","NT$200","NT$100","NT$50","NT$20","NT$10","NT$5", "NT$1"]
        var inr = [2000,1000,500,200,100,50,20,10,5,1]
        var inrDollar = [2000,1000,500,200,100,50,20,10,5,1]
        var inrCent = [0.0]
        var inrSymbol = ["NT$","角"]
        var inrImageArray :[UIImage] = [twdFlagImage,twdDollarImage]
        var inrCurrencyName = "Taiwan New Dollar"
        
    }
    struct BYN {
        var inrCurrency : [String] = ["Br100000","Br50000","Br20000","Br10000","Br5000","Br1000","Br500","Br100","Br50", "Br20","Br10","Br5","Br1"]
        var inr = [100000,50000,20000,10000,5000,1000,500,100,50,20,10,5,1]
        var inrDollar = [100000,50000,20000,10000,5000,1000,500,100,50,20,10,5,1]
        var inrCent = [0.0]
        var inrSymbol = ["Br","Kapeyka"]
        var inrImageArray :[UIImage] = [bynFlagImage,bynDollarImage]
        var inrCurrencyName = "Belarusian Ruble"
        
    }
    
    struct HUF {
        var inrCurrency : [String] = ["Ft20000","Ft10000","Ft5000","Ft5000","Ft2000","Ft1000","Ft500","Ft200","Ft100", "Ft50","Ft20","Ft10","Ft5"]
        var inr = [20000,10000,5000,5000,2000,1000,500,200,100,50,20,10,5]
        var inrDollar = [20000,10000,5000,5000,2000,1000,500,200,100,50,20,10,5]
        var inrCent = [0.0]
        var inrSymbol = ["Ft","fillér"]
        var inrImageArray :[UIImage] = [hufFlagImage,hufDollarImage]
        var inrCurrencyName = "Hungarian Forint"
        
    }
    
    struct CZK {
        var inrCurrency : [String] = ["5000Kč","2000Kč","1000Kč","500Kč","200Kč","100Kč","50Kč","20Kč","10Kč", "5Kč","2Kč","1Kč"]
        var inr = [5000,2000,1000,500,200,100,50,20,10,5,2,1]
        var inrDollar = [5000,2000,1000,500,200,100,50,20,10,5,2,1]
        var inrCent = [0.0]
        var inrSymbol = ["Kč","h"]
        var inrImageArray :[UIImage] = [czkFlagImage,czkDollarImage]
        var inrCurrencyName = "Czech Koruna"
        
    }

    struct INR {
        var inrCurrency : [String] = ["₹2000","₹500","₹200","₹100","₹50","₹20","₹10","₹5","₹2","₹1","p50","p25",]
        var inr = [2000,500,200,100,50,20,10,5,2,1,0.50,0.25]
        var inrDollar = [2000,500,200,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.25]
        var inrSymbol = ["₹","p"]
        var inrImageArray :[UIImage] = [inrFlagImage,inrDollarImage]
        var inrCurrencyName = "Indian Rupee"
    }
      struct JMD {
          var inrCurrency : [String] = ["J$5000","J$1000","J$500","J$100","J$50","J$20","J$10","J$5","J$1","25c","10c","1c"]
          var inr = [5000,1000,500,100,50,20,10,5,1,0.25,0.10,0.01]
          var inrDollar = [5000,1000,500,100,50,20,10,5,1]
          var inrCent = [0.25,0.10,0.01]
          var inrSymbol = ["J$","c"]
          var inrImageArray :[UIImage] = [jmdFlagImage,jmdDollarImage]
          var inrCurrencyName = "Jamaican Dollar"
      }
    
    
      
      struct EGP {
          var inrCurrency : [String] = ["£200","£100","£50","£20","£10","£5","£1","Pt50","Pt25","Pt20","Pt10","Pt5","Pt1"]
          var inr = [200,100,50,20,10,5,1,0.50,0.25,0.20,0.10,0.05,0.01]
          var inrDollar = [200,100,50,20,10,5,1]
          var inrCent = [0.50,0.25,0.20,0.10,0.05,0.01]
          var inrSymbol = ["£","Pt"]
          var inrImageArray :[UIImage] = [egpFlagImage,egpDollarImage]
          var inrCurrencyName = "Egyptian Pound"
      }
     
    
    struct ILS {
        var inrCurrency : [String] = [" ₪200"," ₪100"," ₪50"," ₪20"," ₪10"," ₪5"," ₪2"," ₪1","agora50","agora10",]
        var inr = [200,100,50,20,10,5,2,1,0.50,0.10]
        var inrDollar = [200,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.10]
        var inrSymbol = ["₪","agora"]
        var inrImageArray :[UIImage] = [ilsFlagImage,ilsDollarImage]
        var inrCurrencyName = "Israeli Shekel"
    }
    struct USD {
        var inrCurrency : [String] = ["$100","$50","$20","$10","$5","$2","$1","50¢","25¢","10¢","5¢","1¢"]
        var inr = [100,50,20,10,5,2,1,0.50,0.25,0.10,0.05,0.01]
        var inrDollar = [100,50,20,10,5,2,1]
        var inrCent = [0.50,0.25,0.10,0.05,0.01]
        var inrSymbol = ["$","c"]
        var inrImageArray :[UIImage] = [usdFlagImage,usdDollarImage]
        var inrCurrencyName = "US Dollar"
    }
    struct EUR {
        var inrCurrency : [String] = ["€500","€200","€100","€50","€20","€10","€5","€2","€1","50¢","20¢","10¢","5¢","2¢","1¢"]
        var inr = [500,200,100,50,20,10,5,2,1,0.50,0.20,0.10,0.05,0.02,0.01]
        var inrDollar = [500,200,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10,0.05,0.02,0.01]
        var inrSymbol = ["€","¢"]
        var inrImageArray :[UIImage] = [eurFlagImage,eurDollarImage]
        var inrCurrencyName = "Euro"
    }
    struct RON {
        var inrCurrency : [String] = ["lei500","lei200","lei100","lei50","lei10","lei5","lei1","Bani50","Bani10","Bani5","Bani1"]
        var inr = [500,200,100,50,10,5,1,0.50,0.10,0.05,0.01]
        var inrDollar = [500,200,100,50,10,5,1]
        var inrCent = [0.50,0.10,0.05,0.01]
        var inrSymbol = ["lei","Bani"]
        var inrImageArray :[UIImage] = [ronFlagImage,ronDollarImage]
        var inrCurrencyName = "Romanian Leu"
    }
    struct AUD {
        var inrCurrency : [String] = ["$100","$50","$20","$10","$5","$2","$1","50c","20c","10c","5c"]
        var inr = [100,50,20,10,5,2,1,0.50,0.20,0.10,0.05]
        var inrDollar = [100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10,0.05]
        var inrSymbol = ["$","c"]
        var inrImageArray :[UIImage] = [ausFlagImage,ausDollarImage]
        var inrCurrencyName = "Australian Dollar"
    }
    struct SGD {
        var inrCurrency : [String] = ["$10000","$1000","$500","$100","$50","$25","$20","$10","$5","$2","$1","50¢","20¢","10¢","5¢","1¢"]
        var inr = [10000,1000,500,100,50,25,20,10,5,2,1,0.50,0.2,0.10,0.05,0.01]
        var inrDollar = [10000,1000,500,100,50,25,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10,0.05,0.01]
        var inrSymbol = ["$","¢"]
        var inrImageArray :[UIImage] = [sgdFlagImage,sgdDollarImage]
        var inrCurrencyName = "Singapore Dollar"
    }
    struct MYR {
        var inrCurrency : [String] = ["RM100","RM50","RM20","RM10","RM5","RM1","50c","20c","10c","5c"]
        var inr = [100,50,20,10,5,1,0.50,0.20,0.10,0.05]
        var inrDollar = [100,50,20,10,5,1]
        var inrCent = [0.50,0.20,0.10,0.05]
        var inrSymbol = ["RM","c"]
        var inrImageArray :[UIImage] = [myrFlagImage,myrDollarImage]
        var inrCurrencyName = "Malaysian Ringit"
    }
    struct HKD {
        var inrCurrency : [String] = ["$1000","$500","$150","$100","$50","$20","$10","$5","$2","$1","50¢","20¢","10¢"]
        var inr = [1000,500,150,100,50,20,10,5,2,1,0.50,0.20,0.10]
        var inrDollar = [1000,500,150,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10]
        var inrSymbol = ["$","¢"]
        var inrImageArray :[UIImage] = [hkdFlagImage,hkdDollarImage]
        var inrCurrencyName = "Hong Kong Dollar"
    }
    struct SEK {
        var inrCurrency : [String] = ["kr1000","kr500","kr100","kr50","kr20","kr10","kr5","kr1"]
        var inr = [1000,500,100,50,20,10,5,1.0]
        var inrDollar = [1000,500,100,50,20,10,5,1]
        var inrCent = [0.0]
        var inrSymbol = ["kr","c"]
        var inrImageArray :[UIImage] = [sekFlagImage,sekDollarImage]
        var inrCurrencyName = "Swedish Krona"
    }
    struct CHF {
        var inrCurrency : [String] = ["CHF1000","CHF200","CHF100","CHF50","CHF20","CHF10","CHF5","CHF2","CHF1","50Rp","20Rp","10Rp","5Rp"]
        var inr = [1000,200,100,50,20,10,5,2,1,0.50,0.20,0.10,0.05]
        var inrDollar = [1000,200,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10,0.05]
        var inrSymbol = ["CHF","Rp"]
        var inrImageArray :[UIImage] = [chfFlagImage,chfDollarImage]
        var inrCurrencyName = "Swiss Franc"
    }
    struct CAD {
        var inrCurrency : [String] = ["$1000","$500","$100","$50","$20","$10","$5","$2","$1","50¢","25¢","10¢","5¢","1¢"]
        var inr = [1000,500,100,50,20,10,5,2,1,0.50,0.25,0.10,0.05,0.01]
        var inrDollar = [1000,500,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.25,0.10,0.05,0.01]
        var inrSymbol = ["$","¢"]
        var inrImageArray :[UIImage] = [cadFlagImage,cadDollarImage]
        var inrCurrencyName = "Canadian Dollar"
    }
    struct GBP {
        var inrCurrency : [String] = ["£100","£50","£20","£10","£5","£2","£1","50p","20p","10p","5p","2p","1p"]
        var inr = [100,50,20,10,5,2,1,0.50,0.20,0.10,0.05,0.02,0.01]
        var inrDollar = [100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10,0.05,0.02,0.01]
        var inrSymbol = ["£","p"]
        var inrImageArray :[UIImage] = [gbpFlagImage,gbpDollarImage]
        var inrCurrencyName = "British Pound"
    }
 
    struct NZD {
        var inrCurrency : [String] = ["$100","$50","$20","$10","$5","$2","$1","50c","20c","10c"]
        var inr = [100,50,20,10,5,2,1,0.50,0.20,0.10]
        var inrDollar = [100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10]
        var inrSymbol = ["$","c"]
        var inrImageArray :[UIImage] = [nzdFlagImage,nzdDollarImage]
        var inrCurrencyName = "New Zealand Dollar"
    }
    struct NOK {
        var inrCurrency : [String] = ["kr1000","kr500","kr200","kr100","kr50","kr20","kr10","kr5","kr1"]
        var inr = [1000,500,200,100,50,20,10,5,1.0]
        var inrDollar = [1000,500,200,100,50,20,10,5,1]
        var inrCent = [0.0]
        var inrSymbol = ["kr","c"]
        var inrImageArray :[UIImage] = [nokFlagImage,nokDollarImage]
        var inrCurrencyName = "Norwegian Krone"
    }
    struct ARS {
        var inrCurrency : [String] = ["Rs1000","Rs500","Rs200","Rs100","Rs50","Rs20","Rs10","Rs5","Rs2","Rs1"]
        var inr = [1000,500,200,100,50,20,10,5,2,1.0]
        var inrDollar = [1000,500,200,100,50,20,10,5,2,1]
        var inrCent = [0.0]
        var inrSymbol = ["Rs","c"]
        var inrImageArray :[UIImage] = [arsFlagImage,arsDollarImage]
        var inrCurrencyName = "Argentine Pesos"
    }
    struct CNY {
        var inrCurrency : [String] = ["¥100","¥50","¥20","¥10","¥5","¥2","¥1","5角","2角","1角"]
        var inr = [100,50,20,10,5,2,1,0.5,0.2,0.1]
        var inrDollar = [100,50,20,10,5,2,1]
        var inrCent = [0.5,0.2,0.1]
        var inrSymbol = ["¥","角"]
        var inrImageArray :[UIImage] = [cnyFlagImage,cnyDollarImage]
        var inrCurrencyName = "Chinese Yuan Renminbi"
    }
    struct ZAR {
        var inrCurrency : [String] = ["R200","R100","R50","R20","R10","R5","R2","R1","50c","20c","10c","5c"]
        var inr = [200,100,50,20,10,5,2,1,0.5,0.2,0.1,0.05]
        var inrDollar = [200,100,50,20,10,5,2,1]
        var inrCent = [0.5,0.2,0.1,0.05]
        var inrSymbol = ["R","c"]
        var inrImageArray :[UIImage] = [zarFlagImage,zarDollarImage]
        var inrCurrencyName = "South African Rand"
    }
    struct MXN {
        var inrCurrency : [String] = ["$1000","$500","$200","$100","$50","$20","$10","$5","$2","$1","c50","c20","c10","c5"]
        var inr = [1000,500,200,100,50,20,10,5,2,1,0.50,0.20,0.10,0.05]
        var inrDollar = [1000,500,200,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10,0.05]
        var inrSymbol = ["$","c"]
        var inrImageArray :[UIImage] = [mxnFlagImage,mxnDollarImage]
        var inrCurrencyName = "Mexican Peso"
    }
    struct RUB {
        var inrCurrency : [String] = ["₽5000","₽2000","₽1000","₽500","₽200","₽100","₽50","₽10","₽5","₽2","₽1","k.50","k.10","k.5","k.1"]
        var inr = [5000,2000,1000,500,200,100,50,10,5,2,1,0.50,0.10,0.05,0.01]
        var inrDollar = [5000,2000,1000,500,200,100,50,10,5,2,1]
        var inrCent = [0.50,0.10,0.05,0.01]
        var inrSymbol = ["₽","k."]
        var inrImageArray :[UIImage] = [rubFlagImage,rubDollarImage]
        var inrCurrencyName = "Russian Ruble"
    }
    struct DOP {
        var inrCurrency : [String] = ["RD$2000","RD$1000","RD$500","RD$200","RD$100","RD$50","RD$25","RD$20","RD$10","RD$5","RD$1"]
        var inr = [2000,1000,500,200,100,50,25,20,10,5,1]
        var inrDollar = [2000,1000,500,200,100,50,25,20,10,5,1]
        var inrCent = [0.0]
        var inrSymbol = ["RD$","k"]
        var inrImageArray :[UIImage] = [dopFlagImage,dopDollarImage]
        var inrCurrencyName = "Dominican peso"
    }
    struct MVR {
        var inrCurrency : [String] = ["Rf5000","Rf1000","Rf500","Rf100","Rf50","Rf20","Rf10","Rf5","Rf2","Rf1","Laari 50","Laari 25","Laari 10","Laari 5","Laari 2","Laari 1"]
        var inr = [5000,1000,500,100,50,20,10,5,2,1,0.50,0.25,0.10,0.05,0.02,0.01]
        var inrDollar = [5000,1000,500,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.25,0.10,0.05,0.02,0.01]
        var inrSymbol = ["Rf","Laari"]
        var inrImageArray :[UIImage] = [mvrFlagImage,mvrDollarImage]
        var inrCurrencyName = "Maldivian Rufiyaa"
    }
    struct JPY {
        var inrCurrency : [String] = ["¥10000","¥5000","¥2000","¥1000","¥500","¥100","¥50","¥10","¥5","¥1"]
        var inr = [10000,5000,2000,1000,500,100,50,10,5,1]
        var inrDollar = [10000,5000,2000,1000,500,100,50,10,5,1]
        var inrCent = [0.0]
        var inrSymbol = ["¥","c"]
        var inrImageArray :[UIImage] = [jpyFlagImage,jpyDollarImage]
        var inrCurrencyName = "Japanese Yen"
    }
    struct KRW {
        var inrCurrency : [String] = ["₩50000","₩10000","₩5000","₩1000","₩500","₩100","₩50","₩10","₩5","₩1"]
        var inr = [50000,10000,5000,1000,500,100,50,10,5,1]
        var inrDollar = [50000,10000,5000,1000,500,100,50,10,5,1]
        var inrCent = [0.0]
        var inrSymbol = ["₩","c"]
        var inrImageArray :[UIImage] = [krwFlagImage,krwDollarImage]
        var inrCurrencyName = "South Korean Won"
    }
      
     
    struct KWD {
        var inrCurrency : [String] = ["20","10","5","1","1/2","1/4","100 fils","50 fils","20 fils","10 fils","5 fils","1 fils"]
        var inr = [20,10,5,1,0.5,0.25,0.1,0.05,0.02,0.01,0.005,0.001]
        var inrDollar = [20,10,5,1,0.5,0.25]
        var inrCent = [0.1,0.05,0.02,0.01,0.005,0.001]
        var inrSymbol = ["د.ك","fils"]
        var inrImageArray :[UIImage] = [kwdFlagImage,kwdDollarImage]
        var inrCurrencyName = "Kuwaiti Dinar"
    }
      //J$50, J$100, J$500, J$1000, J$5000 1c, 10c, 25c, J$1, J$5, J$10, J$20
    struct SAR {
        var inrCurrency : [String] = ["500","200","100","50","20","10","5","1","50 هللة‎","25 هللة‎","10 هللة‎","5 هللة‎","1 هللة‎"]
        var inr = [500,200,100,50,20,10,5,1,0.5,0.25,0.10,0.05,0.01]
        var inrDollar = [500,200,100,50,20,10,5,1]
        var inrCent = [0.5,0.25,0.10,0.05,0.01]
        var inrSymbol = ["هللة,﷼"]
        var inrImageArray :[UIImage] = [sarFlagImage,sarDollarImage]
        var inrCurrencyName = "SAudi Riyal"
    }
    struct MUR {
        var inrCurrency : [String] = ["₨2000","₨1000","₨500","₨200","₨100","₨50","₨25","₨20","₨10","₨5","₨2","₨1"]
        var inr = [2000,1000,500,200,100,50,25,20,10,5,2,1.0]
        var inrDollar = [2000,1000,500,200,100,50,25,20,10,5,2,1]
        var inrCent = [0.0]
        var inrSymbol = ["₨","c"]
        var inrImageArray :[UIImage] = [murFlagImage,murDollarImage]
        var inrCurrencyName = "Mauritian Rupee"
    }
    struct CUP {
        var inrCurrency : [String] = ["₱1000","₱500","₱200","₱100","₱50","₱20","₱10","₱5","₱3","₱1","¢20","¢5","¢2","¢1"]
        var inr = [1000,500,200,100,50,20,10,5,3,1,0.20,0.05,0.02,0.01]
        var inrDollar = [1000,500,200,100,50,20,10,5,3,1]
        var inrCent = [0.20,0.05,0.02,0.01]
        var inrSymbol = ["₱","¢"]
        var inrImageArray :[UIImage] = [cupFlagImage,cupDollarImage]
        var inrCurrencyName = "Cuban Peso"
    }
    struct PLN {
        var inrCurrency : [String] = ["zł500","zł200","zł100","zł50","zł20","zł10","zł5","zł2","zł1","50gr","20gr","10gr","5gr","2gr","1gr"]
        var inr = [500,200,100,50,20,10,5,2,1,0.50,0.20,0.10,0.05,0.02,0.01]
        var inrDollar = [500,200,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10,0.05,0.02,0.01]
        var inrSymbol = ["zł","gr"]
        var inrImageArray :[UIImage] = [plnFlagImage,plnDollarImage]
        var inrCurrencyName = "Polish Zloty"
    }
    struct PEN {
        var inrCurrency : [String] = ["S/.200","S/.100","S/.50","S/.20","S/.10","S/.5","S/.2","S/.1","50","20","10","5","1"]
        var inr = [200,100,50,20,10,5,2,1,0.50,0.20,0.10,0.05,0.01]
        var inrDollar = [200,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.20,0.10,0.05,0.01]
        var inrSymbol = ["S/.","¢"]
        var inrImageArray :[UIImage] = [penFlagImage,penDollarImage]
        var inrCurrencyName = "Peruvian Sol"
    }
    struct PHP {
        var inrCurrency : [String] = ["₱1000","₱500","₱200","₱100","₱50","₱20","₱10","₱5","₱1","25¢","10¢","5¢","2¢","1¢"]
        var inr = [1000,500,200,100,50,20,10,5,1,0.25,0.10,0.05,0.02,0.01]
        var inrDollar = [1000,500,200,100,50,20,10,5,1]
        var inrCent = [0.25,0.10,0.05,0.02,0.01]
        var inrSymbol = ["₱","¢"]
        var inrImageArray :[UIImage] = [phpFlagImage,phpDollarImage]
        var inrCurrencyName = "Philippine Peso"
    }
    struct CLP {
        var inrCurrency : [String] = ["$20000","$10000","$5000","$2000","$1000","$500","$100","$50","$10","$5","$1"]
        var inr = [20000,10000,5000,2000,1000,500,100,50,10,5,1]
        var inrDollar = [20000,10000,5000,2000,1000,500,100,50,10,5,1]
        var inrCent = [0.0]
        var inrSymbol = ["$","c"]
        var inrImageArray :[UIImage] = [clpFlagImage,clpDollarImage]
        var inrCurrencyName = "Chilean Peso"
    }
    struct BRL {
        var inrCurrency : [String] = ["R$200","R$100","R$50","R$20","R$10","R$5","R$2","R$1","50c","25c","10c","5c","1c"]
        var inr = [200,100,50,20,10,5,2,1,0.50,0.25,0.10,0.05,0.01]
        var inrDollar = [200,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.25,0.10,0.05,0.01]
        var inrSymbol = ["R$","c"]
        var inrImageArray :[UIImage] = [brlFlagImage,brlDollarImage]
        var inrCurrencyName = "Brazilian Real"
    }
    struct TRY {
        var inrCurrency : [String] = ["₺200","₺100","₺50","₺20","₺10","₺5","₺1","50kr","25kr","10kr","5kr"]
        var inr = [200,100,50,20,10,5,1,0.50,0.25,0.10,0.05]
        var inrDollar = [200,100,50,20,10,5,1]
        var inrCent = [0.50,0.25,0.10,0.05]
        var inrSymbol = ["₺","kr"]
        var inrImageArray :[UIImage] = [tryFlagImage,tryDollarImage]
        var inrCurrencyName = "Turkish Lira"
    }
    struct UYU {
        var inrCurrency : [String] = ["$U2000","$U1000","$U500","$U200","$U100","$U50","$U20","$U10","$U5","$U2","$U1"]
        var inr = [2000,1000,500,200,100,50,20,10,5,2,1,]
        var inrDollar = [2000,1000,500,200,100,50,20,10,5,2,1]
        var inrCent = [0.0]
        var inrSymbol = ["$U","¢"]
        var inrImageArray :[UIImage] = [uyuFlagImage,uyuDollarImage]
        var inrCurrencyName = "Uruguayan Peso"
    }
    struct THB {
        var inrCurrency : [String] = ["฿1000","฿500","฿100","฿50","฿20","฿10","฿5","฿2","฿1","50 satang","25 satang"]
        var inr = [1000,500,100,50,20,10,5,2,1,0.50,0.25]
        var inrDollar = [1000,500,100,50,20,10,5,2,1]
        var inrCent = [0.50,0.25]
        var inrSymbol = ["฿","s"]
        var inrImageArray :[UIImage] = [thbFlagImage,thbDollarImage]
        var inrCurrencyName = "Thai Baht"
    }
    struct COP {
        var inrCurrency : [String] = ["$100000","$50000","$20000","$10000","$5000","$2000","$1000","$500","$200","$100","$50","$20","$10","$5"]
        var inr = [100000,50000,20000,10000,5000,2000,1000,500,200,100,50,20,10,5]
        var inrDollar = [100000,50000,20000,10000,5000,2000,1000,500,200,100,50,20,10,5]
        var inrCent = [0.0]
        var inrSymbol = ["$","c"]
        var inrImageArray :[UIImage] = [copFlagImage,copDollarImage]
        var inrCurrencyName = " Colombian Peso"
    }
    var egpStruct = EGP()
    var jmdStruct = JMD()
    var twdStruct = TWD()
    var bynStruct = BYN()
    var hufStruct = HUF()
    var czkStruct = CZK()
    var inrStruct = INR()
    var ilsStruct = ILS()
    var usdStruct = USD()
    var eurStruct = EUR()
    var audStruct = AUD()
    var sgdStruct = SGD()
    var myrStruct = MYR()
    var hkdStruct = HKD()
    var ronStruct = RON()
    var sekStruct = SEK()
    var chfStruct = CHF()
    var cadStruct = CAD()
    var gbpStruct = GBP()
    
    var nzdStruct = NZD()
    var nokStruct = NOK()
    var arsStruct = ARS()
    var cnyStruct = CNY()
    var zarStruct = ZAR()
    var mxnStruct = MXN()
    var rubStruct = RUB()
    var dopStruct = DOP()
    var mvrStruct = MVR()
    var jpyStruct = JPY()
    var krwStruct = KRW()
    var kwdStruct = KWD()
    var sarStruct = SAR()
    var murStruct = MUR()
    var cupStruct = CUP()
    var plnStruct = PLN()
    var penStruct = PEN()
    var phpStruct = PHP()
    var clpStruct = CLP()
    var brlStruct = BRL()
    var tryStruct = TRY()
    var uyuStruct = UYU()
    var thbStruct = THB()
    var copStruct = COP()
    
    let formatter = NumberFormatter()

}
