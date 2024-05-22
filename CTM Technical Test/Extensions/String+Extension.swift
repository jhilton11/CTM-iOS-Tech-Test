//
//  File.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-04.
//

import Foundation

extension String {
    
    func removingCharactersBeforeWord(_ targetWord: String) -> String? {
        if let range = self.range(of: targetWord) {
            let substring = self[range.lowerBound..<self.endIndex]
            return String(substring)
        }
        
        return ""
    }
    
}
