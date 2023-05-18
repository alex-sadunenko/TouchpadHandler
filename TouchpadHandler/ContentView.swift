//
//  ContentView.swift
//  TouchpadHandler
//
//  Created by Alex on 17.05.2023.
//


import SwiftUI
import UIKit

// MARK: - PROTOCOL
protocol TouchpadHandler {
    func onButtonEvent(isPressed: Bool)
    func onTouchEvent(
        idx: Int, // finger index
        x: Double, // coordinate in percentage of width (0...100)
        y: Double // coordinate in percentage of height (0...100)
    )
}

// MARK: - TOUCHPAD
struct ContentView: View {
    var body: some View {
        TouchPadView()
    }
}

// MARK: - CUSTOM RADIUS
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
