//
//  UICollectionViewExtensions.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCellNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(
            UINib(nibName: String(describing: T.self), bundle: nil),
            forCellWithReuseIdentifier: String(describing: T.self)
        )
    }
    
    func deque<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("No cell for specified cell class")
        }
        return cell
    }
}
