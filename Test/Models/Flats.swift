//
//  Flats.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import Foundation

struct Flats: Decodable {
    let flats: [Flat]
    let query: Query
    let currency: Currency
}

struct Flat: Decodable {
    let address: String
    let photo_default: PhotoDefault
    let photos: [Photo]
    let prices: Prices
    let building_type: String
    let rooms: Int
}

struct PhotoDefault: Decodable {
    let url: String
}

struct Photo: Decodable {
    let url: String
}

struct Prices: Decodable {
    let day: Int
    let hour: Int
    let night: Int
}

struct Currency: Decodable {
    let label: String
}

struct Query: Decodable {
    let meta: Meta
}

struct Meta: Decodable {
    let limit: Int
    let offset: Int
}
