//
//  SingleBeerViewModel.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct SingleBeerViewModel: SingleBeerViewBindable {
    
    let searchButtonClicked = PublishRelay<String?>()
    let singleBeerData: Signal<BeerData>
    let errorMessage: Signal<String>
    
    init(model: SingleBeerModel = SingleBeerModel()) {
        
        let fetchResult = searchButtonClicked
            .flatMap { Observable.from(optional: $0) }
            .flatMapLatest { model.getSingleBeer(id: $0) }
            .share()
        
        let fetchError = fetchResult
            .filterNilValue { $0.error?.message }
        
        let fetchValue = fetchResult
            .filterNilValue { $0.value }
        
        self.singleBeerData = fetchValue
            .map(model.parseData)
            .flatMap { Observable.from(optional: $0) }
            .asSignal(onErrorSignalWith: .empty())
        
        self.errorMessage = fetchError
            .asSignal(onErrorSignalWith: .empty())
    }
}
