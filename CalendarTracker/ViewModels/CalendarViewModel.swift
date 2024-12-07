import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var days: [Date] = []
    @Published var selectedDay: Date = Date()
    @Published var errorMessage: String? = nil
    @Published var isAddingEvent: Bool = false

    let eventManager = EventManager()

    func loadDays() {
        do {
            days = try DateManager.generateDatesForCurrentMonth()
            if days.isEmpty {
                throw CalendarError.emptyDatesArray
            }
        } catch CalendarError.emptyDatesArray {
            errorMessage = "Failed to generate dates for the current month."
        } catch {
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}
