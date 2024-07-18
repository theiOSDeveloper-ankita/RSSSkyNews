//
//  SkyNewsData.swift
//  SkyNews
//
//  Created by Ankita Jaiswal on 25/06/24.
//

import Foundation

struct RSSNewsItem : Identifiable, Decodable{
    var id = UUID()
    var title: String
    var description: String
    var link: String
    var imageURL: String
}
