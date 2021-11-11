//
//  PersistenceClient.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 09/11/21.
//

import Foundation

class PersistenceClient {
    
    func saveUserRegister(name: String, lastName: String, email: String, password: String) -> Bool {
        
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(lastName, forKey: "lastname")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        return true
        
    }
    
    func login(email: String, password: String) -> String {
        
        if let persistenceEmail = UserDefaults.standard.string(forKey: "email"),
           let persistencePassword = UserDefaults.standard.string(forKey: "password"),
           let persistenceName = UserDefaults.standard.string(forKey: "name") {
            
            if email.elementsEqual(persistenceEmail) && password.elementsEqual(persistencePassword) {
                
                return persistenceName
                
            } else {
                return "Error"
            }
        
        } else {
            return "Error"
        }
    
    }
    
    
    func onboardingViewed(viewwed: Bool) {
        UserDefaults.standard.set(viewwed, forKey: "onboardingViewed")
    }
    
    func isOnboardingViewed() -> Bool {
        return UserDefaults.standard.bool(forKey: "onboardingViewed")
    }
    
}

