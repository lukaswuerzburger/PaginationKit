//
//  ResponsePage.swift
//  PaginationControllerDemo
//
//  Created by Lukas Würzburger on 8/10/20.
//  Copyright © 2020 Lukas Würzburger. All rights reserved.
//

import PaginationKit

struct ResponsePage: Page {
    var count: Int
    var page: Int
    var pageSize: Int
    var results: [String]
}

extension ResponsePage {

    var hasNextPage: Bool {
        return ((page + 1) * pageSize) + results.count < count
    }
}
