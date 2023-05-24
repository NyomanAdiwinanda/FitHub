//
//  HeartBeatScreen.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 22/05/23.
//

import SwiftUI

struct HeartBeatScreen: View {
    var body: some View {
        VStack {
            Spacer()
            HeartAnimationView()
            HeartBeatText()
            Spacer()
        }
        .navigationTitle{
            Text("Heart Rate")
                .bold()
                .colorMultiply(Color(red: 255 / 255, green: 36 / 255, blue: 0 / 255))
                .offset(x: -20)
        }
    }
}

struct HeartBeatScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeartBeatScreen()
    }
}
