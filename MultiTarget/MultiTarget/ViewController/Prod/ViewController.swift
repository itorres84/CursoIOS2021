//
//  ViewController.swift
//  MultiTarget
//
//  Created by Isrrael Torres Alvarado on 16/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEV
        self.nameLabel.text = "Este es el ambiente de desarrollo"
        #elseif QA
        self.nameLabel.text = "Este es el ambiente de QA"
        #else
        self.nameLabel.text = "Este es el ambiente de produccion"
        #endif
        
    }

}

