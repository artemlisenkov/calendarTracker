import Foundation


extension Array where Element == Date {
    func weekdayOffset() -> Int {
        guard let firstDate = self.first else { return 0 }
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: firstDate)
        let firstWeekday = calendar.firstWeekday
        
        let offset = (weekday - firstWeekday + 7) % 7
        return offset
    }
}
