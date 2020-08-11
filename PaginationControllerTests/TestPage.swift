//
//  TestPage.swift
//  PaginationControllerTests
//
//  Created by Lukas Würzburger on 8/11/20.
//  Copyright © 2020 Lukas Würzburger. All rights reserved.
//

import PaginationController

class TestPage: NSObject, Page {
    var hasNextPageValue: Bool

    init(hasNextPageValue: Bool) {
        self.hasNextPageValue = hasNextPageValue
        super.init()
    }

    var hasNextPage: Bool {
        return hasNextPageValue
    }
}
