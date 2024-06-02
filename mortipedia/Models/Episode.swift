//
//  Episode.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 6/1/24.
//

import Foundation

struct EpisodeResponse: Codable {
    let info: ResponseInfo
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
