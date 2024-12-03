//
//  AnimeViewModel.swift
//  AnimeList
//
//  Created by Vladimir on 03.12.2024.
//

import Foundation
import Combine
import AnimeListSchema

class AnimeViewModel: ObservableObject {
    @Published var animeList: [MediaList] = []
    @Published var page: GraphQLNullable<Int> = 1
    
    private var cancellable = Set<AnyCancellable>()
    
    
    func fetchMedia() async throws {
           Network.shared.apollo.fetch(query: AnimeListQuery(page: page)) { [weak self] result in
               switch result {
               case .success(let anime):
                   if let animeList = anime.data?.page {
                       guard let list = self?.process(with: animeList) else { return }
                       self?.animeList += list
                   } else if let errors = anime.errors {
                       print("GraphQL errors \(errors)")
                   }
               case .failure(let error):
                   print(error)
               }
           }
       }

       
       private func process(with data: AnimeData?) -> [MediaList] {
           guard data != nil else { return [] }
           
           return Page(data).mediaList
       }
    
    func nextPage() {
        guard let integer = self.page.unwrapped else { return }
        var newPage = 1
        newPage += integer
        self.page = GraphQLNullable<Int>(integerLiteral: newPage)
    }
    
    
//    func fetchMedia() {
//        network.fetchTransactions(query: AnimeListQuery(page: page)) { result in
//            switch result {
//            case .success(let anime):
//                self.animeList = anime
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//
//    private func process(with data: AnimeData?) -> [MediaList] {
//        guard data != nil else { return [] }
//
//        return Page(data).mediaList
//    }
    
    func title(_ name: Title) -> String {
        var title = ""
        if name.english != nil {
            title = name.english ?? ""
        } else {
            title = name.native
        }
        
        return title
    }
}
