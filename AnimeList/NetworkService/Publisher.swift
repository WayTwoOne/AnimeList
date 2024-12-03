//
//  Publisher.swift
//  AnimeList
//
//  Created by Vladimir on 03.12.2024.
//


import Foundation
import Combine
import Apollo
import ApolloAPI

struct GraphQLQueryPublisher<Query: GraphQLQuery>: Publisher {
    typealias Output = GraphQLResult<Query.Data>
    typealias Failure = Error
    
    private let client: ApolloClient
    private let query: Query
    
    init(client: ApolloClient, query: Query) {
        self.client = client
        self.query = query
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Error, S.Input == GraphQLResult<Query.Data> {
        let subscription = GraphQLQuerySubscription(client: self.client,
                                                    query: self.query,
                                                    subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}
