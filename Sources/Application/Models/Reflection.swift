//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 24/04/20.
//

import Foundation
import KituraContracts
import SwiftKueryORM

struct ReflectionParams : QueryParams {
    var id : Int?
}

struct Reflection : Model {
    var id    : Int?
    var text  : String
    var date  : Date
}
