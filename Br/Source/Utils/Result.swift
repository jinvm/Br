//
//  Result.swift
//  Br
//
//  Created by Jin Um on 11.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import Foundation

extension Result {
    var value: Success? {
        guard case .success(let value) = self else {
            return nil
        }
        return value
    }
    
    var error: Failure? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }
    
    var isSuccess: Bool {
        return value != nil
    }
}
