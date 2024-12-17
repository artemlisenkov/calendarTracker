import Foundation


enum CalendarError: LocalizedError {
    case emptyDatesArray
    case invalidDate
    
    var errorDescription: String? {
        switch self {
        case .emptyDatesArray:
            return "Failed to generate dates for the current month."
        case .invalidDate:
            return "Something went wrong with the date."
        }
    }
}
