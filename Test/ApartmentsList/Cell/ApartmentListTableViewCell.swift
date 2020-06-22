//
//  ApartmentListTableViewCell.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit
import Kingfisher

class ApartmentListTableViewCell: UITableViewCell {
    
    static let defaultHeight: CGFloat = 250
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    func configure(flat: Flat, currency: String) {
        addressLabel.text = flat.address
        
        if let url = URL(string: flat.photo_default.url) {
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(with: url)
        }
        
        if flat.prices.day != 0 {
            priceLabel.text = String(flat.prices.day) + " " + currency
        } else if flat.prices.night != 0 {
            priceLabel.text = String(flat.prices.night) + " " + currency
        } else if flat.prices.hour != 0 {
            priceLabel.text = String(flat.prices.hour) + " " + currency
        }
    }
}
