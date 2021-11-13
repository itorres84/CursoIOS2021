//
//  AddContactViewController.swift
//  TableViewExample
//
//  Created by Isrrael Torres Alvarado on 12/11/21.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveContact(_ sender: Any) {
        
        guard let name = txtName.text, !name.isEmpty,
        let lastName = txtLastName.text, !lastName.isEmpty,
        let phone = txtPhone.text, !phone.isEmpty else {
            
            showAlert(title: "Error", message: AddContactViewController.Constants.ErrorTextEmpty)
            
            return
        }
        
        let persistenceClient: ContactPersistenceClient = ContactPersistenceClientUserDefault()
        
        let saveSucces = persistenceClient.saveContact(contact: ContactPersistenceClientUserDefault.RequestModel(name: name, lastName: lastName, phone: phone))
        
        if saveSucces {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accionClose = UIAlertAction(title: "Cerrar", style: .default, handler: nil)
        alertController.addAction(accionClose)
        self.present(alertController, animated: true, completion: nil)
    
    }

}

extension AddContactViewController {
    
    enum Constants {
        static let ErrorTextEmpty = "Debes llenar todos los campos"
    }
    
}
