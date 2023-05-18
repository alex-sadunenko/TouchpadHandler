//
//  MyView.swift
//  TouchpadHandler
//
//  Created by Alex on 18.05.2023.
//

import SwiftUI

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
