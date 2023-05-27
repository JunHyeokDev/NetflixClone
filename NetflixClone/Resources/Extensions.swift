//
//  Extensions.swift
//  NetflixClone
//
//  Created by Jun Hyeok Kim on 2023/05/26.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
