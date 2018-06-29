//
//  CharacterExtension.swift
//  Nalssi
//
//  Created by Corentin Redon on 6/29/18.
//  Copyright © 2018 mti. All rights reserved.
//

import Foundation

extension Character {
    
    var asciiValue: Int {
        return Int(self.unicodeScalars.filter{$0.isASCII}.first?.value ?? 0)
    }
    
    static func -(left: Character, right: Character) -> Int {
        return left.asciiValue - right.asciiValue
    }
}
