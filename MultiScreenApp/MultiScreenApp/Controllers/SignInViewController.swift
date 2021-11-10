//
//  SignInViewController.swift
//  MultiScreenApp
//
//  Created by Abdiel Molina on 05/11/21.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
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

    @IBAction func Login(_ sender: Any) {
        
        guard let strEmail = email.text, strEmail.!isEmpty,
              let strPassword = password.text, strPassword.!isEmpty else {
                  return
              }
        
        let persistenceClient = PersistenceClient ()
        let name = persistenceClient
    }
}
