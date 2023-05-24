//
//  SessionPagingView.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 22/05/23.
//

import SwiftUI
import WatchKit

@available(watchOS, deprecated: 9.0)
struct SessionPagingView: View {
    
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @EnvironmentObject var workoutManager: HealthKitManager
    @State private var selection: Tab = .metrics
    
    enum Tab {
        case controls, metrics, nowPlaying
    }
    
    var body: some View {
        TabView(selection: $selection, content: {
            if ((workoutManager.selectedWorkout?.name) != nil) {
                ControlsView().tag(Tab.controls)
                MetricsView().tag(Tab.metrics)
                NowPlayingView().tag(Tab.nowPlaying)
            } else {
                VStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.cyan)
                        .padding(.bottom, 10)
                    
                    Text("Your workout has been saved")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    Text("Open \"Fitness\" App on your iPhone to see saved workout history")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                    
                    NavigationLink {
                        ContentView()
                    } label: {
                        Text("Understood")
                    }
                }
            }
        })
        .navigationTitle(workoutManager.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selection == .nowPlaying)
        .onChange(of: workoutManager.running, perform: { _ in
            displayMetricView()
        })
        .tabViewStyle(
            PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic)
        )
        .onChange(of: isLuminanceReduced) { _ in
            displayMetricView()
        }
    }
    
    private func displayMetricView() {
        withAnimation{
            selection = .metrics
        }
    }
}

@available(watchOS, deprecated: 9.0)
struct SessionPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView()
    }
}
