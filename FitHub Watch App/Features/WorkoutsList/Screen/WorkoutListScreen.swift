//
//  WorkoutListScreen.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 22/05/23.
//

import SwiftUI
import HealthKit

@available(watchOS, deprecated: 9.0)
struct WorkoutListScreen: View {
    
    @EnvironmentObject var workoutManager: HealthKitManager
    var workoutTypes: [HKWorkoutActivityType] = [.running, .cycling, .walking, .yoga, .hiking, .climbing, .soccer, .basketball, .badminton, .tennis, .bowling, .other]
    
    var body: some View {
        List(workoutTypes) { workoutType in
            NavigationLink(
                workoutType.name,
                destination: SessionPagingView(),
                tag: workoutType,
                selection: $workoutManager.selectedWorkout
            )
        }
        .listStyle(.carousel)
        .navigationTitle{
            Text("Workouts")
                .bold()
                .colorMultiply(Color(red: 255 / 255, green: 195 / 255, blue: 0 / 255))
                .offset(x: -20)
        }
        //        NavigationLink(workoutType.name, value: workoutType)
        //            .navigationDestination(for: HKWorkoutActivityType.self) { workoutType in
        //                SessionPagingView()
        //            }
    }
}

@available(watchOS, deprecated: 9.0)
struct WorkoutListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListScreen()
    }
}

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }
    
    var name: String {
        switch self {
        case .running:
            return "Run"
        case .walking:
            return "Walk"
        case .cycling:
            return "Cycling"
        case .yoga:
            return "Yoga"
        case .hiking:
            return "Hiking"
        case .climbing:
            return "Climbing"
        case .soccer:
            return "Soccer"
        case .basketball:
            return "Basketball"
        case .badminton:
            return "Badminton"
        case .tennis:
            return "Tennis"
        case .bowling:
            return "Bowling"
        case .other:
            return "Other"
        default:
            return ""
        }
    }
}
