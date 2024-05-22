//
//  LocalService.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-04.
//

import Foundation

class LocalFeedService: Service {
    
    func loadFeeds() async throws -> [News] {
        throw LocalDatabaseError.databaseNotFound
    }
    
}

enum LocalDatabaseError: Error {
    case databaseNotFound
    case databaseError
}
