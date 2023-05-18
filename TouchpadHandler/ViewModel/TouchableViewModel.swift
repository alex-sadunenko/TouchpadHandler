//
//  TouchableViewModel.swift
//  TouchpadHandler
//
//  Created by Alex on 18.05.2023.
//

import Foundation

// MARK: - PROTOCOL
protocol TouchpadHandler {
    func onButtonEvent(isPressed: Bool)
    func onTouchEvent(
        idx: Int, // finger index
        x: Double, // coordinate in percentage of width (0...100)
        y: Double // coordinate in percentage of height (0...100)
    )
}

class TouchableViewModel: ObservableObject {
    @Published var isButtonTouched = false
    @Published var touchPadMultiTouchEnabled = true
    @Published var buttonMultiTouchEnabled = false
}

extension TouchableViewModel: TouchpadHandler {
    func onButtonEvent(isPressed: Bool) {
        isPressed
        ? print("Button is pressed")
        : print("Button is unpressed")

    }
    
    func onTouchEvent(idx: Int, x: Double, y: Double) {
        print("Touch with index \(idx) at width: \(round(x))% height: \(round(y))%")
    }
}
