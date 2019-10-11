//
//  Beer.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation

struct Beer: Codable {
    let id: Int?
    let name, tagline, description, brewersTips, contributedBy, imageURL: String?
    let firstBrewed: Date
    let abv, ibu, targetFG, targetOG, ebc, srm, ph, attenuationLevel: Double?
    let volume: Volume?
    let boilVolume: BoilVolume?
    let method: BeerMethod?
    let ingredients: Ingredients?
    let foodParing: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description, abv, ibu, ebc, srm, ph, volume, method, ingredients
        case firstBrewed = "first_brewed"
        case imageURL = "image_url"
        case targetFG = "target_fg"
        case targetOG = "target_og"
        case attenuationLevel = "attenuation_level"
        case boilVolume = "boil_volume"
        case foodParing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let date = try values.decode(String.self, forKey: .firstBrewed)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-yyyy"
        
        self.id = try? values.decode(Int.self, forKey: .id)
        self.name = try? values.decode(String.self, forKey: .name)
        self.tagline = try? values.decode(String.self, forKey: .tagline)
        self.description = try? values.decode(String.self, forKey: .description)
        self.brewersTips = try? values.decode(String.self, forKey: .brewersTips)
        self.contributedBy = try? values.decode(String.self, forKey: .contributedBy)
        self.imageURL = try? values.decode(String.self, forKey: .imageURL)
        self.firstBrewed = dateFormatter.date(from: date) ?? Date()
        self.abv = try? values.decode(Double.self, forKey: .abv)
        self.ibu = try? values.decode(Double.self, forKey: .ibu)
        self.targetFG = try? values.decode(Double.self, forKey: .targetFG)
        self.targetOG = try? values.decode(Double.self, forKey: .targetOG)
        self.ebc = try? values.decode(Double.self, forKey: .ebc)
        self.srm = try? values.decode(Double.self, forKey: .srm)
        self.ph = try? values.decode(Double.self, forKey: .ph)
        self.attenuationLevel = try? values.decode(Double.self, forKey: .attenuationLevel)
        self.volume = try? values.decode(Volume.self, forKey: .volume)
        self.boilVolume = try? values.decode(BoilVolume.self, forKey: .boilVolume)
        self.method = try? values.decode(BeerMethod.self, forKey: .method)
        self.ingredients = try? values.decode(Ingredients.self, forKey: .ingredients)
        self.foodParing = try? values.decode([String].self, forKey: .foodParing)
    }
}

struct Volume: Codable {
    let value: Int
    let unit: String
}

struct BoilVolume: Codable {
    let value: Int
    let unit: String
}

struct BeerMethod: Codable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

struct MashTemp: Codable {
    let temp: Temp
    let duration: Int?
}

struct Temp: Codable {
    let value: Int
    let unit: String
}

struct Fermentation: Codable {
    let temp: Temp
}


//Incredients
struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hops]
    let yeast: String
}

struct Malt: Codable {
    let name: String
    let amount: Amount
}

struct Amount: Codable {
    let value: Double
    let unit: String
}

struct Hops: Codable {
    let name: String
    let amount: Amount
    let add: String
    let attribute: String
}
