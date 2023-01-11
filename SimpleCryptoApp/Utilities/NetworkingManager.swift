//
//  NetworkingManager.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 10.01.2023.
//

import Foundation
import Combine

class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown

        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "[🔥] Bad response from URL. \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
    }

    static func download(from url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleUrl(output: $0, from: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    //error checking before assignment to property
    static func handleUrl(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print(error.localizedDescription)
        case .finished:
            break
        }
    }

    //checking the response in tryMap
    static func handleUrl(output: URLSession.DataTaskPublisher.Output, from url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else { throw NetworkingError.badURLResponse(url: url) }
        return output.data
    }
}
