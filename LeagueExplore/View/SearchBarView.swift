//
//  SearchBarView.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var leagues: [League]
    @Binding var selectedLeague: League?
    @Binding var isSearchBarEditing: Bool
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            // Barre de recherche
            TextField("Rechercher une ligue", text: $searchText, onEditingChanged: { editing in
                isSearchBarEditing = editing
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            // Affiche les suggestions uniquement pendant l'édition et lorsque le texte n'est pas vide
            if isSearchBarEditing {
                List {
                    ForEach(filteredLeagues, id: \.idLeague) { league in
                        Button(action: {
                            selectedLeague = league
                            searchText = league.strLeague
                            isSearchBarEditing = false
                            hideKeyboard()
                        }) {
                            Text(league.strLeague)
                        }
                    }
                }
            }
        }
    }
    
    // Filtre les ligues en fonction du texte de recherche
    private var filteredLeagues: [League] {
        if searchText.isEmpty {
            return leagues
        } else {
            return leagues.filter { $0.strLeague.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // Masque le clavier
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        // Exemple de prévisualisation avec différentes suggestions de ligues
        SearchBarView(leagues: Binding.constant([League.dummyData]), selectedLeague: Binding.constant(nil), isSearchBarEditing: Binding.constant(true))
    }
}
