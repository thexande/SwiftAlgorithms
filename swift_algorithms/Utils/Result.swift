//
//  Result.swift
//  swift_algorithms
//
//  Created by Vladislav Prusakov on 04/11/2018.
//  Copyright © 2018 Alexander Murphy. All rights reserved.
//

import Foundation

// MARK: - Definitions

typealias ResultHandler<T> = (Result<T>) -> Void

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result where T == Void {
    static var success: Result<Void> {
        return .success(())
    }
}

// MARK: - Transformations

extension Result {
    
    func map<U>(transform: (T) -> U) -> Result<U> {
        switch self {
        case .success(let originValue):
            return .success(transform(originValue))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func flatMap<U>(transform: (T) -> Result<U>) -> Result<U> {
        switch self {
        case .success(let originValue):
            return transform(originValue)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func voidify() -> Result<Void> {
        return self.map { _ in }
    }
    
    func unwrapped() throws -> T {
        switch self {
        case .success(let originValue):
            return originValue
        case .failure(let error):
            throw error
        }
    }
    
    var error: Error? {
        switch self {
        case .success(_):
            return nil
        case .failure(let error):
            return error
        }
    }
}
