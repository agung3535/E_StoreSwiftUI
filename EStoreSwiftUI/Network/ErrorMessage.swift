//
//  ErrorMessage.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation


struct ErrorMessage {
    static func message(for error: Error) -> String {
        switch error {
        case let urlError as URLError:
            return message(for: urlError)
        default:
            return FailedMessages.unexpected
        }
    }
    
    private static func message(for urlError: URLError) -> String {
        switch urlError.code {
        case .notConnectedToInternet:
            return FailedMessages.notConnectedToInternet
        case .timedOut:
            return FailedMessages.timeout
        case .cannotParseResponse:
            return FailedMessages.cannotParseResponse
        default:
            return FailedMessages.unexpected
        }
    }
}

enum ImageError: Error {
    case conversionFailed
}

extension ImageError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .conversionFailed:
            return "Failed to convert image."
        }
    }
}

struct ServerErrorResponse: Codable {
    let message: String
    let statusCode: Int?
}

enum FailedMessages {
    static let notConnectedToInternet = "The internet connection appears to be offline. Please try again later."
    static let timeout = "The network request timed out. Please check your connection and try again."
    static let unexpected = "An unexpected network error occurred. Please try again."
    static let cannotParseResponse = "The data cannot be parsed to the expected format. Please check your input form."
}
