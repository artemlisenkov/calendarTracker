import Foundation


struct DateManager {
    static func generateDatesForCurrentMonth() throws -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        
        guard let range = calendar.range(of: .day, in: .month, for: today) else {
            throw CalendarError.emptyDatesArray }
        
        let dates = range.compactMap { day -> Date? in
            var components = calendar.dateComponents([.year, .month], from: today)
            components.day = day
            
            return calendar.date(from: components)
        }
        
        guard !dates.isEmpty else {
            throw CalendarError.emptyDatesArray
        }
        
        return dates
    }
    
    
    static func currentMonthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        
        return formatter.string(from: Date())
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
