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
    case repoContributors(String)
    case repoIssues(String)
    case repoPulls(String)

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
        case .repoIssues(let full_name):
            return "/repos/\(full_name)/issues"
        case .repoContributors(let full_name):
            return "/repos/\(full_name)/contributors"
        case .repoBranches(let full_name):
            return "/repos/\(full_name)/branches"
        case .repoPulls(let full_name):
            return "/repos/\(full_name)/pulls"
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
        case .repoPulls(_):
            return ["state" : "open" ]
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
            return "{\"items\" : [{\"id\":1  \"name\" : \"grit\"}] }".data(using: String.Encoding.utf8)!
        case .repoProfile:
             return "{\"name\": \"Repo Name\"}".data(using: String.Encoding.utf8)!
        case .repoBranches:
            return "[{\"name\": \"1.12-stable\",\"commit\": {    \"sha\": \"e09907ce152fb6ef7537a3733b1d65ead8ee6303\",    \"url\": \"https://api.github.com/repos/jquery/jquery/commits/e09907ce152fb6ef7537a3733b1d65ead8ee6303\"}}]".data(using: String.Encoding.utf8)!
        case .repoContributors:
            return "[{ \"login\": \"jeresig\",\"id\": 1615,\"avatar_url\": \"https://avatars.githubusercontent.com/u/1615?v=3\",\"gravatar_id\": \"\",\"url\": \"https://api.github.com/users/jeresig\",\"html_url\": \"https://github.com/jeresig\",\"followers_url\": \"https://api.github.com/users/jeresig/followers\",\"following_url\": \"https://api.github.com/users/jeresig/following{/other_user}\",\"gists_url\": \"https://api.github.com/users/jeresig/gists{/gist_id}\",\"starred_url\": \"https://api.github.com/users/jeresig/starred{/owner}{/repo}\",\"subscriptions_url\": \"https://api.github.com/users/jeresig/subscriptions\",\"organizations_url\": \"https://api.github.com/users/jeresig/orgs\",\"repos_url\": \"https://api.github.com/users/jeresig/repos\",\"events_url\": \"https://api.github.com/users/jeresig/events{/privacy}\",\"received_events_url\": \"https://api.github.com/users/jeresig/received_events\",\"type\": \"User\",\"site_admin\": false,\"contributions\": 1714}]".data(using: String.Encoding.utf8)!
        case .repoIssues:
            return "[{\"url\":\"https://api.github.com/repos/jquery/jquery/issues/3550\"  \"user\" :{} \"body\": \"\"}]".data(using: String.Encoding.utf8)!
        case .repoCommits:
            return "[{\"sha\": \"bd984f0ee2cf40107a669d80d92566b8625b1e6b\", \"commit\": {\"message\": \"Core: Move holdReady to deprecated\n\nFixes gh-3288\nClose gh-3306\",\"tree\": {\"sha\": \"4b521d06ca43061369bcf9652e3e7fe8f28784f0\",}, \"url\": \"https://api.github.com/repos/jquery/jquery/git/commits/bd984f0ee2cf40107a669d80d92566b8625b1e6b\",\"comment_count\": 0}, \"url\": \"https://api.github.com/repos/jquery/jquery/commits/bd984f0ee2cf40107a669d80d92566b8625b1e6b\"}]".data(using: String.Encoding.utf8)!
        case .repoPulls:
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

let GitHubProvider = MoyaProvider<GitHub>(plugins: [NetworkLoggerPlugin(verbose: false, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

