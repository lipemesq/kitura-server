//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 19/04/20.
//

import LoggerAPI
import KituraContracts

func initializeGetRoutes(app: App) {
    app.router.get("/hello") {
        request, response, next in
        response.headers["Content-Type"] = "text/txt"
        response.send("Hello Kitura")
        next()
    }
}

/*
 100 ~ 199: informação
 200 ~ 299: sucesso
 300 ~ 399: redirect
 400 ~ 499: erro
 500 ~ 599: erro servidor
*/
