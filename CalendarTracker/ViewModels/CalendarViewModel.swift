import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var days: [Date] = []
    @Published var selectedDay: Date = Date()
    @Published var errorMessage: String? = nil
    @Published var isAddingEvent: Bool = false

    let eventManager = EventManager()

    func loadDays() {
        do {
            days = try DateManager.generateDatesForMonth()
            if days.isEmpty {
                throw CalendarError.emptyDatesArray
            }
        } catch let error as CalendarError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Something went wrong"
        }
    }
}
