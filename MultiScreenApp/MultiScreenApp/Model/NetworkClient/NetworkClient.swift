//
//  NetworkClient.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 30/11/21.
//

import Alamofire

class NetworkClient {

    let host = "https://identitytoolkit.googleapis.com/v1/accounts:"
    let apiKey = "AIzaSyBfYA2fS9kwX8QQi6_2bmw7B6-l_IxrZKg"
    
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
    
    func signUp(model: NetworkClient.SignUpRequestModel, complationHandler: @escaping (NetworkClient.UpdateProfileResponseModel?, Error?) -> Void) {
        
        let url = "\(host)signUp?key=\(apiKey)"
        
        AF.request(url, method: HTTPMethod.post, parameters: model)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: NetworkClient.SignUpResponseModel.self) { response in

            switch response.result {
            case .success(let responseData):
                
                self.update(model: UpdateProfileRequestModel(idToken: responseData.idToken,
                                                             displayName: "\(model.name) \(model.lastName)",
                                                             photoUrl: "",
                                                             returnSecureToken: true)) { response, error in
                    
                    if let existError = error {
                        complationHandler(nil, existError)
                    } else if let existReponse = response {
                        complationHandler(existReponse, nil)
                    }
                    
                }
                
            case .failure(let error):
                dump(error)
                complationHandler(nil, error)
            }
        }
    
    }
    
    struct UpdateProfileRequestModel: Encodable {
        let idToken: String
        let displayName: String
        let photoUrl: String
        let returnSecureToken: Bool
    }
    
    struct UpdateProfileResponseModel: Decodable {
        let displayName: String
    }
    
    private func update(model: UpdateProfileRequestModel, complationHandler: @escaping (UpdateProfileResponseModel?, Error?) -> Void) {
        
        let url = "\(host)update?key=\(apiKey)"
        
        AF.request(url, method: HTTPMethod.post, parameters: model)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: UpdateProfileResponseModel.self) { response in
                
                switch response.result {
                case .success(let responseData):
                    complationHandler(responseData, nil)
                case .failure(let error):
                    dump(error)
                    complationHandler(nil, error)
                }
            }
        
    }
    
    struct SignInRequestModel: Encodable {
        let email: String
        let password: String
        let returnSecureToken: Bool
    }
    
    struct SignInResponseModel: Decodable {
        let kind: String
        let idToken: String
        let email: String
        let refreshToken: String
        let expiresIn: String
        let localId: String
        let displayName: String
        let registered: Bool
    }
    
    func login(model: NetworkClient.SignInRequestModel, complationHandler: @escaping (NetworkClient.SignInResponseModel?, Error?) -> Void) {
        
        let url = "\(host)signInWithPassword?key=\(apiKey)"
        
        AF.request(url, method: HTTPMethod.post, parameters: model)
            .validate(statusCode: 200..<300).responseDecodable(of: NetworkClient.SignInResponseModel.self) { response in
                
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
