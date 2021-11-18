//
//  HomeViewController.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 05/11/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblWelcome: UILabel!
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !name.isEmpty {
            lblWelcome.text = "Bienvenido \(name)"
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
