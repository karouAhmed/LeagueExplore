//
//  LeagueSearchViewModel.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import Foundation
import Combine

/// ViewModel responsable de la logique métier liée aux ligues.
class LeaguesViewModel: ObservableObject {
    /// Liste des ligues disponibles.
    @Published var leagues: [League] = []
    
    /// Ligue sélectionnée par l'utilisateur.
    @Published var selectedLeague: League?
    
    /// Indique si le chargement est en cours.
    @Published var isLoading = false
    
    /// Indique si une alerte d'erreur doit être affichée.
    @Published var showErrorAlert: Bool = false
    
    /// Message d'erreur affiché dans l'alerte.
    var errorMessage: String = ""
    
    /// Gestionnaire des abonnements Combine.
    private var cancellables: Set<AnyCancellable> = []
    
    /// Service pour récupérer les données des ligues.
    private let leagueService: LeagueServiceProtocol
    
    /// Initialise le ViewModel avec le service spécifié et récupère les ligues au démarrage.
    /// - Parameter leagueService: Service pour récupérer les données des ligues.
    init(leagueService: LeagueServiceProtocol) {
        self.leagueService = leagueService
        self.fetchLeagues()
    }
    
    /// Récupère la liste des ligues depuis le service et met à jour la propriété `leagues`.
    func fetchLeagues() {
        isLoading = true
        leagueService.fetchLeagues()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    isLoading = false
                    break
                case .failure(let error):
                    // Gérez l'erreur ici, par exemple, mettre à jour showErrorAlert et errorMessage
                    self.showErrorAlert = true
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] leagues in
                guard let self = self else { return }
                self.leagues = leagues
            })
            .store(in: &cancellables)
    }
    
    /// Filtrer les ligues en fonction du texte de recherche.
    /// - Parameter searchText: Texte de recherche saisi par l'utilisateur.
    /// - Returns: Liste filtrée des ligues.
    func filteredLeagues(searchText: String) -> [League] {
        if searchText.isEmpty {
            return leagues
        } else {
            return leagues.filter { $0.strLeague.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

