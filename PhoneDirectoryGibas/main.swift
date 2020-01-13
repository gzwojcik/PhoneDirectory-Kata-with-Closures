//
//  main.swift
//  PhoneDirectoryGibas
//
//  Created by zgaga on 27-11-2019.
//  Copyright © 2019 Hime. All rights reserved.
//

import Foundation


extension String
{
    func phoneNumbers() -> [String]
    {
        if let regex = try? NSRegularExpression(pattern: "[0-9]+-[0-9]+-[0-9]+-[0-9]+", options: .caseInsensitive)
        {
            let string = self as NSString
            
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).lowercased()
            }
        }
        var result : String
        
        //return result = [].first! as! String
        return []
    }
}

extension String
{
    func phoneOwnerName() -> [String]
    {
        if let regex = try? NSRegularExpression(pattern: "(<[A-Za-z +]+>)+", options: .caseInsensitive)
        {
            let string = self as NSString
            
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            //            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
            //               string.substring(with: $0.range).replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "")
            //            }
        }
        
        return []
    }
}


extension String
{
    func phoneOwnerAddress() -> [String]
    {
        if let regex = try? NSRegularExpression(pattern: "[A-Za-z]", options: .caseInsensitive)
        {
            let string = self as NSString
            
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: String(string).self , with: "").replacingOccurrences(of: " +", with: "")
            }
        }
        
        return []
    }
}


// "Phone => 48-421-674-8974, Name => Anastasia, Address => Via Quirinal Roma"

//let text = "+48-421-674-8974 <Wilfrid Stevens> Quora Street AB-47209 +48-362-675-8974 <R Steell> Wild Street AA-67209"
//let text = "133, Green, Rd. <E Kustur> NY-56423 ;+1-541-914-3010!\n"
let text = "/+1-541-754-3010 156 Alphand_St. <J Steeve>\n 133, Green, Rd. <E Kustur> NY-56423 ;+1-541-914-3010!\n"
var splittedStr = text.split(separator: "\n");
var outputStr :String = ""

//numerytel = splittedStr.phoneNumbers()
var numerytel : String = ""
var numeryWlasciciel : String = ""
var adresWlasciciela : String = ""

for item in splittedStr {
    //    var temp = item
    //    var temp2 :String = ""
    let realStr = String(item)
    let num = realStr.phoneNumbers().count
    if (num == 0){
        print ("Error, not found \(realStr.phoneNumbers().first!)")
        break
    }
    if (realStr.phoneNumbers().count > 1) {
        print("Phone => Too many people: \(num)")
        break;
    }
    numerytel = realStr.phoneNumbers().first!
    print("Phone => \(numerytel)")
    numerytel = numerytel.replacingOccurrences(of: realStr.phoneNumbers().first!, with: "", options: [.caseInsensitive])
//     print("item------->",realStr.phoneNumbers().count)
    numeryWlasciciel = realStr.phoneOwnerName().first!
    print("Name => \(numeryWlasciciel)")
    numeryWlasciciel = numeryWlasciciel.replacingOccurrences(of: realStr.phoneOwnerName().first!, with: "", options: [.caseInsensitive, .regularExpression])
    
    adresWlasciciela = realStr
    adresWlasciciela = adresWlasciciela.replacingOccurrences(of: realStr.phoneNumbers().first!, with: "", options: [.caseInsensitive, .regularExpression])
    
    adresWlasciciela = adresWlasciciela.replacingOccurrences(of: realStr.phoneOwnerName().first!, with: "", options: [.caseInsensitive, .regularExpression])
    
    adresWlasciciela = adresWlasciciela.replacingOccurrences(of: "[\\+!;/\\' '{1}]+", with: "", options: [.caseInsensitive, .regularExpression])
    
    
//    adresWlasciciela = adresWlasciciela.replacingOccurrences(of: realStr.phoneOwnerName().first!, with: "", options: [.caseInsensitive, .regularExpression])
    //print("Address => \(adresWlasciciela)")
    
    //    temp2 = realStr.replacingOccurrences(of: "<[A-Za-z +]+>" , with: "")
    outputStr += "Phone => \(numerytel)" + "Name => \(numeryWlasciciel)" + "Address => \(adresWlasciciela)"
    //print(outputStr)
    //[0-9]{2}-[0-9]{3}-[0-9]{3}-[0-9]{4}+
    //.trimmingCharacters(in: .whitespacesAndNewlines)
    // adresWlasciciela = realStr.phoneOwnerAddress()
    // adresWlasciciela.append(temp2)
    print("Address => \(adresWlasciciela)")
}

//print("Phone => \(numerytel)")
//print("Name => \(numeryWlasciciel)")
//print("Address => \(adresWlasciciela)")
