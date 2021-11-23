//
//  SplashViewController.swift
//  TableViewExample
//
//  Created by Isrrael Torres Alvarado on 19/11/21.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.0) {
            self.performSegue(withIdentifier: "goToContacts", sender: nil)
        }
        
    }

}
