//
//  Network.swift
//  AnimeList
//
//  Created by Vladimir on 03.12.2024.
//

import Foundation
import Combine
import Apollo
import AnimeListSchema

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

//class Network {
//
//
//    let url = "https://graphql.anilist.co"
//    let client = ApolloClient(url: URL(string: "https://graphql.anilist.co")!)
//
//    func fetchTransactions(query: AnimeListQuery, with completion: @escaping(Result<[MediaList], NetworkError>) -> Void) {
//        guard let url = URL(string: url) else { return completion(.failure(.invalidURL))}
//        ApolloClient(url: url).fetch(query: query) { result in
//            switch result {
//            case .success(let anime):
//                if let animeList = anime.data?.page {
//                    let list = self.process(with: animeList)
//                    completion(.success(list))
//                } else {
//                    completion(.failure(.decodingError))
//                }
//            case .failure(_):
//                completion(.failure(.noData))
//            }
//        }
//    }
//
//    private func process(with data: AnimeData?) -> [MediaList] {
//        guard data != nil else { return [] }
//
//        return Page(data).mediaList
//    }
//}

public class Network {
    public static let shared = Network()
    
    private init() {}
    
    public let url = "https://graphql.anilist.co"
    
    public lazy var apollo = ApolloClient(url: URL(string: url)!)
}
