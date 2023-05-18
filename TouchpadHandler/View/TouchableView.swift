//
//  TouchableView.swift
//  TouchpadHandler
//
//  Created by Alex on 18.05.2023.
//

import SwiftUI

class TouchableView: UIView, TouchpadHandler {
    
    var touchpadHandler: TouchpadHandler?
    private var fingerIndexes = FingerIndexes()
   
    func onButtonEvent(isPressed: Bool) {
        touchpadHandler?.onButtonEvent(isPressed: isPressed)
    }
    
    func onTouchEvent(idx: Int, x: Double, y: Double) {
        touchpadHandler?.onTouchEvent(idx: idx, x: x, y: y)
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
        // DO SOMETHING HERE
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
