//
//  BeerListViewController.swift
//  🍻
//
//  Created by Jin Um on 09.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol BeerListViewBindable: BeerSelectedViewBindable {
    var beerListData: Driver<[BeerData]> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    var reloadList: Signal<Void> { get }
    var itemSelected: PublishRelay<Int> { get }
    var errorMessage: Signal<String> { get }
}

class BeerListViewController: UIViewController {
    
    let tableView = UITableView()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAttributes()
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupAttributes() {
        view.backgroundColor = .white
        
        tableView.backgroundView = UIView()
        tableView.backgroundColor = .white
        tableView.register(BeerListCell.self,
                           forCellReuseIdentifier: String(describing: BeerListCell.self))
        tableView.backgroundView?.isHidden = true
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
     
    func bind(_ viewModel: BeerListViewBindable) {
        
        tableView.rx.willDisplayCell
            .map { $0.indexPath }
            .bind(to: viewModel.willDisplayCell)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .do(onNext: { [weak self] _ in
                let selectedViewController = BeerSelectedViewController()
                selectedViewController.bind(viewModel)
                self?.navigationController?.pushViewController(selectedViewController, animated: true)
            })
            .map { $0.row }
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
            
        viewModel.beerListData.drive(tableView.rx.items) { tv, row, data in
            let index = IndexPath(row: row, section: 0)
            let cell = tv.dequeueReusableCell(
                withIdentifier: String(describing: BeerListCell.self),
                for: index) as! BeerListCell
            cell.setData(data: data)
            return cell
        }
        .disposed(by: disposeBag)
        
        viewModel.reloadList.emit(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(to: self.rx.showNetworkErrorAlert)
            .disposed(by: disposeBag)
    }
 
}
