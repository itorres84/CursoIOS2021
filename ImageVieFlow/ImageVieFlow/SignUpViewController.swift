//
//  SignUpViewController.swift
//  ImageVieFlow
//
//  Created by Abdiel Molina on 02/11/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextFieldCustom!
    @IBOutlet weak var txtPhone: UITextFieldCustom!
    @IBOutlet weak var txtPassword: UITextFieldCustom!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.configure(type: .email)
    
        txtPhone.configure(type: .phoneNumber)
    
        txtPassword.configure(type: .password)
    }
    

}
