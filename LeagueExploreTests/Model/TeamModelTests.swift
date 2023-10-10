//
//  TeamModelTests.swift
//  LeagueExploreTests
//
//  Created by narfk on 10/10/2023.
//

import XCTest
@testable import LeagueExplore

final class TeamModelTests: XCTestCase {

    func testTeamInitialization() {
          let team = Team(idTeam: "456", strTeam: "Manchester United", strLeague: "Premier League", strStadium: "Old Trafford", strStadiumLocation: "Manchester", strDescriptionEN: "Description de l'équipe", strTeamBadge: "https://example.com/logo.png")

          XCTAssertEqual(team.idTeam, "456", "L'ID de l'équipe doit correspondre à la valeur d'initialisation.")
          XCTAssertEqual(team.strTeam, "Manchester United", "Le nom de l'équipe doit correspondre à la valeur d'initialisation.")
          XCTAssertEqual(team.strLeague, "Premier League", "Le nom de la ligue de l'équipe doit correspondre à la valeur d'initialisation.")
          XCTAssertEqual(team.strStadium, "Old Trafford", "Le nom du stade de l'équipe doit correspondre à la valeur d'initialisation.")
          XCTAssertEqual(team.strStadiumLocation, "Manchester", "La localisation du stade de l'équipe doit correspondre à la valeur d'initialisation.")
          XCTAssertEqual(team.strDescriptionEN, "Description de l'équipe", "La description de l'équipe doit correspondre à la valeur d'initialisation.")
          XCTAssertEqual(team.strTeamBadge, "https://example.com/logo.png", "L'URL du logo de l'équipe doit correspondre à la valeur d'initialisation.")
      }

    func testTeamEquality() {
          let team1 = Team(idTeam: "456", strTeam: "Manchester United", strLeague: "Premier League", strStadium: "Old Trafford", strStadiumLocation: "Manchester", strDescriptionEN: "Description de l'équipe", strTeamBadge: "https://example.com/logo.png")
          let team2 = Team(idTeam: "456", strTeam: "Manchester United", strLeague: "Premier League", strStadium: "Old Trafford", strStadiumLocation: "Manchester", strDescriptionEN: "Description de l'équipe", strTeamBadge: "https://example.com/logo.png")
          let team3 = Team(idTeam: "789", strTeam: "Real Madrid", strLeague: "La Liga", strStadium: "Santiago Bernabeu", strStadiumLocation: "Madrid", strDescriptionEN: "Description de l'équipe", strTeamBadge: "https://example.com/logo.png")

          XCTAssertEqual(team1, team2, "Deux instances de Team avec les mêmes valeurs doivent être égales.")
          XCTAssertNotEqual(team1, team3, "Deux instances de Team avec des valeurs différentes ne doivent pas être égales.")
      }

}
