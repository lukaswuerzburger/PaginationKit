//
//  TableViewPaginationController.swift
//  trufflsChat
//
//  Created by Lukas Würzburger on 8/27/19.
//  Copyright © 2019 Truffls GmbH. All rights reserved.
//

import UIKit

open class TableViewPaginationController<P: Page>: PaginationController<P> {

    // MARK: - UI Elements

    public var loadingView: LoadingAnimatable
    public let tableView: UITableView

    // MARK: - Initializer

    public init(tableView: UITableView, loadingView: LoadingAnimatable = CenteredActivityIndicatorView(activityIndicatorStyle: .medium), initialPage: P? = nil, loadResource: @escaping (_ after: P?, @escaping (P?) -> Void) -> Void) {
        self.tableView = tableView
        self.loadingView = loadingView
        super.init(loadResource: loadResource)
    }

    // MARK: - Pagination Life Cycle

    open override func loadingDidStart() {
        super.loadingDidStart()
        loadingView.frame.size.height = 44
        tableView.tableFooterView = loadingView
        loadingView.startAnimating()
    }

    open override func loadingDidStop() {
        super.loadingDidStop()
        tableView.tableFooterView = nil
        loadingView.stopAnimating()
    }
}
