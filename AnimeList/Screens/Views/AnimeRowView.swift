//
//  AnimeRowView.swift
//  AnimeList
//
//  Created by Vladimir on 03.12.2024.
//

import SwiftUI

struct AnimeRowView: View {
    @ObservedObject var viewModel: AnimeViewModel
    
    let anime: Media
    var body: some View {
        LazyVStack {
            
            AsyncImage(url: URL(string: anime.coverImage.extraLarge)) { image in
              image.resizable()
                    .frame(width: 160, height: 160)
                    .cornerRadius(15)
                    .clipped()
            } placeholder: {
              ProgressView()
            }
            .frame(width: 60, height: 60, alignment: .center)
            .padding(.vertical, 35)
            Text(viewModel.title(anime.title))
                .font(.system(size: 15))
                .frame(width: 140, height: 75, alignment: .center)
                .foregroundColor(.black)
        }
        .multilineTextAlignment(.center)
    }
}

//struct AnimeRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeRowView()
//    }
//}
