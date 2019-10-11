//
//  MainTabBarViewModel.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MainTabbarViewModel: MainTabBarBindable {
    
    let beerListViewModel: BeerListViewBindable
    let singleBeerViewModel: SingleBeerViewBindable
    let randomBeerViewModel: RandomBeerViewBindable
    
    init() {
        self.beerListViewModel = BeerListViewModel()
        self.singleBeerViewModel = SingleBeerViewModel()
        self.randomBeerViewModel = RandomBeerViewModel()
    }
}
