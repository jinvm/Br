//
//  BeerDataParsable.swift
//  Br
//
//  Created by Jin Um on 10.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation

typealias BeerData = (id: Int, name: String, description: String, imageURL: String)

protocol BeerDataParsable {
    func parseData(value: Beer) -> BeerData?
    func parseBeerListData(value: [Beer]) -> [BeerData]
}

extension BeerDataParsable {
    
    func parseData(value: Beer) -> BeerData? {
        return (
            id: value.id ?? 0,
            name: value.name ?? "",
            description: value.description ?? "",
            imageURL: value.imageURL ?? ""
        )
    }
    
    func parseBeerListData(value: [Beer]) -> [BeerData] {
        return value.map {
            (id: $0.id ?? 0,
             name: $0.name ?? "",
             description: $0.description ?? "",
             imageURL: $0.imageURL ?? "")
        }
    }
}
