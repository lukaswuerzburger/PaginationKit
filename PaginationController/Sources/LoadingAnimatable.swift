//
//  LoadingAnimatable.swift
//  PaginationController
//
//  Created by Lukas Würzburger on 8/9/20.
//  Copyright © 2020 Lukas Würzburger. All rights reserved.
//

import UIKit

public protocol LoadingAnimatable: UIView {
    func startAnimating()
    func stopAnimating()
}
