//
//  TouchPadView.swift
//  TouchpadHandler
//
//  Created by Alex on 18.05.2023.
//

import SwiftUI

struct TouchPadView: View {

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

struct TouchPadView_Previews: PreviewProvider {
    static var previews: some View {
        TouchPadView()
    }
}
