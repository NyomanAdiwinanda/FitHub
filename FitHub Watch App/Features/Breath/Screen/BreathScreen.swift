//
//  BreathScreen.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 22/05/23.
//

import SwiftUI
import HealthKit

struct BreathScreen: View {
    
    @EnvironmentObject var workoutManager: HealthKitManager
    @State var showingBreatheSheet = false
    @State var breathCancel = 0
    @State var scale = false
    @State var rotate  = false
    @State var val = 0
    @State var remaining = 60.0
    
    var body: some View {
        VStack {
            Image(systemName: "wind")
                .foregroundColor(.cyan)
                .font(Font.custom("Wind", size: CGFloat(60)))
                .padding()
            
            Button(action: {self.showingBreatheSheet = true}) {
                Text("Start - 1 Min")
            }
            .fullScreenCover(isPresented: $showingBreatheSheet) {
                breatheView
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                self.breathCancel = 1
                                self.showingBreatheSheet = false
                                self.val = 0
                                WKInterfaceDevice.current().play(.stop)
                            }) {
                                Text("Cancel")
                            }
                        }
                    }
                    .onReceive(Timer.publish(every: 0.01, on: .current, in: .default).autoconnect()) { _ in
                        self.remaining -= 0.01
                        if self.remaining <= 0 {
                            self.breathCancel = 0
                            self.val = 0
                            self.showingBreatheSheet = false
                            WKInterfaceDevice.current().play(.success)
                            self.remaining = 60.0
                        }
                    }
                    .onDisappear() {
                        if breathCancel == 0 {
                            saveMeditation(startDate: Date(), minutes: UInt(1))
                        } else if breathCancel == 1 {
                            print("Cancel")
                        } else {
                            print("Error")
                        }
                    }
            }
        }
        .navigationTitle{
            Text("Breathe")
                .bold()
                .colorMultiply(Color(red: 0 / 255, green: 191 / 255, blue: 255 / 255))
                .offset(x: -20)
        }
    }
    
    var breatheView: some View {
        ZStack {
            Group {
                ZStack {
                    Circle().frame(width: 80, height: 80)
                        .foregroundColor(Color(UIColor.cyan)).offset(y: -42)
                    Circle().frame(width: 80, height: 80)
                        .foregroundColor(Color(UIColor.cyan)).offset(y: 42)
                }
            }
            .opacity(1/3)
            Group {
                ZStack {
                    Circle().frame(width: 80, height: 80)
                        .foregroundColor(Color(UIColor.cyan)).offset(y: -42)
                    Circle().frame(width: 80, height: 80)
                        .foregroundColor(Color(UIColor.cyan)).offset(y: 42)
                }
            }
            .rotationEffect(.degrees(60)).opacity(1/4)
            Group {
                ZStack {
                    Circle().frame(width: 80, height: 80)
                        .foregroundColor(Color(UIColor.cyan)).offset(y: -42)
                    Circle().frame(width: 80, height: 80)
                        .foregroundColor(Color(UIColor.cyan)).offset(y: 42)
                }
            }
            .rotationEffect(.degrees(120)).opacity(1/2)
        }
        .rotationEffect(.degrees(rotate ? 180 : 0))
        .scaleEffect(scale ? 1 : 1/8)
        .animation(.easeInOut.repeatForever(autoreverses: true)
            .speed(1/8), value: val).onAppear() {
                self.rotate.toggle()
                self.scale.toggle()
                self.val = 1
            }
    }
    
    func saveMeditation(startDate:Date, minutes:UInt) {
        let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)
        let mindfulSample = HKCategorySample(type: mindfulType!, value: 0, start: Date.init(timeIntervalSinceNow: -(1*60)), end: Date())
        workoutManager.healthStore.save(mindfulSample) { _, _ in
            self.showingBreatheSheet = false
            self.remaining = 60.0
            self.scale = false
            self.rotate = false
        }
    }
}

struct BreathScreen_Previews: PreviewProvider {
    static var previews: some View {
        BreathScreen()
    }
}
