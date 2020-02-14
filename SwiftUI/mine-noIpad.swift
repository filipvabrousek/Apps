//
//  ContentView.swift
//  StretchyHeader
//
//  Created by Filip Vabroušek on 14/02/2020.
//  Copyright © 2020 Filip Vabroušek. All rights reserved.
//

import SwiftUI


// https://jetrockets.pro/blog/stretchy-header-in-swiftui

/*
let kTitle = "Stretchy header in SwiftUI"

let kPublishedAt = Date()

let kAuthor = "Author Name"

let kContent = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""

private let kHeaderHeight: CGFloat = 300
*/
struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Header()
                Content()
            }
        }.edgesIgnoringSafeArea(.top)
    }
}



struct TView: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(size: 45))
            .fontWeight(.heavy)
            .foregroundColor(.white)
    }
}


struct Header: View {

    let kImage = "australia"

    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            if geometry.frame(in: .global).minY <= 0 {

                ZStack(alignment: .topLeading) {
                    ZStack {
                        Image(self.kImage).resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width,
                                height: geometry.size.height)
                        TView(text: "Australia")
                    }


                    if (geometry.frame(in: .global).maxY) > 10 {
                        Button("←") {
                            print("Back A")
                            print(geometry.frame(in: .global).maxY)
                        }.offset(y: -geometry.frame(in: .global).minY).padding(40)
                    }


                }





            } else {
                ZStack(alignment: .topLeading) {
                    //  Text("<-")
                    ZStack {
                        Image(self.kImage).resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -geometry.frame(in: .global).minY)
                            .frame(width: geometry.size.width,
                                height: geometry.size.height
                                    + geometry.frame(in: .global).minY)

                        TView(text: "Australia").offset(y: -geometry.frame(in: .global).minY)
                    }


                    if (geometry.frame(in: .global).maxY) > 10 {
                        Button("←") {
                            print("Back B")
                            print(geometry.frame(in: .global).maxY)
                        }.offset(y: -geometry.frame(in: .global).minY).padding(40)
                    }
                }
            }
        }.frame(maxHeight: 100)
    }
}


struct Content: View {

    var items = Array(0...100).map { "\($0)" }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView {
                ForEach(items, id: \.self) { i in
                    Text(i)
                }
            }.frame(height: 2000)
        }
            .frame(idealHeight: .greatestFiniteMagnitude)
            .padding()
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
