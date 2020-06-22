//
//  CustomCollectionViewFlowLayout.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collection = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                             withScrollingVelocity: velocity)
        }
        let itemsCount = collection.numberOfItems(inSection: 0)
        let cellWithSpacing = UIScreen.main.bounds.width + minimumInteritemSpacing
        let relative = (proposedContentOffset.x + collection.contentInset.left) / cellWithSpacing
        let leftIndex = max(0, floor(relative))
        let rightIndex = min(ceil(relative), CGFloat(itemsCount))
        let leftCenter = leftIndex * cellWithSpacing - collection.contentInset.left
        let rightCenter = rightIndex * cellWithSpacing - collection.contentInset.left
        if abs(leftCenter - proposedContentOffset.x) < abs(rightCenter - proposedContentOffset.x) {
            return CGPoint(x: leftCenter, y: proposedContentOffset.y)
        } else {
            return CGPoint(x: rightCenter, y: proposedContentOffset.y)
        }
    }
}
