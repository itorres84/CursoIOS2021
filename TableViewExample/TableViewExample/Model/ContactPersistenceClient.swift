//
//  ContactPersistenceClient.swift
//  TableViewExample
//
//  Created by Isrrael Torres Alvarado on 12/11/21.
//

import Foundation

protocol ContactPersistenceClient {
    func saveContact(contact: ContactPersistenceClientUserDefault.RequestModel) -> Bool
}

class ContactPersistenceClientUserDefault: ContactPersistenceClient {
    
    struct RequestModel {
        let name: String
        let lastName: String
        let phone: String
    }
    
    let userDefault = UserDefaults.standard
    
    //MARK: ContactPersistenceClient
    func saveContact(contact: RequestModel) -> Bool {
            
        return true
    }
    
}

class ContactPersistenceClientCoreData: ContactPersistenceClient {
    

    func saveContact(contact: ContactPersistenceClientUserDefault.RequestModel) -> Bool {
        
        return false
    }
    
}
