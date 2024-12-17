import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var days: [Date] = []
    @Published var selectedDay: Date = Date()
    @Published var dateForGenerating: Date = Date()
    @Published var errorMessage: String? = nil
    @Published var monthAndYear: String = DateManager.retrieveMonthAndYear(from: Date())
    @Published var rowHeight: CGFloat = 65

    let eventManager = EventManager()

    func updateCalendar(by monthOffset: Int = 0) {
        do {
            if monthOffset != 0 {
                guard let newDate = try DateManager.changeDateByMonth(
                    by: monthOffset,
                    from: dateForGenerating
                ) else {
                    throw CalendarError.invalidDate
                }
                dateForGenerating = newDate
            }
            days = try DateManager.generateDatesForMonth(for: dateForGenerating)
            monthAndYear = DateManager.retrieveMonthAndYear(from: dateForGenerating)
            errorMessage = nil
        } catch let error as CalendarError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Something went wrong"
        }
    }

    func loadDays() {
        updateCalendar()
    }

    func changeMonth(by value: Int) {
        updateCalendar(by: value)
    }
}
