//
//  TeamDetailView.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import Foundation
import SwiftUI

struct TeamDetailView: View {
    var team: Team

    var body: some View {
        ScrollView {
            VStack {
                // Affichez les détails de l'équipe ici
                RemoteImage(url: team.strTeamBadge) // Utilisez une vue ou une méthode pour afficher l'image depuis l'URL

                Text("Nom de l'équipe: \(team.strTeam)")
                    .padding()

                Text("Ligue: \(team.strLeague)")
                    .padding()

                Text("Stade: \(team.strStadium)")
                    .padding()

                Text("Emplacement du stade: \(team.strStadiumLocation)")
                    .padding()

                Text("Description: \(team.strDescriptionEN)")
                    .padding()

                // Ajoutez d'autres détails de l'équipe selon vos besoins
            }
            .navigationTitle("Détails de l'équipe \(team.strTeam)")
        }
    }
}
#Preview {
    TeamDetailView(team: Team.dummyData)
}
