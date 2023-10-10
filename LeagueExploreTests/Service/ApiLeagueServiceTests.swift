//
//  ApiLeagueServiceTests.swift
//  LeagueExploreTests
//
//  Created by narfk on 10/10/2023.
//

import XCTest
import Combine
@testable import LeagueExplore

final class ApiLeagueServiceTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    func testFetchLeagues() {
        let expectation = XCTestExpectation(description: "API Request")
        let apiService = LeagueService()

        apiService.fetchLeagues()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Erreur lors de l'appel de l'API : \(error)")
                }
            }, receiveValue: { leagues in
                // Effectuez des assertions sur les données des ligues reçues
                XCTAssertFalse(leagues.isEmpty, "La liste des ligues ne doit pas être vide.")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchLeaguesWithErrorDecoding() {
        // Arrange
        let expectation = XCTestExpectation(description: "API Request")
        let mockLeagueService = MockLeagueService()
        mockLeagueService.stubbedLeagues = Fail(error: APIError.decodingError)
            .eraseToAnyPublisher()

        // Act
        mockLeagueService.fetchLeagues()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Assert
                    XCTAssertEqual(error, APIError.decodingError, "L'erreur doit être une erreur de décodage.")
                    expectation.fulfill()
                }
            }, receiveValue: { teams in
                XCTFail("La réception des équipes ne doit pas être appelée en cas d'erreur.")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }
}
