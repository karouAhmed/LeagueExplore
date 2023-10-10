//
//  LeagueViewModelTests.swift
//  LeagueExploreTests
//
//  Created by narfk on 10/10/2023.
//

import XCTest
@testable import LeagueExplore
import Combine

final class LeagueViewModelTests: XCTestCase {

    var viewModel: LeaguesViewModel!
    var mockLeagueService: MockLeagueService!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockLeagueService = MockLeagueService()
        viewModel = LeaguesViewModel(leagueService: mockLeagueService)
    }

    func testFetchLeaguesSuccess() {
        // Arrange
        let expectedLeagues: [League] = [League.dummyData]
        mockLeagueService.stubbedLeagues = Just(expectedLeagues)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()

        // Act
        viewModel.fetchLeagues()

        // Assert
        let expectation = XCTestExpectation(description: "Attente de la mise à jour de la liste des ligues.")
        viewModel.$leagues
            .sink(receiveValue: { leagues in
                XCTAssertTrue(!self.viewModel.isLoading)
                XCTAssertEqual(leagues, expectedLeagues, "La liste des ligues doit correspondre aux données simulées.")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchLeaguesFailure() {
        // Arrange
        let expectedError: APIError = .unknown
        mockLeagueService.stubbedLeagues = Fail(error: expectedError)
            .eraseToAnyPublisher()

        // Act
        viewModel.fetchLeagues()

        // Assert
        let expectation = XCTestExpectation(description: "Attente de la gestion de l'erreur.")
        viewModel.$leagues
            .sink(receiveValue: { leagues in
                XCTAssertTrue(leagues.isEmpty, "La liste des ligues doit être vide en cas d'erreur.")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFilteredLeagues() {
        // Arrange
        let leagues: [League] = [League.dummyData]
        viewModel.leagues = leagues

        // Act
        let filteredLeagues = viewModel.filteredLeagues(searchText: "Liga")

        // Assert
        XCTAssertGreaterThanOrEqual(filteredLeagues.count, 1, "La liste filtrée doit contenir une seule ligue.")
        XCTAssertEqual(filteredLeagues.first?.strLeague, "Mexico Liga MX Femenil", "La ligue doit correspondre à celle recherchée.")
    }

}
