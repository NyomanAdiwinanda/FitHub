//
//  FitHubApp.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 22/05/23.
//

import SwiftUI

@available(watchOS, deprecated: 9.0)
@main
struct MyWorkouts_Watch_AppApp: App {
    @StateObject var workoutManager = HealthKitManager()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView, content: {
                SummaryView()
            })
            .environmentObject(workoutManager)
        }
    }
}
