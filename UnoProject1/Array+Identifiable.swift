//
//  Array+Identifiable.swift
//  UnoProject1
//
//  Created by John Critchlow on 9/15/22.
//

import SwiftUI

extension Array where Element: Identifiable {
    func firstIndex(matching targetElement: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == targetElement.id {
                return index
            }
        }
        return nil
    }
}

