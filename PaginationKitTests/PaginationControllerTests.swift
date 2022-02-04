//
//  PaginationControllerTests.swift
//  PaginationControllerTests
//
//  Created by Lukas Würzburger on 8/9/20.
//  Copyright © 2020 Lukas Würzburger. All rights reserved.
//

import XCTest
@testable import PaginationKit

class PaginationControllerTests: XCTestCase {

    func testInitializerStoresArguments() {
        let page = TestPage(hasNextPageValue: true)
        var didCallClosure = false
        let paginationController = PaginationController(initialPage: page) { _, _ in
            didCallClosure = true
        }
        XCTAssertEqual(page, paginationController.lastPage)
        XCTAssertFalse(didCallClosure)
        paginationController.loadResource(TestPage(hasNextPageValue: true), { _ in })
        XCTAssertTrue(didCallClosure)
    }

    func testReset() {
        let paginationController = PaginationController(initialPage: TestPage(hasNextPageValue: true)) { _, _ in }
        XCTAssertNotNil(paginationController.lastPage)
        XCTAssertEqual(paginationController.state, .idle)
        paginationController.loadNextPageIfNecessary()
        XCTAssertEqual(paginationController.state, .running)
        paginationController.reset()
        XCTAssertNil(paginationController.lastPage)
        XCTAssertEqual(paginationController.state, .idle)
    }

    func testCallsDelegateWhenStarting() {
        let paginationController = PaginationController(initialPage: TestPage(hasNextPageValue: true)) { _, callback in
            callback(nil)
        }
        let delegate = LifeCycleDelegate()
        paginationController.lifeCycleDelegate = delegate
        XCTAssertFalse(delegate.didCallPaginationDidStartLoading)
        XCTAssertFalse(delegate.didCallPaginationDidStopLoading)
        paginationController.loadNextPageIfNecessary()
        XCTAssertTrue(delegate.didCallPaginationDidStartLoading)
        XCTAssertTrue(delegate.didCallPaginationDidStopLoading)
    }

    func testStartsWhenNotRunning() {
        let paginationController = PaginationController(initialPage: TestPage(hasNextPageValue: true)) { _, callback in
            DispatchQueue.main.async {
                callback(nil)
            }
        }
        let expect = expectation(description: "did stop callback being called.")
        let delegate = LifeCycleDelegate()
        delegate.didCallPaginationDidStopLoadingCallback = {
            XCTAssertEqual(paginationController.state, .idle)
            expect.fulfill()
        }
        paginationController.lifeCycleDelegate = delegate
        XCTAssertEqual(paginationController.state, .idle)
        paginationController.loadNextPageIfNecessary()
        XCTAssertEqual(paginationController.state, .running)
        wait(for: [expect], timeout: 1)
    }

    func testDoesNotStartWhenRunning() {
        let paginationController = PaginationController(initialPage: TestPage(hasNextPageValue: true)) { _, _ in }
        XCTAssertEqual(paginationController.state, .idle)
        paginationController.loadNextPageIfNecessary()
        XCTAssertEqual(paginationController.state, .running)
        let delegate = LifeCycleDelegate()
        paginationController.lifeCycleDelegate = delegate
        paginationController.loadNextPageIfNecessary()
        XCTAssertFalse(delegate.didCallPaginationDidStartLoading)
    }

    func testDoesNotStartWhenLastPageWasLast() {
        let paginationController = PaginationController(initialPage: TestPage(hasNextPageValue: false)) { _, _ in }
        XCTAssertEqual(paginationController.state, .idle)
        paginationController.loadNextPageIfNecessary()
        XCTAssertEqual(paginationController.state, .idle)
    }
}

class LifeCycleDelegate: PaginationLifeCycleDelegate {

    var didCallPaginationDidStartLoadingCallback: (() -> Void)?
    var didCallPaginationDidStartLoading = false {
        didSet { didCallPaginationDidStartLoadingCallback?() }
    }
    var didCallPaginationDidStopLoadingCallback: (() -> Void)?
    var didCallPaginationDidStopLoading = false {
        didSet { didCallPaginationDidStopLoadingCallback?() }
    }

    func paginationDidStartLoading() {
        didCallPaginationDidStartLoading = true
    }

    func paginationDidStopLoading() {
        didCallPaginationDidStopLoading = true
    }
}
