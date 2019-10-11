//
//  SingleBeerModel.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation
import RxSwift

struct SingleBeerModel: BeerDataParsable {
    
    let punkNetwork: PunkNetwork
    
    init(punkNetwork: PunkNetwork = PunkNetworking()) {
        self.punkNetwork = punkNetwork
    }
    
    func getSingleBeer(id: String) -> Single<Result<Beer, PunkNetworkError>> {
        return punkNetwork.getBeer(id: id)
    }

}
