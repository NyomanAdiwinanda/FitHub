//
//  HeartAnimationView.swift
//  FitHub Watch App
//
//  Created by Nyoman Adiwinanda on 23/05/23.
//

import SwiftUI

struct HeartAnimationView: View {
    
    @State private var measuring = false
    let blue = Color(#colorLiteral(red: 0, green: 0.3725490196, blue: 1, alpha: 1))
    let red = Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
    
    var body: some View {
        HStack {
            HeartIcon()
                .stroke(style:
                            StrokeStyle(lineWidth: 5,
                                        lineCap: .round,
                                        lineJoin: .round,
                                        miterLimit: 0,
                                        dash: [150, 15],
                                        dashPhase: measuring ? -83 : 83)
                )
                .foregroundStyle(
                    .angularGradient(
                        colors: [blue, red, blue],
                        center: .center,
                        startAngle: .degrees(measuring ? 360 : 0),
                        endAngle: .degrees(measuring ? 720 : 360)
                    )
                )
                .frame(width: 64, height: 64)
        }
        .onAppear() {
            if !measuring {
                withAnimation(.linear(duration: 2.5)
                    .repeatForever(autoreverses: false)) {
                        measuring = true
                    }                
            }
        }
    }
}

struct HeartAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        HeartAnimationView()
    }
}
