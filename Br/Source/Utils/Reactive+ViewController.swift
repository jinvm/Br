//
//  Rx+ViewController.swift
//  Br
//
//  Created by Jin Um on 10.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var showNetworkErrorAlert: Binder<String> {
        return Binder(base) { base, errorMsg in
            let alertController = UIAlertController(title: "Error", message:
                errorMsg, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            base.present(alertController, animated: true, completion: nil)
        }
    }
}
