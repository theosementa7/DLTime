//
//  String.swift
//  DLTime
//
//  Created by KaayZenn on 16/11/2023.
//

import Foundation

extension String {
    
    var isDigit: Bool {
        return self.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
    }
    
}
