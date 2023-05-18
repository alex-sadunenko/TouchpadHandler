//
//  FingerIndexes.swift
//  TouchpadHandler
//
//  Created by Alex on 18.05.2023.
//

import SwiftUI

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
        if !array.contains(element) {
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
