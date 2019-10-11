//
//  BeerListViewModel.swift
//  🍻
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

struct BeerListViewModel: BeerListViewBindable {
    
    let beerListData: Driver<[BeerData]>
    let willDisplayCell = PublishRelay<IndexPath>()
    let reloadList: Signal<Void>
    let itemSelected = PublishRelay<Int>()
    let selectedBeerData: Signal<BeerData>
    let errorMessage: Signal<String>

    private var cells = BehaviorRelay<[Beer]>(value: [])
    
    init(model: BeerListModel = BeerListModel()) {
        
        let fetchedResult = model.getBeerList()
            .asObservable()
            .share()
        
        let fetchedError = fetchedResult
            .filterNilValue { $0.error?.message }
        
        let fetchedBeerList = fetchedResult
            .filterNilValue { $0.value }
        
        let shouldMoreFetch = Observable
            .combineLatest(willDisplayCell, cells) { (indexPath: $0, list: $1) }
            .map { data -> Int? in
                guard data.list.count > 24 else {
                    return nil
                }
                let lastCellCount = data.list.count
                if lastCellCount - 1 == data.indexPath.row {
                    return data.indexPath.row
                }
                return nil
            }
            .filterNil()
        
        let moreFetchedResult = shouldMoreFetch
            .distinctUntilChanged()
            .filter { $0 < 324 }
            .flatMapLatest(model.fetchMoreData)
            .asObservable()
            .share()
        
        let moreFetchedError = moreFetchedResult
            .filterNilValue { $0.error?.message }
        
        let moreFetchedBeerList = moreFetchedResult
            .filterNilValue { $0.value }
        
        _ = Observable
            .merge(fetchedBeerList, moreFetchedBeerList)
            .scan([]) { prev, newList in
                return newList.isEmpty ? [] : prev + newList
        }
        .bind(to: cells)
        
          self.reloadList = Observable
                  .zip(
                      fetchedBeerList,
                      moreFetchedBeerList
                  )
                  .map { _ in Void() }
                  .asSignal(onErrorSignalWith: .empty())
            
        
        self.beerListData = cells
            .map(model.parseBeerListData)
            .asDriver(onErrorDriveWith: .empty())
        
        self.selectedBeerData = Observable
            .combineLatest(cells, itemSelected) { (BeerList: $0, row: $1) }
            .map { (BeerList, row) -> Beer? in
                guard BeerList.count > row else {
                    return nil
                }
                return BeerList[row]
            }
            .filterNil()
            .map(model.parseData)
            .filterNil()
            .asSignal(onErrorSignalWith: .empty())

        self.errorMessage = Observable
            .merge(fetchedError, moreFetchedError)
            .asSignal(onErrorSignalWith: .empty())
    }
    
}


