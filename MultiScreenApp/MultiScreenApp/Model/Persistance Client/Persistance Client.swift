//
//  Persistance Client.swift
//  MultiScreenApp
//
//  Created by Abdiel Molina on 09/11/21.
//

import Foundation

class PersistenceClient {
    
    func saveUserRegistrer(name: String, lastName: String, email: String, password: String) -> Bool {
        
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        
        return true
    }
    
    func login(email: String, password: String) -> String {
        
        if let persistenceEmail = UserDefaults.standard.string(forKey: "email"),
            let persistencePassword = UserDefaults.standard.string(forKey: "password"),
           let persistenceName = UserDefaults.standard.string(forKey: "password"),
           
            if email.elementsEqual(persistenceEmail) && password.elementsEqual(PersistencePassword) {
            
        }
    }
}
