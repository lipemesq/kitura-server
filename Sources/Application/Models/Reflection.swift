//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 24/04/20.
//

import Foundation
import KituraContracts
import SwiftKueryORM
import SwiftKuery

struct ReflectionParams : QueryParams {
    var id : Int?
}

struct ReflectionByDateParams : QueryParams {
    var from : String
    var to   : String?
}


struct Reflection : Model {
    var id    : Int?
    var text  : String
    var date  : String

    func getDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        return dateFormatter.date(from: date) ?? Date()
    }
}
