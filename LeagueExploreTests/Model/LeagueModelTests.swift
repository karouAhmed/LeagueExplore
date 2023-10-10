//
//  LeagueModelTests.swift
//  LeagueExploreTests
//
//  Created by narfk on 10/10/2023.
//

import XCTest
@testable import LeagueExplore

final class LeagueModelTests: XCTestCase {
    
    func testLeagueInitialization() {
        let league = League(idLeague: "123", strLeague: "Premier League", strSport: "Soccer")
        
        XCTAssertEqual(league.idLeague, "123", "L'ID de la ligue doit correspondre à la valeur d'initialisation.")
        XCTAssertEqual(league.strLeague, "Premier League", "Le nom de la ligue doit correspondre à la valeur d'initialisation.")
        XCTAssertEqual(league.strSport, "Soccer", "Le sport de la ligue doit correspondre à la valeur d'initialisation.")
    }
    
    func testLeagueEquality() {
        let league1 = League(idLeague: "123", strLeague: "Premier League", strSport: "Soccer")
        let league2 = League(idLeague: "123", strLeague: "Premier League", strSport: "Soccer")
        let league3 = League(idLeague: "456", strLeague: "La Liga", strSport: "Soccer")
        
        XCTAssertEqual(league1, league2, "Deux instances de League avec les mêmes valeurs doivent être égales.")
        XCTAssertNotEqual(league1, league3, "Deux instances de League avec des valeurs différentes ne doivent pas être égales.")
    }
    
}
