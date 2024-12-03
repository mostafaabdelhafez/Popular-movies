//
//  Extensions.swift
//  PopularMovies
//
//  Created by jobzella on 12/3/24.
//

import Foundation
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
