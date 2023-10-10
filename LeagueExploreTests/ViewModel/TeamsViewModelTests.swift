//
//  TeamsViewModelTests.swift
//  LeagueExploreTests
//
//  Created by narfk on 10/10/2023.
//

import XCTest
@testable import LeagueExplore
import Combine

final class TeamsViewModelTests: XCTestCase {
    
    var viewModel: TeamsViewModel!
    var mockTeamService: MockTeamService!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockTeamService = MockTeamService()
        viewModel = TeamsViewModel(teamService: mockTeamService)
    }

    func testFetchTeamsSuccess() {

        let expectedTeams: [Team] = [Team.dummyData]
        mockTeamService.stubbedTeams = Just(expectedTeams)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()

        // Act
        viewModel.fetchTeams(for: League.dummyData)

        // Assert
        let expectation = XCTestExpectation(description: "Attente de la mise à jour de la liste des équipes.")
        viewModel.$teams
            .sink(receiveValue: { teams in
                XCTAssertTrue(!self.viewModel.isLoading)
                XCTAssertEqual(teams, expectedTeams, "La liste des équipes doit correspondre aux données simulées.")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchTeamsFailure() {
        // Arrange
        let expectedError: APIError = .unknown
        mockTeamService.stubbedTeams = Fail(error: expectedError)
            .eraseToAnyPublisher()

        // Act
        viewModel.fetchTeams(for: League.dummyData)

        // Assert
        let expectation = XCTestExpectation(description: "Attente de la gestion de l'erreur.")
        viewModel.$teams
            .sink(receiveValue: { teams in
                XCTAssertTrue(!self.viewModel.isLoading)
                XCTAssertTrue(teams.isEmpty, "La liste des équipes doit être vide en cas d'erreur.")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
