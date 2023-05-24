//
//  SummaryScreen.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 22/05/23.
//

import SwiftUI
import HealthKit

struct ActivityRings: View {
    
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    var body: some View {
        HStack {
            ActivityRingsView(
                healthStore: healthKitManager.healthStore
            ).frame(width: 90, height: 90)
            
            VStack(alignment: .leading) {
                Text("\(healthKitManager.energyBurnedValue) Kcal")
                .bold()
                .font(.system(.body, design: .rounded))
                .foregroundColor(.red)
                .privacySensitive()
                Divider()
                
                Text("\(healthKitManager.exercisevalue) Min")
                    .bold()
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.green)
                    .privacySensitive()
                Divider()
                
                Text("\(healthKitManager.standValue) Hour")
                    .bold()
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.blue)
                    .privacySensitive()
            }
        }
        .navigationTitle{
            Text("Activity")
                .bold()
                .colorMultiply(Color(red: 255 / 255, green: 153 / 255, blue: 153 / 255))
                .offset(x: -20)
        }
        .onAppear() {
            healthKitManager.startEnergyQuery(quantityTypeIdentifier: .activeEnergyBurned)
            healthKitManager.startExerciseQuery(quantityTypeIdentifier: .appleExerciseTime)
            healthKitManager.startStandQuery(quantityTypeIdentifier: .appleStandTime)
        }
    }
}

struct ActivityRings_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRings()
    }
}
