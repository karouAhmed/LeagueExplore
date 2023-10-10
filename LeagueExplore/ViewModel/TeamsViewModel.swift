//
//  TeamsViewModel.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import Foundation
import Combine

/// ViewModel responsable de la logique métier liée aux équipes.
class TeamsViewModel: ObservableObject {
    /// Liste des équipes de la ligue spécifiée.
    @Published var teams: [Team] = []

    /// Indique si le chargement est en cours.
    @Published var isLoading = false

    /// Indique si une alerte d'erreur doit être affichée.
    @Published var showErrorAlert: Bool = false

    /// Message d'erreur affiché dans l'alerte.
    var errorMessage: String = ""

    /// Gestionnaire des abonnements Combine.
    private var cancellables: Set<AnyCancellable> = []

    /// Service pour récupérer les données des équipes.
    private let teamService: TeamServiceProtocol

    /// Initialise le ViewModel avec le service spécifié.
    /// - Parameter teamService: Service pour récupérer les données des équipes.
    init(teamService: TeamServiceProtocol) {
        self.teamService = teamService
    }

    /// Récupère les équipes pour une ligue donnée.
    /// - Parameter league: Ligue pour laquelle les équipes doivent être récupérées.
    func fetchTeams(for league: League) {
        // Utilisez votre service/API pour récupérer les équipes de la ligue spécifiée
        // Par exemple, si vous avez une fonction dans votre service appelée fetchTeams(for:),
        // vous pouvez l'appeler ici et mettre à jour la propriété teams avec le résultat.
        self.isLoading = true
        teamService.fetchTeams(leagueName: league.strLeague)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                // Gérez les erreurs de l'éditeur Combine ici, si nécessaire
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.showErrorAlert = true
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self]  teams in
                guard let self = self else { return }
                // Filtrer les équipes pour n'afficher qu'une équipe sur 2 et trier par ordre anti-alphabétique
                let filteredTeams = teams.enumerated().compactMap { (index, team) in
                    return index % 2 == 0 ? team : nil
                }.sorted { $0.strTeam > $1.strTeam }

                // Mettez à jour la propriété teams avec les équipes filtrées et triées
                self.teams = filteredTeams
            })
            .store(in: &cancellables)
    }
}
