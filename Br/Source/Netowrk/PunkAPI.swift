//
//  PunkAPI.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Moya
import RxSwift

enum PunkAPI {
    case getBeers(params: BeerFilterParams, page: Int?, perPage: Int?)
    case getBeer(id: String)
    case getRandomBeer
}

extension PunkAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.URL.punkAPI)!
    }
    
    var path: String {
        switch self {
        case .getBeers:
            return "/v2/beers"
        case .getBeer(let id):
            return "/v2/beers/\(id)"
        case .getRandomBeer:
            return "/v2/beers/random"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var paramters: [String:Any]? {
        switch self {
        case let .getBeers(_, page, perPage):
            guard let page = page,
                let perPage = perPage else {
                    return nil
            }
            return ["page": page,
                    "per_page": perPage]
        default:
            return nil
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: paramters ?? [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

struct BeerFilterParams {
    let abvGreaterThanSuppliedNumber: Double? = nil
    let abvLessThanSUppliedNumber: Double? = nil
    let ibuGreaterThanSuppliedNumber: Double? = nil
    let ibuLessThanSUppliedNumber: Double? = nil
    let ebcGreaterThanSuppliedNumber: Double? = nil
    let ebcLessThanSUppliedNumber: Double? = nil
    let name: String? = nil
    let yeast: String? = nil
    let hops: String? = nil
    let malt: String? = nil
    let food: String? = nil
    let ids: String? = nil
    let brewedBefore: Date? = nil
    let brewedAfter: Date? = nil
}
