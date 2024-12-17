import SwiftUI

struct Event: Identifiable, EventProtocol {
    let id = UUID()
    let name: String
    let date: Date
    let color: Color
    let targetQuantity: Int
    let timePeriod: Calendar.Component
}

