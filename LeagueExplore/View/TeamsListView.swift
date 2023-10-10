//
//  TeamsListView.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import SwiftUI

/// Représente une vue pour afficher une liste d'équipes.
struct TeamsListView: View {
    @Binding var teams: [Team]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    // Affiche les équipes dans une grille, en utilisant TeamCardView pour chaque équipe.
                    ForEach(teams, id: \.idTeam) { team in
                        TeamCardView(team: team)
                    }
                }
                .padding()
            }
        }
    }
}

/// Représente une vue pour afficher les détails d'une équipe.
struct TeamCardView: View {
    
    @State private var isDetailViewPresented = false
    
    var team: Team
    
    var body: some View {
        Button(action: {
            // Affiche la vue de détail lorsqu'on appuie sur le bouton.
            isDetailViewPresented.toggle()
        }) {
            VStack {
                // Affiche le logo de l'équipe à partir de l'URL.
                RemoteImage(url: team.strTeamBadge)
                    .frame(height: 100)
                    .clipped()
                    .cornerRadius(10)
            }
        }
        // Affiche la vue de détail en tant que feuille modale lorsqu'elle est activée.
        .sheet(isPresented: $isDetailViewPresented) {
            TeamDetailView(team: team)
        }
    }
}

/// Prévisualisation de TeamsListView avec des données factices.
struct TeamsListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsListView(teams: Binding.constant([Team.dummyData]))
    }
}
