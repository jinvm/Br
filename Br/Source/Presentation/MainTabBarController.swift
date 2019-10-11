//
//  MainTabBarController.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import UIKit
import RxSwift

protocol MainTabBarBindable {
    var beerListViewModel: BeerListViewBindable { get }
    var singleBeerViewModel: SingleBeerViewBindable { get }
    var randomBeerViewModel: RandomBeerViewBindable { get }
}

class MainTabBarController: UITabBarController {
    
    enum Tab: Int {
        case beerList
        case singleBeer
        case randomBeer
    }
    
    let disposeBag = DisposeBag()
    let beerListViewController = BeerListViewController()
    let singleBeerViewController = SingleBeerViewController()
    let randomBeerViewController = RandomBeerViewController()
    
    let tabBarItems: [Tab: UITabBarItem] = [
        .beerList: UITabBarItem(
            title: "Beer List",
            image:  #imageLiteral(resourceName: "MultipleBeers"),
            selectedImage:  #imageLiteral(resourceName: "MultipleBeers")
        ),
        .singleBeer: UITabBarItem(
            title: "Single Beer",
            image: #imageLiteral(resourceName: "SingleBeer"),
            selectedImage: #imageLiteral(resourceName: "SingleBeer")
        ),
        .randomBeer: UITabBarItem(
            title: "Random Beer",
            image:  #imageLiteral(resourceName: "SingleBeerWithBubble"),
            selectedImage: #imageLiteral(resourceName: "SingleBeerWithBubble")
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = UIColor.black
        view.backgroundColor = .white
 
        self.viewControllers = [
            UINavigationController(rootViewContorller: beerListViewController,
                                   tabItem: tabBarItems[.beerList]),
            UINavigationController(rootViewContorller: singleBeerViewController,
                                   tabItem: tabBarItems[.singleBeer]),
            UINavigationController(rootViewContorller: randomBeerViewController,
                                   tabItem: tabBarItems[.randomBeer])
        ]
    }
    
    func bind(_ viewModel: MainTabbarViewModel) {
        beerListViewController.bind(viewModel.beerListViewModel)
        singleBeerViewController.bind(viewModel.singleBeerViewModel)
        randomBeerViewController.bind(viewModel.randomBeerViewModel)
    }

}

extension UINavigationController {
    convenience init(rootViewContorller: UIViewController, tabItem: UITabBarItem?) {
        rootViewContorller.tabBarItem = tabItem
        rootViewContorller.title = tabItem?.title
        self.init(rootViewController: rootViewContorller)
        self.navigationBar.prefersLargeTitles = true
    }
}
