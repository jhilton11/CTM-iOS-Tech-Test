//
//  News.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-03.
//

import Foundation
import SWXMLHash

struct News: XMLObjectDeserialization, Codable {
    var title: String
    var description: String
    var link: String
    var imageUrl: String
    var pubDate: String
    
    static func deserialize(_ element: XMLIndexer) throws -> News {
        return try News(title: element["title"].value(),
                    description: element["description"].value(),
                    link: element["link"].value(),
                    imageUrl: element["media:thumbnail"].value(ofAttribute: "url"),
                    pubDate: element["pubDate"].value())
    }
}
