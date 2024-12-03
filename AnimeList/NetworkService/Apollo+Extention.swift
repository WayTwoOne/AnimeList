//
//  Apollo+Extention.swift
//  AnimeList
//
//  Created by Vladimir on 03.12.2024.
//

import Apollo
import ApolloAPI

extension ApolloClient {

    func fetchPublisherMy<Query: GraphQLQuery>(query: Query) -> GraphQLQueryPublisher<Query> {
        return GraphQLQueryPublisher(client: self, query: query)
    }
}
