//
//  PlaceDetails.swift
//  GetGoingClass
//
//  Created by Alla Bondarenko on 2019-01-23.
//  Copyright © 2019 SMU. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceDetails: NSObject, NSCoding {
    struct PropertyKey {
        static let idKey = "id"
        static let nameKey = "name"
        static let vicinityKey = "vicinity"
        static let longtitude = "longtitude"
        static let latitudeKey = "latitude"
        static let formattedAddressKey = "formattedAddress"
        static let ratingKey = "rating"
        static let iconKey = "icon"
    }

    // MARK : - Properties

    var id: String
    var name: String?
    var vicinity: String?
    var coordinate: CLLocationCoordinate2D?
    var formattedAddress: String?
    var rating: Double?
    var icon: String?
    var address: String? {
        return formattedAddress ?? vicinity
    }

    var placeid: String?
    var formatterPhoneNumber: String?
    var websiteLabel: String?
    
    //MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.idKey)
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(vicinity, forKey: PropertyKey.vicinityKey)
        aCoder.encode(formattedAddress, forKey: PropertyKey.formattedAddressKey)
        if let rating = rating{
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
        }
        aCoder.encode(icon, forKey: PropertyKey.iconKey)

    }

    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: PropertyKey.idKey) as? String ?? ""
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as? String
        let vicinity = aDecoder.decodeObject(forKey: PropertyKey.vicinityKey) as? String
        let formattedAddress = aDecoder.decodeObject(forKey: PropertyKey.formattedAddressKey) as? String
        let rating = aDecoder.decodeDouble(forKey: PropertyKey.ratingKey)
        let icon = aDecoder.decodeObject(forKey: PropertyKey.iconKey) as? String

        self.init(id: id, name: name, vicinity: vicinity, formattedAddress: formattedAddress, rating: rating, icon: icon)
    }

    // MARK: - Initializers

    init(id: String, name: String?, vicinity: String?, formattedAddress: String?, rating: Double?, icon: String?) {
        self.id = id
        self.name = name
        self.vicinity = vicinity
        self.formattedAddress = formattedAddress
        self.rating = rating
        self.icon = icon
    }

    init?(json: [String: Any]) {
        guard let id = json["id"] as? String else { return nil }
        self.id = id

        self.name = json["name"] as? String
        self.vicinity = json["vicinity"] as? String
        self.formattedAddress = json["formatted_address"] as? String
        self.rating = json["rating"] as? Double
        self.icon = json["icon"] as? String
        self.placeid = json["place_id"] as? String
        self.formatterPhoneNumber = json["formatted_phone_number"] as? String
        self.websiteLabel = json["website"] as? String
        
        if let geometry = json["geometry"] as? [String:Any]{
            if let location = geometry["locaion"] as? [String: Any]{
                if let latitude = location["lat"] as?
                Double,
                let longitude = location["lng"] as?
                    Double{
                    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                }
            }
        }
    }
}
