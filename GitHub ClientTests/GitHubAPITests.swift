//
//  GitHubAPITests.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 27/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//
// As an improvement, I know I need to test searialization. I find out that the library Mapper is not well tested for X86-64. 
// I am just testing conectivity and responses in time. This libraries where not that great for testing.
//

import XCTest
import Nimble
import Quick
import Moya

@testable
import GitHub_Client
import Pods_GitHub_Client


class GitHubAPITests: QuickSpec {
    
    let TEST_REPO = "/jquery/jquery"
    
    override func spec() {
        describe("listRepositories") {
            it("fristPage") {

                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.listRepositories(0)) { result in
                        
                        if case let .success(response) = result {
                                expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
            
            it("moreitems") {
                
                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.listRepositories(5000)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
        }
        
        describe("searchRepositories") {
            it("fristPage") {
                
                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.searchRepositories("jquery",0)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
            
            it("secondPage") {
                
                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.searchRepositories("jquery",1)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                }
            }
        }
        
        
        describe("repoProfile") {
            it("get repoProfile") {
                // This test takes more time. I dont know if its my internet or the request it self
                waitUntil(timeout: 5) { done in
                    
                    GitHubProvider.request(.repoProfile(self.TEST_REPO)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
        }
        
        describe("repoCommits") {
            it("get repoCommits") {
                
                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.repoCommits(self.TEST_REPO)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
        }
        
        describe("repoIssues") {
            it("get repoIssues") {
                
                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.repoIssues(self.TEST_REPO)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
        }
        
        describe("repoContributors") {
            it("get repoContributors") {
                
                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.repoContributors(self.TEST_REPO)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
        }
        
        describe("repoBranches") {
            it("get repoBranches") {
                
                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.repoBranches(self.TEST_REPO)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
        }
        
        
        describe("repoPulls") {
            it("get repoPulls") {
                
                waitUntil(timeout: 2) { done in
                    
                    GitHubProvider.request(.repoPulls(self.TEST_REPO)) { result in
                        
                        if case let .success(response) = result {
                            expect(response.data).notTo(beNil())
                        }
                        done()
                    }
                    
                }
            }
        }
    }
    
    
}
