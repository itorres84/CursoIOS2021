//
//  ViewController.swift
//  FaceApp
//
//  Created by Isrrael Torres Alvarado on 08/12/21.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    lazy var btnFaceBook: FBLoginButton = {
        let button = FBLoginButton()
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        button.permissions = ["public_profile"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(btnFaceBook)
        
        NSLayoutConstraint.activate([
            btnFaceBook.heightAnchor.constraint(equalToConstant: 50),
            btnFaceBook.widthAnchor.constraint(equalToConstant: 200),
            btnFaceBook.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnFaceBook.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Sesion Ok", message: "Sesion iniciada correctamete", preferredStyle: .alert)
        let actionClose = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(actionClose)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }

    }
    
}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
     
     
        if let token = result?.token, !token.isExpired {
        
            self.showAlert()
        
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields" : "id,first_name,last_name,middle_name,name,name_format,picture,short_name"],
                                                     tokenString: token.tokenString,
                                                     version: nil,
                                                     httpMethod: .get)
            
            request.start { connection, response, error in
                
                if let result = response as? [String: Any] {
                        
                    dump(result)
                    
                    
                }
            
            }
        
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
}

