//
//  StepScreen.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 24/05/23.
//

import SwiftUI
import HealthKit

struct StepScreen: View {
    
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    var body: some View {
        VStack {
            Image(systemName: "figure.walk")
                .foregroundColor(.purple)
                .font(Font.custom("Wind", size: CGFloat(60)))
                .padding()
            
            VStack {
                Text("\(healthKitManager.stepsValue)")
                    .bold()
                    .font(.system(.title2, design: .rounded))
                    .padding(.bottom, 1)
                    .privacySensitive()
                
                Text("Today total steps")
                    .bold()
                    .font(.system(.body, design: .rounded))
            }
        }
        .onAppear() {
            healthKitManager.startStepQuery(quantityTypeIdentifier: .stepCount)
        }
        .navigationTitle{
            Text("Steps")
                .bold()
                .colorMultiply(Color.purple)
                .offset(x: -20)
        }
    }
}

struct StepScreen_Previews: PreviewProvider {
    static var previews: some View {
        StepScreen()
    }
}
