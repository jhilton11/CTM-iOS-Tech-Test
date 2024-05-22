//
//  Service.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-03.
//

import Foundation

protocol Service {
    func loadFeeds() async throws -> [News]
}

enum NetworkError: Error {
    case invalidURL
    case apiError
    case unknownError
}

//enum HTTPMethod: Error {
//    case GET
//    case POST
//    case PUT
//    case PATCH
//}

class WebSocketService: Service {
    func loadFeeds() async throws -> [News] {
        //perform websocket operations
        return [News]()
    }
}
