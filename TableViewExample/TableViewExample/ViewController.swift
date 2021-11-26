//
//  ViewController.swift
//  TableViewExample
//
//  Created by Isrrael Torres Alvarado on 11/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let persistenceClient = ContactPersistenceClientUserDefault()
    
    //Data Source
    var arrayContacts: [AlphabetContactViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        if let navigationController = self.navigationController {
            
            let appearace = UINavigationBarAppearance()
            appearace.configureWithOpaqueBackground()
            appearace.backgroundColor = UIColor.systemBackground
            
            let navigationBar = navigationController.navigationBar
            navigationBar.standardAppearance = appearace
            navigationBar.scrollEdgeAppearance = appearace
            navigationBar.prefersLargeTitles = true
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.arrayContacts = prepareDataForTableView(contacts: persistenceClient.getContacts())
        contactsTableView.reloadData()
        
    }
    
    func prepareDataForTableView(contacts: [Contact]) -> [AlphabetContactViewModel] {
     
        var alphabetContacts: [AlphabetContactViewModel] = []
        
        let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
            
        for letter in alphabet {
            
            var contactsWhitLetter: [Contact] = []
            
            for contact in contacts {
             
                if let firstLetter = contact.lastName.first {
                    
                    if firstLetter.uppercased().elementsEqual(letter) {
                        contactsWhitLetter.append(contact)
                    }
                    
                }
        
            }
            
            if !contactsWhitLetter.isEmpty {
                
                let alphabetContact = AlphabetContactViewModel(letter: letter, contacts: contactsWhitLetter)
                
                alphabetContacts.append(alphabetContact)
                
            }
            
        }
        
        
        
        return alphabetContacts
        
    }
    
}

//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayContacts[section].letter
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contact = arrayContacts[indexPath.section].contacts[indexPath.row]
        print(contact)
        
        let alertController = UIAlertController(title: "\(contact.name) \(contact.lastName)", message: "Numero de telefono: \(contact.phone)", preferredStyle: .actionSheet)
        
        let accionCall = UIAlertAction(title: "Llamar", style: .default) { _ in
        
            print("se lanza llamada...")
            
            guard let url = URL(string: "tel://\(contact.phone)") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
        
        let alertCloseAction = UIAlertAction(title: "Cerrar", style: .cancel, handler: nil)
        
        alertController.addAction(accionCall)
        alertController.addAction(alertCloseAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
                
            let contact = arrayContacts[indexPath.section].contacts[indexPath.row]
            let alertController = UIAlertController(title: "Eliminar a \(contact.name)",
                                                    message: "¿Deseas eliminar al contacto?",
                                                    preferredStyle: .alert)
            
            let accionDelete = UIAlertAction(title: "Eliminar", style: .destructive) { _ in
                
                self.arrayContacts = self.prepareDataForTableView(contacts: self.persistenceClient.deleteContact(contact: contact))
                self.contactsTableView.reloadData()
                
            }
                   
            let alertCloseAction = UIAlertAction(title: "Cerrar", style: .cancel, handler: nil)
            
            alertController.addAction(accionDelete)
            alertController.addAction(alertCloseAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
}
//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayContacts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayContacts[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contactAlphabet = arrayContacts[indexPath.section]
        let contact = contactAlphabet.contacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        cell.contact.text = contact.name + " " + contact.lastName
        return cell
    
    }
    
}

//MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        arrayContacts = prepareDataForTableView(contacts: persistenceClient.getContacts())

        guard !searchText.isEmpty else {
            contactsTableView.reloadData()
            return
        }
            
        let contactsPersistence = persistenceClient.getContacts()
        
        let filterContacts = contactsPersistence.filter({  $0.lastName.lowercased().contains( searchText.lowercased()) })
        
        arrayContacts = prepareDataForTableView(contacts: filterContacts)
        contactsTableView.reloadData()
        
    }
    
    
}

