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
    
    //Data Source
    var arrayContacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        configureSearchBar()
        
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
        
        let persistenceClient = ContactPersistenceClientUserDefault()
        arrayContacts = persistenceClient.getContacts()
        contactsTableView.reloadData()
        
    }
    
    func configureSearchBar() {
                
        
        
    }
    
}

//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
}
//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("Seccion: \(indexPath.section), Fila: \(indexPath.row)")
        
        let contact = arrayContacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        cell.contact.text = contact.name
        return cell
    
    }
    
}
//MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
        
    }
    
    
}

