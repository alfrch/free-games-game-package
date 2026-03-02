//
//  GetGamesRemoteDataSource.swift
//  Game
//
//  Created by Alif Rachmawan on 26/02/26.
//

import Foundation
import Core
import Combine
import Alamofire

public struct GetGamesRemoteDataSource: DataSource {
  
  public typealias Request = String
  public typealias Response = [GameResponse]
  
  private let endpoint: String
  
  public init(endpoint: String) {
    self.endpoint = endpoint
  }
  
  public func execute(request: Request?) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      
      guard let url = URL(string: endpoint) else {
        completion(.failure(NetworkError.invalidURL))
        return
      }
      
      AF.request(url)
        .validate()
        .responseDecodable(of: [GameResponse].self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
          case .failure(let error):
            if let afError = error.asAFError {
              if afError.isResponseSerializationError {
                completion(.failure(NetworkError.parsingError))
                return
              }
            }
            completion(.failure(NetworkError.invalidResponse))
          }
        }
    }
    .eraseToAnyPublisher()
  }
}
