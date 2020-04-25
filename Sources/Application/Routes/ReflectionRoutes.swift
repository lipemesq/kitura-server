//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 24/04/20.
//

import Foundation
import LoggerAPI
import KituraContracts

var refa : [Reflection] = []

func initializeReflectionRoutes(app: App) {
    app.router.post  ("/reflection", handler: addReflection)
    app.router.get   ("/reflection", handler: getReflections)
    app.router.delete("/reflection", handler: deleteReflection)
    app.router.put   ("/reflection", handler: modifyReflection)
    app.router.get   ("/reflection", handler: getOneReflection)

}

func addReflection(reflection: Reflection, completion: @escaping(Reflection?, RequestError?) -> Void) {
    let storedReflection = reflection
    //storedReflection.id = UUID().uuidString
    storedReflection.save(completion)
}

func getReflections(params: ReflectionParams?, completion: @escaping ([Reflection]?, RequestError?) -> Void) -> Void {
    Reflection.findAll(matching: params, completion)
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
