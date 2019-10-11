//
//  Observable+Optional.swift
//  Br
//
//  Created by Jin Um on 11.10.19.
//  Copyright © 2019 Jin Um. All rights reserved.
//

import RxSwift
import RxCocoa

extension ObservableType {
    func filterNilValue<Value>(_ transform: @escaping (E) -> Value?) -> Observable<Value> {
        return map(transform).filterNil()
    }
}

public extension SharedSequenceConvertibleType {
    func filterNilValue<Value>(_ transform: @escaping (E) -> Value?) -> SharedSequence<SharingStrategy, Value> {
        return map(transform).filterNil()
    }
}
