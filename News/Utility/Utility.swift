//
//  Utility.swift
//  News
//
//  Created by Anjaneyulu Battula on 28/03/22.
//

import Foundation

extension Date {
    public var removeTimeStamp : Date? {
       guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
        return nil
       }
       return date
   }
}
