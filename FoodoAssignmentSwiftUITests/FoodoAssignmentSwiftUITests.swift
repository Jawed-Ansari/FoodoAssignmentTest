//
//  FoodoAssignmentSwiftUITests.swift
//  FoodoAssignmentSwiftUITests
//
//  Created by Muhhmmd Jawed Ansari on 26/02/26.
//

import XCTest
@testable import FoodoAssignmentSwiftUI

final class FoodoAssignmentSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    final class RepositoryTests: XCTestCase {

        func testOfflineReturnsCachedData() async throws {
            let cache = FileCache()
            let api = MockAPIClient()
            let repo = ItemRepository(api: api, cache: cache)

            cache.save([
                Item(id: "X", title: "Cached",
                     status: .done, detail: "Offline", updatedAt: .now)
            ])

            let items = try await repo.load()
            XCTAssertEqual(items.first?.title, "Cached")
        }
    }
    
//    func testMergeKeepsLatestUpdatedItem() {
//        let old = [
//            Item(id: "1", title: "Old",
//                 status: .new, detail: "", updatedAt: .distantPast)
//        ]
//
//        let new = [
//            Item(id: "1", title: "New",
//                 status: .done, detail: "", updatedAt: .now)
//        ]
//
//        let repo = ItemRepository(api: MockAPIClient(), cache: FileCache())
//        let merged = repo.merge(old: old, new: new)
//
//        XCTAssertEqual(merged.first?.title, "New")
//    }
    
    func testLoadingToLoadedState() async {
        let vm = await ItemListViewModel(
            repository: ItemRepository(
                api: MockAPIClient(),
                cache: FileCache()
            )
        )

        await vm.load()
        try? await Task.sleep(nanoseconds: 600_000_000)

        if case .loaded = await vm.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected loaded state")
        }
    }

}
