//
//  MainView.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var teamsViewModel: TeamsViewModel
    @StateObject var leaguesViewModel: LeaguesViewModel

    @State var isSearchBarEditing = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {

                    // Barre de recherche avec suggestions de ligues
                    SearchBarView(leagues: $leaguesViewModel.leagues, selectedLeague: $leaguesViewModel.selectedLeague, isSearchBarEditing: $isSearchBarEditing)
                        .padding()

                    // Liste des équipes de la ligue sélectionnée
                    if let selectedLeague = leaguesViewModel.selectedLeague, !isSearchBarEditing{
                        TeamsListView(teams: $teamsViewModel.teams)
                            .onAppear {
                                teamsViewModel.fetchTeams(for: selectedLeague)
                            }
                    } else {
                        Text("Sélectionnez une ligue pour afficher les équipes.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                    Spacer()
                }
                if teamsViewModel.isLoading || leaguesViewModel.isLoading {
                    ProgressView()
                }
            }.alert(isPresented: $teamsViewModel.showErrorAlert) {
                Alert(title: Text("Erreur"), message: Text(teamsViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }.alert(isPresented: $leaguesViewModel.showErrorAlert) {
                Alert(title: Text("Erreur"), message: Text(leaguesViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("Équipes")
        }

    }
}

#Preview {
    MainView(teamsViewModel: TeamsViewModel(teamService: TeamService()), leaguesViewModel: LeaguesViewModel(leagueService: LeagueService()))
}
