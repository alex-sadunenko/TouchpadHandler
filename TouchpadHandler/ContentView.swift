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

// MARK: - UIKit UIViewRepresentable
struct MyView: UIViewRepresentable {
    
    let isMultipleTouchEnabled: Bool
    
    func makeUIView(context: Context) -> TouchableView {
        let touchableView = TouchableView()
        touchableView.isUserInteractionEnabled = true
        touchableView.isMultipleTouchEnabled = isMultipleTouchEnabled
        return touchableView
    }
    
    func updateUIView(_ uiView: TouchableView, context: Context) {
        // UPDATE VIEW IF IT'S NECESSARY
    }
}

struct FingerIndexes {
    
    var array: [UITouch] = []
    
    func indexElement(_ element: UITouch) -> Int {
        if let index = array.firstIndex(of: element) {
            return index + 1
        } else {
            return 0
        }
    }

    mutating func addElement(_ element: UITouch) {
        if array.contains(element) {
            array.append(element)
        }
    }
    
    mutating func removeElement(_ element: UITouch) {
        if let index = array.firstIndex(of: element) {
            array.remove(at: index)
        }
    }
    
    mutating func clearData() {
        array.removeAll()
    }
    
}

// MARK: - TOUCH DELEGATES
class TouchableView: UIView, TouchpadHandler {
    
    private var fingerIndexes = FingerIndexes()
   
    func onButtonEvent(isPressed: Bool) {
        switch isPressed {
        case true:
            print("Button is pressed")
        default:
            print("Button is unpressed")
        }
    }
    
    func onTouchEvent(idx: Int, x: Double, y: Double) {
        print("Touch with index \(idx) at width: \(round(x))% height: \(round(y))%")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            fingerIndexes.addElement(touch)
            let touchLocation = touch.location(in: self)
            let x = Double(touchLocation.x * 100 / self.bounds.width)
            let y = Double(touchLocation.y * 100 / self.bounds.height)
            let idx = fingerIndexes.indexElement(touch)
            if self.isMultipleTouchEnabled {
                onTouchEvent(idx: idx, x: x, y: y)
            } else {
                onButtonEvent(isPressed: true)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            fingerIndexes.removeElement(touch)
            if !self.isMultipleTouchEnabled {
                onButtonEvent(isPressed: false)
            }
        }
    }
}

// MARK: - TOUCHPAD
struct ContentView: View {
    
    @State var isButtonHidden = false
    @State private var cornerRadius: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            MyView(isMultipleTouchEnabled: true)
                .frame(width: .none, height: isButtonHidden ? 400 : 300)
                .background(.blue)
                .border(.blue)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .cornerRadius(cornerRadius)
                .animation(.easeInOut(duration: 0.5), value: 0)
            
            MyView(isMultipleTouchEnabled: false)
                .frame(width: .none, height: isButtonHidden ? 0 : 100)
                .background(.yellow)
                .border(.yellow)
                .scaleEffect(scale)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                .animation(.easeInOut(duration: 0.5), value: 0)
            
            Spacer()
            
            Button(isButtonHidden ? "Touchpad with Button" : "Touchpad only") {
                withAnimation {
                    isButtonHidden.toggle()
                    cornerRadius = cornerRadius == 0 ? 20 : 0
                    scale = scale == 1.0 ? 0.1 : 1.0
                }
            }
            .font(.title2)
            .padding()
        }
        .padding()
        
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
