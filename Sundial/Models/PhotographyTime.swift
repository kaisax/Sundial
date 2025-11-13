//
//  PhotographyTime.swift
//  Sundial
//
//  Model representing a photography time period
//

import SwiftUI
import Foundation

struct PhotographyTime: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let color: Color
    let startTime: Date?
    let endTime: Date?
    
    var duration: TimeInterval? {
        guard let start = startTime, let end = endTime else { return nil }
        return end.timeIntervalSince(start)
    }
}
