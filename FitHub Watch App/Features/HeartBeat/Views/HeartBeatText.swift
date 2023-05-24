//
//  HeartBeatText.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 23/05/23.
//

import SwiftUI
import HealthKit

struct HeartBeatText: View {
    
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    var body: some View {
        HStack {
            Text("\(healthKitManager.heartRateValue) BPM")
                .bold()
                .font(.system(.title, design: .rounded))
                .padding()
                .privacySensitive()
        }
        .onAppear() {
            healthKitManager.startHeartRateQuery(quantityTypeIdentifier: .heartRate)
        }
    }
}

struct HeartBeatText_Previews: PreviewProvider {
    static var previews: some View {
        HeartBeatText()
    }
}
