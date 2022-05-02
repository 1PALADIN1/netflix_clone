//
//  ApiError.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 02.05.2022.
//

import Foundation

enum ApiError: Error {
    case errorUrlString(String)
    case emptyResponseData
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorUrlString(let urlString):
            return NSLocalizedString("Error creating url with string \(urlString)", comment: "")
        case .emptyResponseData:
            return NSLocalizedString("Response data is empty!", comment: "")
        }
    }
}
