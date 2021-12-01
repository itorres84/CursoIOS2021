//
//  NetworkClient.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 30/11/21.
//

import Alamofire

class NetworkClient {

    struct SignUpRequestModel: Encodable {
        let name: String
        let lastName: String
        let email: String
        let password: String
        let returnSecureToken: Bool
    }
    
    struct SignUpResponseModel: Decodable {
        let kind: String
        let idToken: String
        let email: String
        let refreshToken: String
        let expiresIn: String
        let localId: String
    }
    
    func signUp(model: NetworkClient.SignUpRequestModel, complationHandler: @escaping (NetworkClient.SignUpResponseModel?, Error?) -> Void) {
        
        let url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBfYA2fS9kwX8QQi6_2bmw7B6-l_IxrZKg"
        
        AF.request(url, method: HTTPMethod.post, parameters: model)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: NetworkClient.SignUpResponseModel.self) { response in

            switch response.result {
            case .success(let responseData):
                complationHandler(responseData, nil)
            case .failure(let error):
                dump(error)
                complationHandler(nil, error)
            }
        }
    
    }
    
}
