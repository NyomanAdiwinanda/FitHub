//
//  ContentView.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 22/05/23.
//

import SwiftUI

@available(watchOS, deprecated: 9.0)
struct ContentView: View {
    
    @EnvironmentObject var workoutManager: HealthKitManager
    @State private var features: Tab = .summary
    
    enum Tab {
        case summary, heartBeat, step, workout, breath
    }
    
    var body: some View {
        TabView(selection: $features, content: {
            ActivityRings().tag(Tab.summary)
            HeartBeatScreen().tag(Tab.heartBeat)
            StepScreen().tag(Tab.step)
            WorkoutListScreen().tag(Tab.workout)
            BreathScreen().tag(Tab.breath)
        })
        .tabViewStyle(PageTabViewStyle())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            workoutManager.requestAuthorization()
        }
    }
}

@available(watchOS, deprecated: 9.0)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
