//
//  LoadFeedsUseCase.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-03.
//

import Foundation

class LoadFeedsUseCase {
    var feedsRepository: FeedsRepositoryProtocol!
    
    init(feedsRepository: FeedsRepositoryProtocol) {
        self.feedsRepository = feedsRepository
    }
    
    func loadFeeds() async throws -> [News] {
        let feeds = try await feedsRepository.loadFeeds()
        return feeds
    }
}

protocol FeedsRepositoryProtocol {
    func loadFeeds() async throws -> [News]
}
