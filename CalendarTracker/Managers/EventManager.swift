import Foundation


// MARK: - Event manager
struct EventManager {
    static var events: [Event] = []
    
    static func addEvent(_ newEvent: Event, to events: inout [Event]) throws {
        if let existingEvent = events.first(where: { $0.name == newEvent.name }) {
            throw EventError.duplicateName(existingEvent)
        }
        
        if let existingEvent = events.first(where: { $0.color == newEvent.color }) {
            throw EventError.duplicateColor(existingEvent)
        }
        
        events.append(newEvent)
    }
    
    
    static func updateEvent(_ existingEvent: Event, with newEvent: Event, in events: inout [Event]) throws {
        events.removeAll(where: { $0.id == existingEvent.id })
        
        try addEvent(newEvent, to: &events)
    }
    
    static func removeEvent(_ event: Event) {
        events.removeAll(where: {$0.id == event.id})
    }
    
    static func findEvent(byName name: String) -> Event? {
        return events.first(where: { $0.name == name })
    }
    
    static func currentEvents(forDate date: Date) -> [Event] {
        return events.filter { Calendar.current.isDate($0.date, inSameDayAs: date)}
    }
    
    static func getEvents() -> [Event] {
        return events
    }
}
