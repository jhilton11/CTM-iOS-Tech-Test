//
//  ParentPay_Technical_TestTests.swift
//  ParentPay Technical TestTests
//
//  Created by student on 2024-05-03.
//

import XCTest
@testable import CTM_Technical_Test

final class ParentPay_Technical_TestTests: XCTestCase {
    
    let service = FileService(fileName: "CustomXML", ext: "txt")
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_remove_illegal_xml() {
        let text = "illegal data<data>This is the data</data>".removingCharactersBeforeWord("<data>")
        XCTAssertEqual(text, "<data>This is the data</data>")
    }
    
    func test_xmlParser_parses_correctly() async {
        do {
            let news = try await service.loadFeeds()
            XCTAssertEqual(news[0].title, "Why the moon's south pole is the chequered flag of space race 2.0")
            XCTAssertEqual(news[0].link, "https://news.sky.com/story/why-the-moons-south-pole-is-the-chequered-flag-of-space-race-20-13128083")
            XCTAssertEqual(news[1].title, "Scientists find 'strong evidence' bird flu has passed from mammals to humans for first time")
        } catch {
            print("Error is: \(error.localizedDescription)")
            XCTFail()
        }
    }
    
    func test_viewModel_works_correctly() async {
        let repository = FeedRepository()
        repository.localService = FileService(fileName: "CustomXML", ext: "txt")
        let loadFeedUseCase = LoadFeedsUseCase(feedsRepository: repository)
        let viewModel = ViewModel(loadFeedUseCase: loadFeedUseCase)
        
        let result: Result<[News], Error> = await viewModel.loadFeed()
        switch (result) {
            case .success(let news):
                XCTAssertEqual(news.count, 10)
            case .failure(_):
                XCTFail()
        }
    }
    
}
