//
//  AnimeListModel.swift
//  AnimeList
//
//  Created by Vladimir on 03.12.2024.
//

import Foundation
import AnimeListSchema

internal typealias AnimeData = AnimeListQuery.Data.Page

public struct AnimeList: Codable {
    public var page: Page

    public enum CodingKeys: String, CodingKey {
        case page = "Page"
    }
}

public struct Page: Codable {
    public var mediaList: [MediaList]
    
    public init(_ animeData: AnimeData?) {
        self.mediaList = animeData?.mediaList?.map({ anime -> MediaList in
            MediaList(anime)
        }) ?? []
      }
}

public struct MediaList: Codable, Identifiable {
    public var id = UUID()
    
    public var media: Media
    
    public init(_ anime: AnimeData.MediaList?) {
        self.media = Media(anime?.media)
    }
}

public struct Media: Codable {
    public var title: Title
    public var coverImage: CoverImage
    public var description: String
    
    public init(_ anime: AnimeData.MediaList.Media?) {
        self.title = Title(anime?.title)
        self.coverImage = CoverImage(anime?.coverImage)
        self.description = anime?.description ?? ""
    }
}

public struct CoverImage: Codable {
    public var extraLarge: String
    
    public init(_ anime: AnimeData.MediaList.Media.CoverImage?) {
        self.extraLarge = anime?.extraLarge ?? ""
    }
}

public struct Title: Codable {
    public var english: String?
    public var native: String
    
    public init(_ anime: AnimeData.MediaList.Media.Title?) {
        self.english = anime?.english
        self.native = anime?.native ?? ""
    }
}
