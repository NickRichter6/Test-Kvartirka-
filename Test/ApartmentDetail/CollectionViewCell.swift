//
//  CollectionViewCell.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
        
    private lazy var photo: UIImageView = {
        let pht = UIImageView()
        pht.contentMode = .scaleAspectFill
        pht.translatesAutoresizingMaskIntoConstraints = false
        pht.clipsToBounds = true
        return pht
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(photo)
        
        photo.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photo.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photo.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageURLString: String?) {
        guard let imageURLString = imageURLString else { return }
        if let url = URL(string: imageURLString) {
            photo.kf.indicatorType = .activity
            photo.kf.setImage(with: url)
        }
    }
}


