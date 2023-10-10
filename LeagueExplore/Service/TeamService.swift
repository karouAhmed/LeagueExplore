//
//  TeamService.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//


import Foundation
import Combine

/// Protocole pour définir les services d'équipe.
protocol TeamServiceProtocol {
    /// Récupère les équipes pour une ligue spécifiée depuis l'API.
    /// - Parameter leagueName: Nom de la ligue pour laquelle récupérer les équipes.
    /// - Returns: Un éditeur de combinaison (Combine) contenant la liste des équipes ou une erreur API.
    func fetchTeams(leagueName: String) -> AnyPublisher<[Team], APIError>
}

/// Service pour récupérer les données des équipes depuis l'API.
class TeamService: TeamServiceProtocol {

    /// Ensemble des abonnements pour la gestion des tâches asynchrones.
    private var cancellables: Set<AnyCancellable> = []

    /// Récupère les équipes pour une ligue spécifiée depuis l'API.
    /// - Parameter leagueName: Nom de la ligue pour laquelle récupérer les équipes.
    /// - Returns: Un éditeur de combinaison (Combine) contenant la liste des équipes ou une erreur API.
    func fetchTeams(leagueName: String) -> AnyPublisher<[Team], APIError> {
        // Vérifie si l'URL est valide, sinon retourne une erreur de mauvaise URL.
        guard let url = URL(string: URLEndpoint.teamsByLeague(leagueName: leagueName).rawValue.replacingOccurrences(of: " ", with: "%20")) else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }

        // Effectue une tâche de publication de données à partir de l'URL.
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
        // Gère les erreurs réseau, y compris les erreurs de connexion et d'URL.
            .mapError { error in
                switch error {
                case URLError.badURL:
                    return APIError.badURL
                case URLError.cannotConnectToHost, URLError.notConnectedToInternet:
                    return APIError.noInternetConnection
                default:
                    return APIError.unknown
                }
            }
        // Transforme les données en un éditeur de combinaison contenant les équipes ou une erreur de décodage.
            .flatMap { data, response -> AnyPublisher<[Team], APIError> in
                // Vérifie le code de statut de la réponse.
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }

                // Si le code de statut est entre 200 et 299, décode les données en équipes.
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: TeamApiResponse.self, decoder: JSONDecoder())
                        .map(\.teams)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    // Si le code de statut est différent, retourne une erreur d'API avec le code d'erreur.
                    return Fail(error: .errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

