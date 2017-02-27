//
//  GitHubAPITests.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 27/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import XCTest
import Nimble
import Quick
import Moya

@testable
import GitHub_Client
import Pods_GitHub_Client


class GitHubAPITests: QuickSpec {
    
    
    override func spec() {
        describe("getPublicList") {
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
    }
    
    
}
