import Foundation


enum EventError: Error {
    case duplicateName(Event)
    case duplicateColor(Event)
    
    var errorDescription: String? {
        switch self {
        case .duplicateName(let event):
            return "Event with name '\(event.name)' already exists."
        case .duplicateColor(let event):
            return "Event with the same color (\(event.color)) already exists."
        }
    }
}

