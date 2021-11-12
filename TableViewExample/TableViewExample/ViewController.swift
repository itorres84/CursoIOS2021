//
//  ViewController.swift
//  TableViewExample
//
//  Created by Isrrael Torres Alvarado on 11/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    
    //Data Source
    var arrayContacts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let name = arrayContacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        cell.contact.text = name
        return cell
    
    }
    
}

