//
//  AuthManager.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/20/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    public var signInURL: URL? {
        return nil
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    
    public func getToken(urlLink: String, completion: @escaping((Bool) -> Void)) {
        
        guard let url = URL(string: urlLink) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Failed to get new todak: \(String(describing: error))")
                completion(false)
                return
            }

            if let newToken = String(data: data, encoding: .utf8) {
                print("NEW TOKEN: \(newToken)")
                self?.cacheToken(newToken)
                completion(true)
            } else {
                completion(false)
            }
        }
        task.resume()
        
    }
    
    
    /// Supplies valid token to be used with API Calls
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard let token = accessToken else {
            // TODO: Throw to login view
            print("Error! Can not get local AccessToken")
            return
        }
        
        print("Valid Token: \(token)")
        
        completion(token)
    }
    
    public func cacheToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: "accessToken")
        UserDefaults.standard.synchronize()
    }
    
    public func signOut(completion: (Bool) -> Void) {
        UserDefaults.standard.setValue(nil, forKey: "accessToken")
        completion(true)
    }
    
}
