//
//  Venue.swift
//  VenueMap
//
//  Created by koogawa on 2015/07/21.
//  Copyright (c) 2015 Kosuke Ogawa. All rights reserved.
//

public struct Venue: Codable {
    public let id: String
    public let name: String
    public let location: Location
    public let categories: [VenueCategory]?
    public let rating : Float?
    public let canonicalUrl: String?
    public let contact: VenueContact
    public let photos: VenuePhotos?

    public init(id: String,
                name: String,
                location: Location,
                categories: [VenueCategory]?,
                rating : Float?,
                canonicalUrl: String?,
                contact: VenueContact,
                photos : VenuePhotos) {
        self.id = id
        self.name = name
        self.location = location
        self.categories = categories
        self.rating = rating
        self.canonicalUrl = canonicalUrl
        self.contact = contact
        self.photos = photos
    }
}
