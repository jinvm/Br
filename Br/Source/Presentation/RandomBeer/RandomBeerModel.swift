//
//  RandomBeerModel.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import RxSwift

struct RandomBeerModel: BeerDataParsable {
    let punkNetwork: PunkNetwork
    
    init(punkNetwork: PunkNetwork = PunkNetworking()) {
        self.punkNetwork = punkNetwork
    }
    
    func getRandomBeer() -> Single<Result<Beer, PunkNetworkError>> {
        return punkNetwork.getRandomBeer()
    }
}
