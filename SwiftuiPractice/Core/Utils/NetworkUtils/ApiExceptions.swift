//
//  ApiExceptions.swift
//  SwiftuiPractice
//
//  Created by TechnoNext on 9/2/26.
//

import Foundation

// MARK: - API Error
enum ApiExceptions: LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case encodingError
    case serverError(statusCode: Int)
    case clientError(statusCode: Int)
    case unauthorized
    case forbidden
    case notFound
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .noData:
            return "No data received from server"
        case .decodingError:
            return "Failed to decode response data"
        case .encodingError:
            return "Failed to encode request data"
        case .serverError(let statusCode):
            return "Server error (Status: \(statusCode))"
        case .clientError(let statusCode):
            return "Client error (Status: \(statusCode))"
        case .unauthorized:
            return "Unauthorized. Please login again."
        case .forbidden:
            return "Access forbidden"
        case .notFound:
            return "Resource not found"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
