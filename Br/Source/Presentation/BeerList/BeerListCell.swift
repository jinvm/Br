//
//  BeerListCell.swift
//  🍻
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import UIKit
import SnapKit

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
        
        beerImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.left.equalToSuperview()
            $0.height.width.equalTo(120)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalTo(beerImageView.snp.right).offset(8)
            $0.height.equalTo(20)
            $0.right.equalToSuperview().offset(-8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(4)
            $0.height.equalTo(20)
            $0.left.equalTo(beerImageView.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6).priority(1000)
            $0.bottom.lessThanOrEqualToSuperview().offset(-16).priority(800)
            $0.left.equalTo(nameLabel)
            $0.right.equalToSuperview().offset(-8)
        }
    }

}
