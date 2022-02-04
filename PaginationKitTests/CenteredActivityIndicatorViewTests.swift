//
//  CenteredActivityIndicatorViewTests.swift
//  PaginationControllerTests
//
//  Created by Lukas Würzburger on 8/11/20.
//  Copyright © 2020 Lukas Würzburger. All rights reserved.
//

import XCTest
@testable import PaginationKit

class CenteredActivityIndicatorViewTests: XCTestCase {

    func testForwardsAnimationToActivityIndicatorView() {
        let loadingView = CenteredActivityIndicatorView(activityIndicatorStyle: .gray)
        XCTAssertFalse(loadingView.activityIndicatorView.isAnimating)
        loadingView.startAnimating()
        XCTAssertTrue(loadingView.activityIndicatorView.isAnimating)
        loadingView.stopAnimating()
        XCTAssertFalse(loadingView.activityIndicatorView.isAnimating)
    }
}
