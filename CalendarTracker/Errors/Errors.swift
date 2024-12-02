import Foundation

enum CalendarError: Error {
    case emptyDatesArray
    case invalidDate
}


enum EventError: Error {
    case duplicateName(Event)
    case duplicateColor(Event)
    
    var errorDescription: String? {
        switch self {
        case .duplicateName(let event):
            return "Event with name \(event.name) already exists."
        case .duplicateColor(let event):
            return "Event with color \(event.color) already exists."
        }
    }
}
