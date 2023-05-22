//
//  NetworkManager.swift
//  Sports
//
//  Created by Fatma_Hassan on 21/05/2023.
//

//aa502a5e593da9a0ccea18734e2ece289b05d81e9cb6ed521d7d9306da9888ce

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    
    static func loadDataFromURL <T : Decodable> (url : String? , complitionHandler : @escaping (T?) -> Void)
}

class NetworkManage : NetworkManagerProtocol {
    
    static func loadDataFromURL <T : Decodable> (url : String? , complitionHandler : @escaping (T?) -> Void){
        
        guard let finalURL = url else {
            return
        }
        
        AF.request(finalURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                case .success(let data):
                    do{
                        let result = try JSONDecoder().decode(T.self, from: data!)
                        complitionHandler(result)
                    } catch {
                        complitionHandler(nil)
                    }
                case .failure(let error):
                    print(error)
                    complitionHandler(nil)
                }
            }
    }
}
