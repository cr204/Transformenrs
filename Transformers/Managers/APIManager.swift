//
//  APIManager.swift
//  Transformers
//
//  Created by Jasur Rajabov on 4/20/21.
//

import Foundation

final class APIManager {
    static let shared = APIManager()

    private init() {}

    enum APIError: Error {
        case faileedToGetData
    }
    
    
    
    
    public func getTransformerList(completion: @escaping ((Result<[Transformer], Error>)) -> Void) {
        
        createRequest(with: URL(string: Links.getTransformerList), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                
//                let dataAsString = String(data: data, encoding: .utf8)!
//                print("________DATA___________")
//                print(dataAsString)

                do {
                    let result = try JSONDecoder().decode(ListResponce.self, from: data)
                    completion(.success(result.transformers))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func addNew(transformer: Transformer, completion: @escaping ((Result<Transformer, Error>)) -> Void) {
        
        createRequest(with: URL(string: Links.createTransformer), type: .POST) { request in
            
            var request = request
            let json: [String: Any] =  [
                "name": transformer.name,
                "strength": transformer.strength,
                "intelligence": transformer.intelligence,
                "speed": transformer.intelligence,
                "endurance": transformer.endurance,
                "rank": transformer.rank,
                "courage": transformer.courage,
                "firepower": transformer.firepower,
                "skill": transformer.skill,
                "team": transformer.team
                ]

            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }
 
                let dataAsString = String(data: data, encoding: .utf8)!
                print("________DATA___________")
                print(dataAsString)

                do {
                    let result = try JSONDecoder().decode(Transformer.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    
    
    // MARK: - Private

    enum HTTPMethod: String {
        case GET
        case PUT
        case POST
        case DELETE
    }

    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
}
