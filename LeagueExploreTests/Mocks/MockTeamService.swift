//
//  MockTeamService.swift
//  LeagueExploreTests
//
//  Created by narfk on 10/10/2023.
//
@testable import LeagueExplore
import Combine
import Foundation

class MockTeamService: TeamServiceProtocol {
    var stubbedTeams: AnyPublisher<[Team], APIError> = Empty().eraseToAnyPublisher()

    func fetchTeams(leagueName: String) -> AnyPublisher<[Team], APIError> {
        return stubbedTeams
    }
}
