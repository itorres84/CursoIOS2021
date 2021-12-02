//
//  RecoveryPasswordViewController.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 05/11/21.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendEmail(_ sender: Any) {
    
        guard let email = txtEmail.text, !email.isEmpty else { return }
        
        let sendEmailClient: SendResetPasswordEmail = SendResetPasswordEmailImp()
        
        sendEmailClient.invoke(model: ResetPasswordRequestModel(email: email)) { result, error in
            
            if let existError = error {
                self.showAlert(message: existError.localizedDescription, title: "Error")
            } else if let existResult = result {
                self.showAlert(message: "Se envio un email al correo: \(existResult), revisa tu bandeja para completar el proceso", title: "")
            }
            
        }
        
    }
    
    func showAlert(message: String, title: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
