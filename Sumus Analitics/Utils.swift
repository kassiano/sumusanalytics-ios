//
//  Utils.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 04/05/17.
//  Copyright © 2017 MyBi. All rights reserved.
//

import UIKit


class Utils{
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        /*var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
         */
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        
        if (cString.hasPrefix("#")) {
            cString = String(cString.characters.dropFirst())
            //cString.substringFrom(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
