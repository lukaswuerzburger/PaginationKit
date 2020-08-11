//
//  ViewController.swift
//  PaginationControllerDemo
//
//  Created by Lukas Würzburger on 8/9/20.
//  Copyright © 2020 Lukas Würzburger. All rights reserved.
//

import UIKit
import PaginationController



class ViewController: UITableViewController {

    // MARK: - UI Actions

    @objc func loadMoreButtonPressed() {
        paginationController.loadNextPageIfNecessary()
    }

    // MARK: - Variables

    var items: [String] = []
    var paginationController: PaginationController<ResponsePage>!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        items = generateRandomElements()
        setupPaginationController()
    }

    // MARK: - View Setup

    func setupPaginationController() {
        paginationController = TableViewPaginationController(tableView: tableView) { previousPage, callback in
            self.loadMore(previousPage: previousPage) { page in
                self.items += page?.results ?? []
                self.tableView.reloadData()
                callback(page)
            }
        }
    }

    // MARK: - Networking

    func loadMore(previousPage: ResponsePage?, callback: @escaping (ResponsePage?) -> Void) {
        let nextPage = (previousPage?.page ?? -1) + 1
        let response = ResponsePage(count: 30, page: nextPage, pageSize: 10, results: self.generateRandomElements())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(response)
        }
    }

    // MARK: - Helper

    func generateRandomElements() -> [String] {
        var elements: [String] = []
        for _ in 0..<10 {
            var element: String = ""
            for _ in 0..<Int.random(in: 10..<30) {
                let string = String("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()!)
                element.append(string)
            }
            elements.append(element)
        }
        return elements
    }
}

// MARK: - Table View Data Source

extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let index = indexPath.row
        cell.textLabel?.text = "\(index + 1)\t\(items[index])"
        if indexPath.row == items.count - 1 {
            paginationController.loadNextPageIfNecessary()
        }
        return cell
    }
}
