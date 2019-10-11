//
//  BeerDetailViewController.swift
//  Br
//
//  Created by Jin Um on 11.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

protocol BeerSelectedViewBindable {
   var selectedBeerData: Signal<BeerData> { get }
}

class BeerSelectedViewController: UIViewController {
    
    // MARK: - INITIALIZATION
    let disposeBag = DisposeBag()
    
    let beerImageView = UIImageView()
    let idLabel = UILabel()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
        addSubviews()
        setupConstraints()
    }
    
    private func setupAttributes() {
        title = "Selected Beer"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
     
        idLabel.font = .systemFont(ofSize: 14, weight: .light)
        idLabel.textColor = .brown
      
        nameLabel.font = .systemFont(ofSize: 18, weight: .black)
        nameLabel.textColor = .darkGray
        nameLabel.numberOfLines = 0
       
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
  
        beerImageView.clipsToBounds = true
        beerImageView.contentMode = .scaleAspectFit
    }
    
    private func addSubviews() {
        view.addSubview(beerImageView)
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        
        [beerImageView, idLabel, nameLabel, descriptionLabel]
        .forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            beerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                               constant: 30),
            beerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            beerImageView.heightAnchor.constraint(equalToConstant: 240),
            
            idLabel.topAnchor.constraint(equalTo: beerImageView.bottomAnchor,
                                         constant: 12),
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          
            
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor,
                                           constant: 12),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                                  constant: 12),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                    constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                    constant: -20),
        ])
    }
    
    func bind(_ viewModel: BeerSelectedViewBindable) {
        viewModel.selectedBeerData
            .emit(to: self.rx.setData)
            .disposed(by: disposeBag)
    }
    
}

extension Reactive where Base: BeerSelectedViewController {
    var setData: Binder<BeerData> {
        return Binder(base) { base, data in
            base.beerImageView.kf.setImage(with: URL(string: data.imageURL))
            base.idLabel.text = "\(data.id)"
            base.nameLabel.text = data.name
            base.descriptionLabel.text = data.description
        }
    }
}
