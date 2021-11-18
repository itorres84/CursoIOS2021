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
    let keyContactToSave = "contactsHistoryArray"

    //MARK: ContactPersistenceClient
    func saveContact(contact: RequestModel) -> Bool {
        
        var contacts = getContacts()
        contacts.append(Contact(name: contact.name,
                                lastName: contact.lastName,
                                phone: contact.phone))
        
        do {
            
            let contactData = try JSONEncoder().encode(contacts)
            userDefault.set(contactData, forKey: keyContactToSave)
            
            return true
            
        } catch {
            
            print(error.localizedDescription)
            return false
            
        }
        
    }
    
    func getContacts() -> [Contact] {
        
        guard let data = userDefault.data(forKey: keyContactToSave),
              let contacts = try? JSONDecoder().decode([Contact].self, from: data)  else { return [] }
        
        return contacts
        
    }
    
}

class ContactPersistenceClientCoreData: ContactPersistenceClient {
    

    func saveContact(contact: ContactPersistenceClientUserDefault.RequestModel) -> Bool {
        
        return false
    }
    
}
