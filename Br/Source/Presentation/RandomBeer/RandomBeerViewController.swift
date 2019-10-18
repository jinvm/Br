//
//  RandomBeerViewController.swift
//  Br
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RandomBeerViewBindable {
    var getRandomButtonTapped: PublishRelay<Void> { get }
    var randomBeerData: Signal<BeerData> { get }
    var errorMessage: Signal<String> { get }
}

class RandomBeerViewController: UIViewController {
    
    // MARK: - Initialization
    
    let beerImageView = UIImageView()
    let idLabel = UILabel()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let randomButton = UIButton()
    let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        addSubviews()
        setupConstraints()
    }
    
    private func setupAttribute() {
        idLabel.font = .systemFont(ofSize: 14, weight: .light)
        idLabel.textColor = .brown
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .black)
        nameLabel.textColor = .darkGray
        nameLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .black)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        
        beerImageView.clipsToBounds = true
        beerImageView.contentMode = .scaleAspectFit
        
        randomButton.setTitle("Get random Beer🍺", for: .normal)
        randomButton.backgroundColor = self.view.tintColor
        randomButton.layer.cornerRadius = 4
        randomButton.clipsToBounds = true
    }
    
    private func addSubviews() {
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(beerImageView)
        view.addSubview(randomButton)
    }
    
    private func setupConstraints() {
        
        beerImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(240)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(beerImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        randomButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(56)
        }
        
    }

    func bind(_ viewModel: RandomBeerViewBindable) {
        randomButton.rx.tap
            .bind(to: viewModel.getRandomButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.randomBeerData
            .emit(to: self.rx.setData)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(to: self.rx.showNetworkErrorAlert)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: RandomBeerViewController {
    var setData: Binder<BeerData> {
        return Binder(base) { base, data in
            base.beerImageView.kf.setImage(with: URL(string: data.imageURL))
            base.idLabel.text = "\(data.id)"
            base.nameLabel.text = data.name
            base.descriptionLabel.text = data.description
        }
    }
}
