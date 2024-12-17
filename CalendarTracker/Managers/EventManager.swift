import Foundation
import SwiftUI

class EventManager: ObservableObject {
    @Published var events: [Date: [Event]] = [:]

    func addEvent(_ newEvent: Event, for day: Date) throws {
        if events[day]?.contains(where: { $0.name == newEvent.name }) == true {
            throw EventError.duplicateName(newEvent)
        }
        if events[day]?.contains(where: { $0.color == newEvent.color }) == true {
            throw EventError.duplicateColor(newEvent)
        }
        if events[day] == nil {
            events[day] = []
        }
        events[day]?.append(newEvent)
    }

    func createEvent(name: String, color: Color, goalQuantity: Int, date: Date) throws {
        let newEvent = Event(
            name: name,
            date: date,
            color: color,
            targetQuantity: goalQuantity,
            timePeriod: .weekOfYear
        )
        try addEvent(newEvent, for: date)
    }

    func getEvents(for day: Date) -> [Event] {
        return events[day] ?? []
    }
    
    func bindingEvents(for day: Date) -> Binding<[Event]> {
        Binding(
            get: { self.events[day, default: []] },
            set: { self.events[day] = $0 }
        )
    }
}
