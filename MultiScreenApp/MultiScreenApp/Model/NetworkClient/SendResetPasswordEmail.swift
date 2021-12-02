//
//  SendResetPasswordEmail.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 01/12/21.
//

import Alamofire

struct ResetPasswordRequestModel: Encodable {
    let email: String
    let requestType: String = "PASSWORD_RESET"
}

struct ResetPasswordResponseModel: Decodable {
    let email: String
}

protocol SendResetPasswordEmail {
    func invoke(model: ResetPasswordRequestModel, complationHandler: @escaping (String?, Error?) -> Void)
}

class SendResetPasswordEmailImp {
    
    let host = "https://identitytoolkit.googleapis.com/v1/accounts:"
    let apiKey = "AIzaSyBfYA2fS9kwX8QQi6_2bmw7B6-l_IxrZKg"
    
}

extension SendResetPasswordEmailImp: SendResetPasswordEmail {
    
    func invoke(model: ResetPasswordRequestModel, complationHandler: @escaping (String?, Error?) -> Void) {
        
        AF.request("\(host)sendOobCode?key=\(apiKey)", method: .post, parameters: model).responseDecodable(of: ResetPasswordResponseModel.self) { response in
                
            switch response.result {
            case .failure(let error):
                complationHandler(nil, error)
            case .success(let response):
                complationHandler(response.email, nil)
            }
            
        }
        
    }
    
}
