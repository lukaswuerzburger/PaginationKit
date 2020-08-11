//
//  PaginationController.swift
//  PaginationController
//
//  Created by Lukas Würzburger on 09.08.20.
//  Copyright © 2020 Lukas Würzburger. All rights reserved.
//

public protocol PaginationLifeCycleDelegate: class {
    func paginationDidStartLoading()
    func paginationDidStopLoading()
}

open class PaginationController<P: Page> {

    public enum State {
        case idle
        case running
    }

    // MARK: - Variables

    var loadResource: (_ after: P?, @escaping (P?) -> Void) -> Void
    var lastPage: P? = nil
    public var lifeCycleDelegate: PaginationLifeCycleDelegate?
    public var state: State = .idle

    // MARK: - Initializer

    public init(initialPage: P? = nil, loadResource: @escaping (_ after: P?, @escaping (P?) -> Void) -> Void) {
        self.lastPage = initialPage
        self.loadResource = loadResource
    }

    // MARK: - Life Cycle Hooks

    open func loadingDidStart() {
        lifeCycleDelegate?.paginationDidStartLoading()
    }

    open func loadingDidStop() {
        lifeCycleDelegate?.paginationDidStopLoading()
    }

    // MARK: - Life Cycle

    public func reset() {
        lastPage = nil
        state = .idle
    }

    public func loadNextPageIfNecessary() {
        guard state == .idle else { return }
        guard (lastPage?.hasNextPage ?? true) else { return }
        loadingDidStart()
        state = .running
        loadResource(lastPage) { [weak self] page in
            self?.handlePageResponse(page)
        }
    }

    private func handlePageResponse(_ page: P?) {
        state = .idle
        if let page = page {
            lastPage = page
        }
        loadingDidStop()
    }
}
