//
//  RandomBeerViewModel.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import RxSwift
import RxCocoa

struct RandomBeerViewModel: RandomBeerViewBindable {

    let getRandomButtonTapped = PublishRelay<Void>()
    let randomBeerData: Signal<BeerData>
    let errorMessage: Signal<String>

    init(model: RandomBeerModel = RandomBeerModel()) {
        
        let fetchResult = getRandomButtonTapped
            .flatMapLatest(model.getRandomBeer)
            .asObservable()
            .share()
         
        let fetchError = fetchResult
            .filterNilValue { $0.error?.message }
        
        let fetchValue = fetchResult
            .filterNilValue { $0.value }
            
        self.randomBeerData = fetchValue
            .map(model.parseData)
            .flatMap { Observable.from(optional: $0) }
            .asSignal(onErrorSignalWith: .empty())
        
        self.errorMessage = fetchError
            .asSignal(onErrorSignalWith: .empty())

    }
     
}
