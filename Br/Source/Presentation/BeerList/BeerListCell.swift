//
//  BeerListCell.swift
//  🍻
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import UIKit

class BeerListCell: UITableViewCell {
        
    let idLabel = UILabel()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let beerImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAttributes()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: BeerData) {
        beerImageView.kf.setImage(with: URL(string: data.imageURL))
        idLabel.text = "\(data.id)"
        nameLabel.text = data.name
        descriptionLabel.text = data.description
    }
    
    private func setupAttributes() {
          idLabel.font = .systemFont(ofSize: 14, weight: .light)
          idLabel.textColor = .blue
          
          nameLabel.font = .systemFont(ofSize: 18, weight: .black)
          nameLabel.textColor = .darkGray
          nameLabel.numberOfLines = 0
          
          descriptionLabel.font = .systemFont(ofSize: 16, weight: .black)
          descriptionLabel.textColor = .gray
          descriptionLabel.numberOfLines = 0
          
          beerImageView.clipsToBounds = true
          beerImageView.contentMode = .scaleAspectFit
      }
      
      private func addSubviews() {
          addSubview(idLabel)
          addSubview(nameLabel)
          addSubview(descriptionLabel)
          addSubview(beerImageView)
      }
      
      private func setupConstraints() {
          
          [idLabel, nameLabel, descriptionLabel, beerImageView]
            .forEach {
              $0.translatesAutoresizingMaskIntoConstraints = false
            }
          
          let descriptionTopAnchor = descriptionLabel.topAnchor
            .constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
          descriptionTopAnchor.priority = UILayoutPriority(rawValue: 1000)

          let descriptionBottomAnchor = descriptionLabel.bottomAnchor
            .constraint(equalTo: bottomAnchor, constant: -16)
          descriptionBottomAnchor.priority = UILayoutPriority(rawValue: 1000)
          
          NSLayoutConstraint.activate([
              
              beerImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
              beerImageView.heightAnchor.constraint(equalToConstant: 120),
              beerImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
              beerImageView.widthAnchor.constraint(equalToConstant: 120),
              
              idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
              idLabel.heightAnchor.constraint(equalToConstant: 20),
              idLabel.leftAnchor.constraint(equalTo: beerImageView.rightAnchor, constant: 8),
              idLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
              
              nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 4),
              nameLabel.heightAnchor.constraint(equalToConstant: 20),
              nameLabel.leftAnchor.constraint(equalTo: beerImageView.rightAnchor, constant: 8),
              nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
              
              descriptionLabel.leftAnchor.constraint(equalTo: beerImageView.rightAnchor, constant: 8),
              descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
              descriptionTopAnchor,
              descriptionBottomAnchor
          ])
      }


}
