//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 21/04/20.
//

import Foundation
import SwiftKueryORM
import SwiftKueryPostgreSQL
import LoggerAPI

class Persistence {
    
    static func setUp(){
        let pool = PostgreSQLConnection.createPool(
            host: ProcessInfo.processInfo.environment["DBHOST"] ?? "localhost", port: 5432, options: [
                .databaseName("bd"),
                .userName(ProcessInfo.processInfo.environment["DBUSER"] ?? "patrick"),
                .password(ProcessInfo.processInfo.environment["DBPASSWORD"] ?? "nil")],
            poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50, timeout: 10000))
        Database.default = Database(pool)
        
        do {
            try NoteEntry.createTableSync()
            Log.info("\(NoteEntry.tableName) created")
        } catch let error {
            if let requestError = error as? RequestError, requestError.rawValue == RequestError.ormQueryError.rawValue {
                Log.info("\(NoteEntry.tableName) already created")
            } else {
                Log.error(String(describing: error))
            }
        }
    }
}
