//
//  FeedRepository.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-03.
//

import Foundation

class FeedRepository: FeedsRepositoryProtocol {
    
    var remoteService: Service!
    var localService: Service!
    
    init() {
        self.remoteService = RemoteFeedService()
        self.localService = LocalFeedService()
    }
    
    func loadFeeds() async throws -> [News] {
        let news = try await remoteService.loadFeeds()
        return news
    }
    
}
