//
//  EndPoints.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import Foundation

struct Endpoints {
    
    func getCities() -> String {
        return "\(DEFAULT_SERVER_ADDRESS)/country/?pretty"
    }
    
    func getFlats(cityId: String, offset: String, screenWidth: String? = nil, screenHeight: String? = nil) -> String {
        var result = "\(DEFAULT_SERVER_ADDRESS)/flats/?city_id=\(cityId)"
        if let screenWidth = screenWidth, let screenHeight = screenHeight {
            result.append("&device_screen_width=\(screenWidth)&device_screen_height=\(screenHeight)")
        }
        result.append("&offset=\(offset)")
        return result
    }
}
