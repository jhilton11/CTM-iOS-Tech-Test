//
//  RemoteFeedService.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-03.
//

import Foundation
import SWXMLHash

class RemoteFeedService: Service {
    
    func loadFeeds() async throws -> [News] {
        guard let url = URL(string: Constants.BASE_URL) else {
            print("Invalid URL error")
            throw NetworkError.apiError
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw NetworkError.apiError
            }
            
            let rawXML = String(decoding: data, as: UTF8.self)
            let xml = XMLHash.parse(rawXML.removingCharactersBeforeWord("<rss") ?? "")
            let news: [News] = try xml["rss"]["channel"]["item"].value()
            return news
        } catch {
            if let _ = error as? NetworkError {
                print("Threw network error")
                throw NetworkError.apiError
            } else {
                throw XMLError.xmlParsingError
            }
        }
    }
    
}

