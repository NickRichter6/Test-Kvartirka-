//
//  DetailApartmentViewController.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit

class DetailApartmentViewController: UIViewController {
    
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    
    var flat: Flat? {
        didSet{
            let flatType: FlatType = FlatType(rawValue: String(describing: flat!.building_type)) ?? .flat
            addressLabel.text = "Адрес:  \(String(describing: flat!.address))"
            buildingLabel.text = "Тип жилья:  \(flatType.rawValue)"
            roomsLabel.text = "Количество комнат:  \(String(describing: flat!.rooms))"
            pricesHLabel.text = "Час:  \(String(describing: flat!.prices.hour))"
            pricesDLabel.text = "День:  \(String(describing: flat!.prices.day))"
            pricesNLabel.text = "Ночь:  \(String(describing: flat!.prices.night))"
        }
    }
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var roomsLabel: UILabel = {
        let rlabel = UILabel()
        rlabel.translatesAutoresizingMaskIntoConstraints = false
        rlabel.font = UIFont.systemFont(ofSize: 20)
        return rlabel
    }()
    
    private lazy var buildingLabel: UILabel = {
        let blabel = UILabel()
        blabel.translatesAutoresizingMaskIntoConstraints = false
        blabel.font = UIFont.systemFont(ofSize: 30)
        return blabel
    }()
    
    private lazy var pricesHLabel: UILabel = {
        let pHLabel = UILabel()
        pHLabel.translatesAutoresizingMaskIntoConstraints = false
        pHLabel.font = UIFont.systemFont(ofSize: 20)
        return pHLabel
    }()
    
    private lazy var pricesNLabel: UILabel = {
        let pNLabel = UILabel()
        pNLabel.translatesAutoresizingMaskIntoConstraints = false
        pNLabel.font = UIFont.systemFont(ofSize: 20)
        return pNLabel
    }()
    
    private lazy var pricesDLabel: UILabel = {
        let pdLabel = UILabel()
        pdLabel.translatesAutoresizingMaskIntoConstraints = false
        pdLabel.font = UIFont.systemFont(ofSize: 20)
        return pdLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = false
        cv.decelerationRate = .fast
        cv.backgroundColor = .white
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pricesHLabel)
        view.addSubview(roomsLabel)
        view.addSubview(collectionView)
        view.addSubview(pricesDLabel)
        view.addSubview(buildingLabel)
        view.addSubview(addressLabel)
        view.addSubview(pricesNLabel)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        pricesHLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 130).isActive = true
        pricesHLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        roomsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        roomsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        pricesDLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50 ).isActive = true
        pricesDLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        pricesNLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 90).isActive = true
        pricesNLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        buildingLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        buildingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}


// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension DetailApartmentViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flat?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.configure(imageURLString: flat?.photos[indexPath.item].url)
        return cell
    }
}


