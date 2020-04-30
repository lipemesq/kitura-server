//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 24/04/20.
//

import Foundation
import LoggerAPI
import KituraContracts
import SwiftKueryORM
import SwiftKuery

func initializeReflectionRoutes(app: App) {
    app.router.post  ("/reflection", handler: addReflection)
    app.router.get   ("/reflection", handler: getReflections)
    app.router.get   ("/reflection", handler: getReflectionsByDate)
    app.router.delete("/reflection", handler: deleteReflection)
    app.router.put   ("/reflection", handler: modifyReflection)
    app.router.get   ("/reflection", handler: getOneReflection)
}


func addReflection(reflection: Reflection, completion: @escaping(Reflection?, RequestError?) -> Void) {
    let storedReflection = reflection
    print("GG-- \(storedReflection.date), \(storedReflection.getDate())")
    storedReflection.save(completion)
}

func getReflections(params: ReflectionParams?, completion: @escaping ([Reflection]?, RequestError?) -> Void) -> Void {
    Reflection.findAll(matching: params, completion)
}

func getReflectionsByDate(params: ReflectionByDateParams?, completion: @escaping ([Reflection]?, RequestError?) -> Void) -> Void {
    Reflection.findAll { (reflections, error) in
        var result : [Reflection] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        
        if let from = dateFormatter.date(from: params?.from ?? "") {
            if let toParams = params?.to, let to = dateFormatter.date(from: toParams ) {
                reflections?.forEach({ (r) in
                    if r.getDate() > from && r.getDate() < to {
                        result.append(r)
                    }
                })
            }
            else {
                reflections?.forEach({ (r) in
                    if r.getDate() > from {
                        result.append(r)
                    }
                })
            }
            completion(result, nil)
        }
        else {
            completion(reflections, nil)
        }
        
        
        
        
    }
}


func deleteReflection(id: String, completion: @escaping (RequestError?) -> Void) {
    Reflection.delete(id: id, completion)
}

func modifyReflection(id: String, reflection: Reflection, completion: @escaping(Reflection?, RequestError?) -> Void) {
    reflection.update(id: id, completion)
}

func getOneReflection(id: Int, completion: @escaping(Reflection?, RequestError?) -> Void) {
    Reflection.find(id: id, completion)
}
