//
//  SignUpViewController.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 05/11/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
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
    
    @IBAction func SignUpProcess(_ sender: Any) {

        guard let name = txtNombre.text, !name.isEmpty,
        let lastName = txtLastName.text, !lastName.isEmpty,
        let email = txtEmail.text, !email.isEmpty,
        let password = txtPassword.text, !password.isEmpty,
        let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty else {
            showAlert(message: "Debes llenar todos los campos", title: "Error")
            return
        }
        
        
    
    }
    
    
    func showAlert(message: String, title: String) {
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    

}
