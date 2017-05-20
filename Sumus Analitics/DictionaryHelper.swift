//
//  DictionaryHelper.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 04/05/17.
//  Copyright © 2017 MyBi. All rights reserved.
//

import Foundation


class DictionaryHelper{


    static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
}
