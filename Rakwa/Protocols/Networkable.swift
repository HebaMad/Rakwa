//
//  Networkable.swift
//  Rakwa
//
//  Created by moumen isawe on 26/10/2021.
//


import Foundation
import Moya
protocol Networkable{
    associatedtype targetType:TargetType
    
    var provider: MoyaProvider<targetType> { get }
    func request<T:Decodable>(target:targetType,completion: @escaping (Result<T, Error>) -> ())
}
extension Networkable{
    
    func request<T: Decodable>(target: targetType, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            print(result )
            switch result {
            
            case let .success(response):
                print(response.request?.method)
                print(response.request?.urlRequest)
                print(response.request?.headers)
                do {
                    print(String(data: response.data, encoding: .utf8))

                    let results = try JSONDecoder().decode(T.self, from: response.data)

                 
                    completion(.success(results))


                } catch let error {
                print(error)

                    completion(.failure(error))
                }
            case let .failure(error):
                print(error)

                completion(.failure(error))
            }
        }
    }
}
