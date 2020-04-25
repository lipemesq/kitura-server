//
//  File.swift
//  
//
//  Created by Felipe Mesquita on 21/04/20.
//

import Foundation
import SwiftKueryORM
import CredentialsHTTP

public struct UserAuth : Model{
    public var id : String
    public let password : String
}

extension UserAuth : TypeSafeHTTPBasic {
    public static func verifyPassword(username: String, password: String, callback: @escaping (UserAuth?) -> Void) {
        UserAuth.find(id: username) { (userAuth, error) in
            if let user = userAuth {
                if password == user.password {
                    callback(userAuth)
                    return
                }
            }
            callback(nil)
        }
    }
}
