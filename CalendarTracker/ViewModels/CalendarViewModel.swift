import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var days: [Date] = []
    @Published var selectedDay: Date = Date()
    @Published var dateForGenerating: Date = Date()
    @Published var errorMessage: String? = nil
    @Published var monthAndYear: String = DateManager.retrieveMonthAndYear(from: Date())
    @Published var rowHeight: CGFloat = 65

    let eventManager = EventManager()

    func loadDays() {
        do {
            days = try DateManager.generateDatesForMonth(for: dateForGenerating)
            if days.isEmpty {
                throw CalendarError.emptyDatesArray
            }
        } catch let error as CalendarError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Something went wrong"
        }
    }
    
    
    func updateMonthAndYear() {
        monthAndYear = DateManager.retrieveMonthAndYear(from: dateForGenerating)
    }
    
    
    func changeMonth(by value: Int) {
        do {
            guard let newDate =
                    try DateManager.changeDateByMonth(by: value, from: dateForGenerating)
            else {
                throw CalendarError.invalidDate
            }
            
            dateForGenerating = newDate
            updateMonthAndYear()
            loadDays()
            
        } catch let error as CalendarError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Something went wrong"
        }
    }
}
