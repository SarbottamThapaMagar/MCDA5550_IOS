//
//  Constants.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-21.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation

class Constants {

    static let apiKey = ""
k
    static let scheme = "https"
    static let host = "maps.googleapis.com"
    static let textPlaceSearch = "/maps/api/place/textsearch/json"
    static let nearbySearch = "/maps/api/place/nearbysearch/json"
    static let placeDetails = "/map/api/place/details/output?parameters"

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("PlaceDetails")
}
