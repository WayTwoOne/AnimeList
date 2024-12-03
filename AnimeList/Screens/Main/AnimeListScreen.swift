//
//  AnimeListScreen.swift
//  AnimeList
//
//  Created by Vladimir on 03.12.2024.
//

import SwiftUI

struct AnimeListScreen: View {
    @StateObject var viewModel = AnimeViewModel()
    
    let columns: [GridItem] = [
        GridItem(.fixed(180)),
        GridItem(.fixed(180))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 25) {
                        ForEach(viewModel.animeList) { anime in
                            NavigationLink(destination: AnimeDetailsScreen(viewModel: viewModel, anime: anime.media)) {
                                AnimeRowView(viewModel: viewModel, anime: anime.media)
                            }
                        }
                        Text("Load more")
                            .onAppear {
                                viewModel.nextPage()
                            }
                            .task {
                                Task(operation: viewModel.fetchMedia)
                            }
                    }
                    .padding(.top, 15)
                    .navigationTitle("Anime")
            }
        }
        .task {
            Task(operation: viewModel.fetchMedia)
        }
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListScreen()
    }
}
