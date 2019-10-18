//
//  Netowrking.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum PunkNetworkError: Error {
    case error(String)
    case defaultError
    
    var message: String? {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "Please retry later."
        }
    }
}

protocol PunkNetwork {
    typealias BeerResult<T> = Result<T, PunkNetworkError>
    
    func getBeers(params: BeerFilterParams, page: Int?, perPage: Int?) -> Single<BeerResult<[Beer]>>
    func getBeer(id: String) -> Single<BeerResult<Beer>>
    func getRandomBeer() -> Single<BeerResult<Beer>>
}

struct PunkErrorData: Codable {
    let statusCode: Int
    let error: String
    let message: String
}

class PunkNetworking: PunkNetwork {
    let provider = MoyaProvider<PunkAPI>()

    func getBeers(params: BeerFilterParams, page: Int?, perPage: Int?) -> Single<BeerResult<[Beer]>> {
        return provider.rx.request(.getBeers(params: params, page: page, perPage: perPage))
            .filterSuccessfulStatusCodes()
            .map {
            try JSONDecoder().decode([Beer].self, from: $0.data)
        }
        .map { .success($0) }
        .catchError {
            guard case MoyaError.statusCode(let res) = $0,
                let errorData = try? res.map(PunkErrorData.self) else {
                    return .just(.failure(.defaultError))
            }
            return .just(.failure(.error(errorData.message)))
        }
    }
    
    func getBeer(id: String) -> Single<BeerResult<Beer>> {
        return provider.rx.request(.getBeer(id: id))
            .filterSuccessfulStatusCodes()
            .map { try JSONDecoder().decode([Beer].self, from: $0.data) }
            .map { beers in
                guard let beer = beers.first else {
                    return .failure(.defaultError)
                }
                return .success(beer)
        }.catchError {
            guard case MoyaError.statusCode(let res) = $0,
                let errorData = try? res.map(PunkErrorData.self) else {
                    return .just(.failure(.defaultError))
            }
            return .just(.failure(.error(errorData.message)))
        }
    }
    
    func getRandomBeer() -> Single<BeerResult<Beer>> {
        return provider.rx.request(.getRandomBeer)
        .filterSuccessfulStatusCodes()
            .map { try JSONDecoder().decode([Beer].self, from: $0.data) }
            .map { beers in
                guard let beer = beers.first else {
                    return .failure(.defaultError)
                }
                return .success(beer)
        }.catchError {
            guard case MoyaError.statusCode(let res) = $0,
                let errorData = try? res.map(PunkErrorData.self) else {
                    return .just(.failure(.defaultError))
            }
            return .just(.failure(.error(errorData.message)))
        }
       
    }
    
  
}
