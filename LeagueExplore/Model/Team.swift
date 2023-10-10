//
//  Team.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import Foundation

// MARK: - TeamApiResponse
/// Structure représentant la réponse de l'API contenant une liste d'équipes.
struct TeamApiResponse: Decodable {
    /// Liste des équipes.
    let teams: [Team]
}

// MARK: - Team
/// Structure représentant une équipe sportive.
struct Team: Decodable, Equatable {
    let idTeam: String
    let strTeam, strLeague, strStadium, strStadiumLocation, strDescriptionEN: String
    let strTeamBadge: String // URL du logo de l'équipe
    
    /// Conformité à Equatable pour permettre la comparaison des instances de Team.
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.idTeam == rhs.idTeam
    }
}

extension Team {
    /// Un exemple de Team utilisé à des fins de test ou de démo.
    static var dummyData: Team {
        .init(
            idTeam: "133738",
            strTeam: "Real Madrid",
            strLeague: "Spanish La Liga",
            strStadium: "Estadio Santiago Bernabéu",
            strStadiumLocation: "Madrid",
            strDescriptionEN: "The Santiago Bernabéu Stadium (Spanish: Estadio Santiago Bernabéu ), is the home stadium of Real Madrid since its completion in 1947, with a current seating capacity of 81,044.\r\n\r\nSantiago Bernabéu is one of the world's most famous and prestigious football venues. It has hosted the European Cup/Champions League final on four occasions: in 1957, 1969, 1980 and 2010. The final matches for the 1964 European Nations' Cup and the 1982 FIFA World Cup, were also held at the Bernabéu, thus making it the first stadium in Europe to host both a UEFA European Championship and a FIFA World Cup final.",
            strTeamBadge: "https://www.thesportsdb.com/images/media/team/badge/vwvwrw1473502969.png")
    }
}
