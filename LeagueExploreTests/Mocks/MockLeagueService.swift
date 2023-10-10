//
//  MockLeagueService.swift
//  LeagueExploreTests
//
//  Created by narfk on 10/10/2023.
//

@testable import LeagueExplore
import Combine
import Foundation

class MockLeagueService: LeagueServiceProtocol {
    var stubbedLeagues: AnyPublisher<[League], APIError> = Empty().eraseToAnyPublisher()

    func fetchLeagues() -> AnyPublisher<[LeagueExplore.League], LeagueExplore.APIError> {
        return stubbedLeagues
    }
    
}
