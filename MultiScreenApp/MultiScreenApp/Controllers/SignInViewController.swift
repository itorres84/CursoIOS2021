//
//  SignInViewController.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 05/11/21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier, identifier.elementsEqual("goToHome") {
            
            if let tabbar = segue.destination as? UITabBarController,
               let homeViewController = tabbar.viewControllers?.first as? HomeViewController {
                
                if let name = sender as? String {
                    homeViewController.name = name
                }
                
            }
        }
        
    }
    
    @IBAction func login(_ sender: Any) {
        
        guard let strEmail = email.text, !strEmail.isEmpty,
              let strPassword = password.text, !strPassword.isEmpty else {
            return
        }
        
        let persistenceClient = PersistenceClient()
        
        let name = persistenceClient.login(email: strEmail, password: strPassword)
        
        if !name.isEmpty, !name.elementsEqual("Error") {
            performSegue(withIdentifier: "goToHome", sender: name)
        }
        
        
    }
    
}
