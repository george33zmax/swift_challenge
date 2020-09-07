//
//  Network.swift
//  CodeChallenge
//
//  Created by Jorge Menendez on 9/6/20.
//  Copyright © 2020 CodeChallenge. All rights reserved.
//

import Foundation

class Network {
    
    struct User: Codable {
        let userName: String
        let firstName: String
        let lastName: String
    }
    
    struct NewPassword: Codable {
        let currentPassword: String
        let newPassword: String
        let checkPassword: String
    }
    
    struct PasswordUpdated: Codable {
        let data: [String: [String:String]]
        let code: String
        let message: String
        let exceptionName: String?
    }
    
    static func fetchProfileData(completion: @escaping (Result<User, Error>) -> Void) {
        
        let urlString = "https://api.foo.com/profiles/mine"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            // error
            if let err = err {
                //completion(.failure(err))
                let user = Network.User(userName: "IOS User", firstName: "Johnny B.", lastName: "Goode")
                completion(.success(user))
                return
            }
            // successful
            do {
                let resData = try JSONDecoder().decode(User.self, from: data!)
                completion(.success(resData))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
    
    static func updateUserData(params: User, completion: @escaping (Result<User, Error>) -> Void) {
        
        let urlString = "https://api.foo.com/profiles/update"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(params)
        } catch let error {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            // error
            if let err = err {
                //completion(.failure(err))
                let user = Network.User(userName: params.userName, firstName: params.firstName, lastName: params.lastName)
                completion(.success(user))
                return
            }
            // successful
            do {
                let resData = try JSONDecoder().decode(User.self, from: data!)
                completion(.success(resData))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
    
    static func updateUserPassword(params: NewPassword, completion: @escaping (Result<PasswordUpdated, Error>) -> Void) {
        
        let urlString = "https://api.foo.com/password/change"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(params)
        } catch let error {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            
            // error
            if let err = err {
                //completion(.failure(err))
                let passwordUpdated = Network.PasswordUpdated(data: ["":["":""]], code: "string", message: "Password Changed", exceptionName: nil)
                completion(.success(passwordUpdated))
                return
            }
            // successful
            do {
                let resData = try JSONDecoder().decode(PasswordUpdated.self, from: data!)
                completion(.success(resData))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
    
}
