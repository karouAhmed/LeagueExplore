//
//  LeagueService.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import Foundation
import Combine
import Foundation
import Combine

/// Protocole pour définir les services de ligue.
protocol LeagueServiceProtocol {
    /// Récupère la liste des ligues depuis l'API.
    /// - Returns: Un éditeur de combinaison (Combine) contenant la liste des ligues ou une erreur API.
    func fetchLeagues() -> AnyPublisher<[League], APIError>
}

/// Service pour récupérer les données des ligues depuis l'API.
class LeagueService: LeagueServiceProtocol {
    
    /// Ensemble des abonnements pour la gestion des tâches asynchrones.
    private var cancellables: Set<AnyCancellable> = []
    
    /// Récupère la liste des ligues depuis l'API.
    /// - Returns: Un éditeur de combinaison (Combine) contenant la liste des ligues ou une erreur API.
    func fetchLeagues() -> AnyPublisher<[League], APIError> {
        // Vérifie si l'URL est valide, sinon retourne une erreur de mauvaise URL.
        guard let url = URL(string: URLEndpoint.leagues.rawValue) else {
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
        // Transforme les données en un éditeur de combinaison contenant les ligues ou une erreur de décodage.
            .flatMap { data, response -> AnyPublisher<[League], APIError> in
                // Vérifie le code de statut de la réponse.
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }
                
                // Si le code de statut est entre 200 et 299, décode les données en ligues.
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: LeagueApiResponse.self, decoder: JSONDecoder())
                        .map(\.leagues)
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



