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
