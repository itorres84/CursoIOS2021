//
//  UITextFieldCustom.swift
//  ImageVieFlow
//
//  Created by Abdiel Molina on 02/11/21.
//

import UIKit

class UITextFieldCustom: UITextField {
    
    var type: TypeTextFiel?
    
    func configure(type: TypeTextFiel?) {
        
        self.type = type
        
        switch type{
        case.password:
            keyboardType = .default
            isSecureTextEntry = true
        case.email:
            keyboardType = .emailAddress
        case.phoneNumber:
            keyboardType = .numberPad
        case .none:
            break
        }
}
}
