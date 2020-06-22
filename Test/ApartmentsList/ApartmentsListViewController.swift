//
//  ApartmentsListViewController.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import UIKit

class ApartmentsListViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    private let locationManager = LocationManager.shared
    
    private var currentCity = DEFAULT_CITY_NAME
    private var cities = [String: Int]()
    private var cityId: Int?
    private var flats = [Flat]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var currency: String?
    private var offset = 0
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.frame = CGRect(origin: .zero,
                            size: CGSize(width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.height)
        )
        view.separatorStyle = .none
        view.rowHeight = ApartmentListTableViewCell.defaultHeight
        view.estimatedRowHeight = ApartmentListTableViewCell.defaultHeight
        view.registerCellNib(ApartmentListTableViewCell.self)
        view.refreshControl = refreshControl
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.getCurrentCity { [weak self] (city, _, _) in
            guard let `self` = self else { return }
            self.currentCity = city
        }
        
        networkManager.getCities { [weak self] (cities, error) in
            guard let `self` = self else { return }
            guard let cities = cities else { return }
            self.cities = cities
            self.cityId = cities[self.currentCity]
            self.getNextFlats()
        }
        
    }
    
    @objc private func refresh() {
        flats.removeAll()
        offset = 0
        getNextFlats()
        refreshControl.endRefreshing()
    }
    
    private func getNextFlats() {
        guard let cityId = cityId else {
            return
        }
        
        networkManager.getFlats(fromCityId: cityId,
                                offset: offset,
                                screenWidth: Int(UIScreen.main.bounds.width),
                                screenHeight: Int(UIScreen.main.bounds.height))
        { [weak self] (_flats, error) in
            guard let `self` = self else { return }
            guard let _flats = _flats else { return }
            self.flats += _flats.flats
            self.currency = _flats.currency.label
            self.offset = _flats.query.meta.offset
        }
    }
    
}

//MARK: - UITableViewDelegate
extension ApartmentsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: String(describing: DetailApartmentViewController.self), bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: DetailApartmentViewController.self)) as! DetailApartmentViewController
        vc.flat = flats[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension ApartmentsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.deque(ApartmentListTableViewCell.self)
        cell.configure(flat: flats[indexPath.row], currency: currency ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !flats.isEmpty, flats.count - 15 == indexPath.row {
            getNextFlats()
        }
    }
}

