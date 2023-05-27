//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Jun Hyeok Kim on 2023/05/27.
//

import Foundation


struct YoutubeSearchResponse : Codable {
    let items : [Video]
}

struct Video : Codable {
    let id : VideoId
}


struct VideoId : Codable {
    let kind : String
    let videoId : String
}
