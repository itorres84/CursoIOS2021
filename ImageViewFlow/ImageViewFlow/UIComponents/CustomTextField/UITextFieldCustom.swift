//
//  UITextFieldCustom.swift
//  ImageViewFlow
//
//  Created by Isrrael Torres Alvarado on 01/11/21.
//

import UIKit

class UITextFieldCustom: UITextField {
        
    var type: TypeTextFiel?
        
    func configure(type: TypeTextFiel?) {
        
        self.type = type
        
        switch self.type {
        case .password:
            keyboardType = .default
            isSecureTextEntry = true
        case .email:
            keyboardType = .emailAddress
        case .phoneNumber:
            keyboardType = .numberPad
        case .none:
            break
        }
    }
    
}
