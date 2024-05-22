//
//  ViewModel.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-04.
//

import Foundation

class ViewModel {
    
    var loadFeedUseCase: LoadFeedsUseCase!
    
    init(loadFeedUseCase: LoadFeedsUseCase) {
        self.loadFeedUseCase = loadFeedUseCase
    }
    
    func loadFeed() async -> Result<[News], Error> {
        do {
            let news = try await loadFeedUseCase.loadFeeds()
            return .success(news)
        } catch {
            print("Something went wrong")
            return .failure(error)
        }
    }
    
}
