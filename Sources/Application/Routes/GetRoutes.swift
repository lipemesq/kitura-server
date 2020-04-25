//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 19/04/20.
//

import Foundation
import LoggerAPI
import KituraContracts

func initializeGetRoutes(app: App) {
    app.router.get("/hello") {
        request, response, next in
        response.headers["Content-Type"] = "text/txt"
        response.send("Hello Kitura")
        next()
    }
    
    app.router.get("/diferenca") {
        request, response, next in
        
        if let dateString = request.queryParameters["date"] {
            
            if dateString.count != 8 {
                response.send("{\"error\": \"Campo [date] mal formatado. [date] deve ser no formato ddMMyyyy.\"}")
            }
            else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "ddMMyyyy"
                
                if let formated = dateFormatter.date(from: dateString) {
                    let days = daysBetween(start: Date(), end: formated)
                    response.send("{\"days\": \"\(days)\"}")
                }
                else {
                    response.send("{\"error\": \"Campo [date] mal formatado. [date] deve ser no formato ddMMyyyy.\"}")
                }
            }
        }
        else {
            response.send("{\"error\": \"Campo [date] não especificado.\"}")
        }
        
        
        
        next()
    }
}


func daysBetween(start: Date, end: Date) -> Int {
    return Calendar.current.dateComponents([.day], from: start, to: end).day!
}

/*
 100 ~ 199: informação
 200 ~ 299: sucesso
 300 ~ 399: redirect
 400 ~ 499: erro
 500 ~ 599: erro servidor
*/
