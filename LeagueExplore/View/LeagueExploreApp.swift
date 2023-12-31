//
//  LeagueExploreApp.swift
//  LeagueExplore
//
//  Created by narfk on 10/10/2023.
//

import SwiftUI

@main
struct LeagueExploreApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(teamsViewModel: TeamsViewModel(teamService: TeamService()), leaguesViewModel: LeaguesViewModel(leagueService: LeagueService()))
        }
    }
}
