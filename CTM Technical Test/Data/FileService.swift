//
//  FileService.swift
//  ParentPay Technical TestTests
//
//  Created by student on 2024-05-03.
//

import Foundation
import SWXMLHash

enum XMLError: Error {
    case xmlParsingError
    case fileParsingError
}

class FileService: Service {
    var fileName: String!
    var ext: String!
    
    init(fileName: String, ext: String) {
        self.fileName = fileName
        self.ext = ext
    }
    
    func loadFeeds() async throws -> [CTM_Technical_Test.News] {
//        print("Loading file \(fileName) of type \(ext)")
        if let filePath = Bundle.main.url(forResource: fileName!, withExtension: ext!) {
            do {
                let content = try String(contentsOf: filePath)
                let xml = XMLHash.parse(content.removingCharactersBeforeWord("<rss") ?? "")
                let news: [News] = try xml["rss"]["channel"]["item"].value()
                return news
            } catch {
                print("Threw XML parsing error")
                print("Error: \(error.localizedDescription)")
                throw XMLError.xmlParsingError
            }
        } else {
            print("Threw file parsing error")
            throw XMLError.fileParsingError
        }
    }
    
}
