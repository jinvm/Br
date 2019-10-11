//
//  BeerListModel.swift
//  🍻
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation
import RxSwift

struct BeerListModel: BeerDataParsable {
   
    let punkNetwork: PunkNetwork
    
    init(punkNetwork: PunkNetwork = PunkNetworking()) {
        self.punkNetwork = punkNetwork
    }
    
    func getBeerList() -> Single<Result<[Beer], PunkNetworkError>> {
        return punkNetwork.getBeers(params: BeerFilterParams(), page: nil, perPage: nil)
    }
    
    func fetchMoreData(from: Int) -> Single<Result<[Beer], PunkNetworkError>> {
        let page = (from + 1)/25 + 1
        return punkNetwork.getBeers(params: BeerFilterParams(), page: page, perPage: 25)
    }
    
}
