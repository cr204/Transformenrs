//
//  TransformerListPresenter.swift
//  Transformers
//
//  Created by Jasur Rajabov on 5/20/21.
//

import Foundation

class TransformerListPresenter {
    var robotList: [Transformer] = []
    
    
    func fetchListData(completion: @escaping ((Result<[Transformer], Error>)) -> Void) {
        APIManager.shared.getTransformerList { result in
            switch result {
            case .success(let model):
                self.robotList = model.sorted { $0.team < $1.team }
                completion(.success(self.robotList))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func removeTransformer(id: String) {
        print("Remove: \(id)")
        
        APIManager.shared.removeTransformer(id: id) { result in
            switch result {
            case .success(let res):
                print("Res: \(res)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeTransformer(id: String, completion: @escaping ((Result<Bool, Error>)) -> Void) {
        print("Remove: \(id)")
        
        APIManager.shared.removeTransformer(id: id) { result in
            completion(result)
        }
    }
        
        
}
