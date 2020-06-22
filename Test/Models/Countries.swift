//
//  Countries.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import Foundation

struct Countries: Decodable {
    let countries: [Country]
}

struct Country: Decodable {
    let cities: [City]
}
