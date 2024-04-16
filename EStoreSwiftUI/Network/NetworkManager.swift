//
//  NetworkManager.swift
//  EStoreSwiftUI
//
//  Created by Agung Dwi Saputra on 14/04/24.
//

import Foundation
import Alamofire
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func postData(with request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badURLResponse(url: request.url!)
        }
        
        if httpResponse.statusCode == 401, let responseBody = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
            throw NetworkError.unauthorized(message: responseBody.message, statusCode: httpResponse.statusCode)
        }else if !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.unknown(httpResponse)
        }
        
        return data
        
    }

    
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badURLResponse(url: url)
        }
        
        if httpResponse.statusCode == 401, let responseBody = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
            throw NetworkError.unauthorized(message: responseBody.message, statusCode: httpResponse.statusCode)
        } else if !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.unknown(httpResponse)
        }
        
        return data
    }
    
    func uploadImage(image: UIImage) async throws -> String {
        guard let url = APIUrl.Endpoint.uploadFile.fullURLEndpoint() else {
            throw URLError(.badURL)
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.conversionFailed
        }
        
        let data = try await withCheckedThrowingContinuation { continuation in
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            }, to: url)
            .validate()
            .responseDecodable(of: UploadResponse.self) { response in
                switch response.result {
                case .success(let uploadResponse):
                    continuation.resume(returning: uploadResponse.location)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
        return data
    }
    
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkError: Error {
    case badURLResponse(url: URL)
    case unknown(HTTPURLResponse?)
    case unauthorized(message: String, statusCode: Int)
}
