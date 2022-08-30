//
//  ContentView.swift
//  Project-9-Drawing-Challange
//
//  Created by Luca Capriati on 2022/08/30.
//
// Project 9 - Challange 1 - Create an Arrow shape – having it point straight up is fine. This could be a
//  rectangle/triangle-style arrow, or perhaps three lines, or maybe something else depending on
//  what kind of arrow you want to draw.
// Project 9 - Challange 2 - Make the line thickness of your Arrow shape animatable.
// Project 9 - Challange 3 - Create a ColorCyclingRectangle shape that is the rectangular cousin of
//  ColorCyclingCircle, allowing us to control the position of the gradient using one or more
//  properties.

import SwiftUI

// Project 9 - Challange 1
struct Arrow: Shape {
    var headHeight = 0.5
    var shaftWidth = 0.3
    
    // Project 9 - Challange 2
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(headHeight, shaftWidth) }
        set {
            headHeight = newValue.first
            shaftWidth = newValue.second
            
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let height = rect.height * headHeight
        let thickness = rect.width * shaftWidth / 2
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.maxX, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: height))
            path.addLine(to: CGPoint(x: rect.midX + thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX - thickness, y: height))
            
            path.closeSubpath()
            
        }
    }
}

    struct ContentView: View {
        // Project 9 - Challange 2
        @State private var headHeight = 0.5
        @State private var shaftWidth = 0.25
        
        var body: some View {
            // Project 9 - Challange 2
            Arrow(headHeight: headHeight, shaftWidth: shaftWidth)
                .fill(.indigo)
                .onTapGesture {
                    withAnimation {
                        headHeight = Double.random(in: 0.2...0.8)
                        shaftWidth = Double.random(in: 0.2...0.8)
                    }
                }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
