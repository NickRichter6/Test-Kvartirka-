//
//  UITableViewExtensions.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit

extension UITableView {

    func registerCellNib<T: UITableViewCell>(_ cellType: T.Type) {
        register(
            UINib(nibName: String(describing: T.self), bundle: nil),
            forCellReuseIdentifier: String(describing: T.self)
        )
    }
    
    func deque<T: UITableViewCell>(_ type: T.Type) -> T {
        let identifier = String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("No cell for specified cell class")
        }
        return cell
    }
}
