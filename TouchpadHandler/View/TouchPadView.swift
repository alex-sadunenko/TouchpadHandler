//
//  TouchPadView.swift
//  TouchpadHandler
//
//  Created by Alex on 18.05.2023.
//

import SwiftUI

struct TouchPadView: View {
    
    @StateObject private var viewModel: TouchableViewModel = TouchableViewModel()
    @State var isButtonHidden = false
    
    // MARK: - PARAMS
    @State private var cornerRadius: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        
        VStack {
            MyView(touchpadHandler: .constant(viewModel), isMultipleTouchEnabled: viewModel.touchPadMultiTouchEnabled)
                .frame(width: .none, height: isButtonHidden ? 400 : 300)
                .background(.blue)
                .border(.blue)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .cornerRadius(cornerRadius)
                .animation(Animation.interpolatingSpring(stiffness: 160, damping: 18), value: isButtonHidden)
            
            MyView(touchpadHandler: .constant(viewModel), isMultipleTouchEnabled: viewModel.buttonMultiTouchEnabled)
                .frame(width: .none, height: isButtonHidden ? 0 : 100)
                .background(.yellow)
                .border(.yellow)
                .scaleEffect(scale)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                .animation(Animation.interpolatingSpring(stiffness: 160, damping: 18), value: isButtonHidden)
            
            Button(isButtonHidden ? labelTouchPadWithButton : labelTouchPadOnly,
                   action: buttonAction)
            .font(.title2)
            .padding(.top, 50)
        }
        .padding()
    }
    
    // MARK: - ACTIONS
    private func buttonAction() {
        withAnimation {
            isButtonHidden.toggle()
            cornerRadius = cornerRadius == 0 ? 20 : 0
            scale = scale == 1.0 ? 0.1 : 1.0
        }
    }
    
}

struct TouchPadView_Previews: PreviewProvider {
    static var previews: some View {
        TouchPadView()
    }
}
