import Foundation


struct DateManager {
    private static let calendar = Calendar.current

    
    static func generateDatesForMonth(for date: Date) throws -> [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: date) else {
            throw CalendarError.emptyDatesArray
        }
        
        let dates = range.compactMap { day -> Date? in
            var components = calendar.dateComponents([.year, .month], from: date)
            components.day = day
            
            return calendar.date(from: components)
        }
        
        guard !dates.isEmpty else {
            throw CalendarError.emptyDatesArray
        }
        
        return dates
    }
    
    
    static func changeDateByMonth(by offset: Int, from date: Date) throws -> Date? {
        guard let changedDate = calendar.date(byAdding: .month, value: offset, to: date)
        else {
            throw CalendarError.invalidDate

        }
        
        return changedDate
    }
    
    
//    static func generateDatesForOffsetMonth(for date: Date, by offset: Int) throws -> [Date] {
//        guard let nextMonth = Calendar.current.date(byAdding: .month, value: offset, to: date) else {
//            throw CalendarError.invalidDate
//        }
//        
//        return try generateDatesForMonth(from: nextMonth)
//    }
    
    
    static func retrieveMonthAndYear(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        
        return formatter.string(from: date)
    }
    
    
    static func shortWeekdaySymbols() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
    
        var symbols = formatter.shortWeekdaySymbols
        let sunday = symbols?.removeFirst()
        symbols?.append(sunday!)
        
        return symbols!
    }
    
    
    static func isToday(_ date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
}
