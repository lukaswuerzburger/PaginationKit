//
//  TableViewPaginationControllerTests.swift
//  PaginationControllerTests
//
//  Created by Lukas Würzburger on 8/11/20.
//  Copyright © 2020 Lukas Würzburger. All rights reserved.
//

import XCTest
@testable import PaginationKit

class TableViewPaginationControllerTests: XCTestCase {

    func testInitializerStoresArguments() {
        let tableView = UITableView()
        let loadingView = CenteredActivityIndicatorView(activityIndicatorStyle: .gray)
        var didCallCallback = false
        let controller = TableViewPaginationController(tableView: tableView, loadingView: loadingView, initialPage: TestPage(hasNextPageValue: true)) { _, _ in
            didCallCallback = true
        }
        XCTAssertEqual(tableView, controller.tableView)
        XCTAssertEqual(loadingView, controller.loadingView)
        controller.loadNextPageIfNecessary()
        XCTAssertTrue(didCallCallback)
    }

    func testLifeCycleHooksBeingCalled() {
        let controller = TableViewPaginationControllerMock(tableView: UITableView()) { _, callback in
            callback(nil)
        }
        XCTAssertFalse(controller.didCallLoadingDidStart)
        XCTAssertFalse(controller.didCallLoadingDidStop)
        controller.loadNextPageIfNecessary()
        XCTAssertTrue(controller.didCallLoadingDidStart)
        XCTAssertTrue(controller.didCallLoadingDidStop)
    }

    func testLoadingViewCycle() {
        let loadingView = LoadingViewMock()
        let controller = TableViewPaginationControllerMock(tableView: UITableView(), loadingView: loadingView) { _, callback in
            callback(nil)
        }
        XCTAssertFalse(loadingView.didCallStartAnimating)
        XCTAssertFalse(loadingView.didCallStopAnimating)
        controller.loadNextPageIfNecessary()
        XCTAssertTrue(loadingView.didCallStartAnimating)
        XCTAssertTrue(loadingView.didCallStopAnimating)
    }
}

class TableViewPaginationControllerMock: TableViewPaginationController<TestPage> {

    var didCallLoadingDidStart = false
    var didCallLoadingDidStop = false

    override func loadingDidStart() {
        super.loadingDidStart()
        didCallLoadingDidStart = true
    }

    override func loadingDidStop() {
        super.loadingDidStop()
        didCallLoadingDidStop = true
    }
}

class LoadingViewMock: UIView, LoadingAnimatable {

    var didCallStartAnimating = false
    var didCallStopAnimating = false

    func startAnimating() {
        didCallStartAnimating = true
    }

    func stopAnimating() {
        didCallStopAnimating = true
    }
}
