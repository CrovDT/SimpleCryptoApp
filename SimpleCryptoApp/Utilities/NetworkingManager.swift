//
//  NetworkingManager.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 10.01.2023.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
   case invalidURL(String)
   case invalidResponseStatus
   case dataTaskError(String)
   case corruptData
   case decodingError(String)

   var errorDescription: String? {
       switch self {
       case .invalidURL(let url):
           return NSLocalizedString("The endpoint URL is invalid. URl: \(url)", comment: "")
       case .invalidResponseStatus:
           return NSLocalizedString("The APIO failed to issue a valid response.", comment: "")
       case .dataTaskError(let string):
           return string
       case .corruptData:
           return NSLocalizedString("The data provided appears to be corrupt", comment: "")
       case .decodingError(let string):
           return string
       }
   }
}

class NetworkingManager {
//    enum NetworkingError: LocalizedError {
//        case badURLResponse(url: URL)
//        case unknown
//
//        var errorDescription: String? {
//            switch self {
//            case .badURLResponse(let url):
//                return "[🔥] Bad response from URL. \(url)"
//            case .unknown:
//                return "[⚠️] Unknown error occured"
//            }
//        }
//    }
    static func download(from url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleUrl(output: $0, from: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // error checking before assignment to property
    static func handleUrl(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print(error.localizedDescription)
        case .finished:
            break
        }
    }

    // checking the response in tryMap
    static func handleUrl(output: URLSession.DataTaskPublisher.Output, from url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else { throw APIError.invalidResponseStatus }
        return output.data
    }
}
