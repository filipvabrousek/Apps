//
//  ContentView.swift
//  AnimTest
//
//  Created by Filip Vabroušek on 31/10/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var colora: Color = .green
    @State var colorb: Color = .green
    @State var size: CGFloat = 60.0
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(0x81ecec))
                .frame(width: size, height: size)
                .scaleEffect(isActive ? 3.3 : 1.0)

            Circle()
                .fill(Color(0x7ed6df))
                .frame(width: size, height: size)
                .scaleEffect(isActive ? 2.3 : 1.0)

            Circle()
                .fill(Color(0xffffff))
                .frame(width: size, height: size)
                .scaleEffect(isActive ? 1.3 : 1.0)
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.isActive.toggle()
                }
            }
        }
    }
}


/*
 
 
 
 
LAYOUT SYSTEM
1) Parent proposes sizes for a child (entire View
2) Child chooses its own size, parent has to respect this
3) child places itself into its own coordinate space
 */





// 3 Steps, spacing layout
struct SpaceView: View {
    var body: some View {
        HStack(spacing: 10) {

            /*
             Frame: if it is bigger than content, it acts as padding, if smaller, it does nothing
             works only with resizable()
             layoutPriority - allows content to be stretched
             */

            Image("logo")
            // .resizable() // Allows to stretch for full framee
            .frame(width: 40, height: 40) // i
            .colorInvert()

            Text("More and more text")
                .bold()

            Text("More than more text in there which won't fit because of frame in preview")
                .bold()
            //.layoutPriority(1) MAKES SPACE

            /* A stack offers the children with the highest priority all the space offered to it minus the space required for all its lower-priority children.
             */

        }
    }
}





struct Morph: View {
    @State var enabled = false

    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 70, height: 70)
                .cornerRadius(enabled ? 100.0 : 0.0)

            Button("Morph") {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.enabled.toggle()
                }
            }

        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Morph()
        
       /* SpaceView()
            .border(Color.black)
            .padding()
            .frame(width: 300, height: 130) */
       
    }
}


extension Color {
    init(_ hex: UInt32, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
