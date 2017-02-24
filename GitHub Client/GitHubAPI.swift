//
//  GitHubAPI.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 23/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import Foundation
import Moya


public enum GitHub {
    case userRepositories(String)
    case searchRepositories(String,Int)
    case listRepositories(Int)
    case repoProfile(String)
    case repoCommits(String)
    case repoBranches(String)
}

extension GitHub: TargetType {
    public var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    public var path: String {
        switch self {
        case .searchRepositories(_,_):
            return "/search/repositories"
        case .listRepositories(_):
            return "/repositories"
        case .repoProfile(let full_name):
            return "/repos/\(full_name)"
        case .repoCommits(let full_name):
            return "/repos/\(full_name)/commits"
        case .repoBranches(let full_name):
            return "/repos/\(full_name)/branches"
        case .userRepositories(let name):
            return "/users/\(name.urlEscaped)/repos"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    public var parameters: [String: Any]? {
        switch self {
        case .userRepositories(_):
            return ["sort": "pushed"]
        case .listRepositories(let page):
            return ["since": page]
        case .searchRepositories(let query,let page):
            return ["q": "\(query)", "page" : page]
        default:
            return nil
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        return .request
    }
    public var validate: Bool {
        switch self {
            default:
                return false
        }
    }
    public var sampleData: Data {
        
        switch self {
        case .searchRepositories:
            return "".data(using: String.Encoding.utf8)!
        case .repoProfile:
             return "".data(using: String.Encoding.utf8)!
        case .repoBranches:
            return "".data(using: String.Encoding.utf8)!
        case .repoCommits:
            return "".data(using: String.Encoding.utf8)!
        case .listRepositories:
            return "[{\"id\":1  \"name\" : \"grit\"}]".data(using: String.Encoding.utf8)!
        case .userRepositories(_):
            return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

//MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

let GitHubProvider = MoyaProvider<GitHub>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

