//
//  BrTests.swift
//  BrTests
//
//  Created by Jin Um on 11.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import Quick
import Nimble

@testable import Br

class SingleBeerSpec: QuickSpec {
    
    let networkStub = PunkNetworkStub()
    var model: SingleBeerModel!
    var viewModel: SingleBeerViewModel!
    let disposeBag = DisposeBag()
    
    override func spec() {
        model = SingleBeerModel(punkNetwork: networkStub)
        viewModel = SingleBeerViewModel(model: model)
        
        testSingleBeerModel()
        testSingleBeerViewModel()
    }
    
    func testSingleBeerModel() {
        describe("Test single beer model") {
            context("When id is given") {
                let givenId = "1"
                let (expectedId, expectedName) = (1, "Buzz")
                
                model.getSingleBeer(id: givenId).subscribe(onSuccess: { result in
                    let beer = try? result.get()
                    assert(beer != nil, "It should have value when getting single beer is success")
                    it("should parse data and have expected values") {
                        let parsedData = self.model.parseData(value: beer!)
                        guard let beerData = parsedData else {
                            assertionFailure()
                            return
                        }
                        expect(beerData.id) == expectedId
                        expect(beerData.name) == expectedName
                    }
                })
                .disposed(by: disposeBag)
            }
        }
    }
    
    func testSingleBeerViewModel() {
        describe("Test single beer view model") {
            it("should emit beer data and have values for beer id 1") {
                let (expectedId, expectedName) = (1, "Buzz")
                self.viewModel.singleBeerData
                    .emit(onNext: { beerData in
                        expect(beerData.id) == expectedId
                        expect(beerData.name) == expectedName
                    }).disposed(by: self.disposeBag)
                
                self.viewModel.searchButtonClicked.accept("1")
            }
        }
    }

}
