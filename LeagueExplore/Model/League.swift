//
//  League.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import Foundation

// MARK: - LeagueApiResponse
/// Structure représentant la réponse de l'API contenant une liste de ligues.
struct LeagueApiResponse: Codable {
    /// Liste des ligues.
    let leagues: [League]
}

// MARK: - League
/// Structure représentant une ligue sportive.
struct League: Codable, Equatable{
    /// Identifiant unique de la ligue.
    let idLeague: String
    
    /// Nom de la ligue.
    let strLeague: String
    
    /// Sport associé à la ligue.
    let strSport: String
}

extension League {
    /// Un exemple de League utilisé à des fins de test ou de démo.
    static var dummyData: League {
        .init(
            idLeague: "5206",
            strLeague: "Mexico Liga MX Femenil",
            strSport: "Soccer"
        )
    }
}

