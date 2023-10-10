//
//  Endpoint.swift
//  NewsApp
//
//  Created by narfk on 05/10/2023.
//

import Foundation

/// Chemin de base de l'URL pour l'API.
private let kBaseURLPath: String = "https://www.thesportsdb.com/api/v1/json/\(Constants.apiKey)"


/// Enumération représentant les différents points de terminaison de l'API.
enum URLEndpoint: RawRepresentable {

    
    typealias RawValue = String

    case leagues
    case teamsByLeague(leagueName: String)

    init?(rawValue: RawValue) {
        fatalError()
    }

    var rawValue: String {
        switch self {
        case .leagues:
            return kBaseURLPath + "/all_leagues.php"
        case .teamsByLeague(leagueName: let leagueName):
            return kBaseURLPath + "/search_all_teams.php?l=\(leagueName)"

        }
    }
}


