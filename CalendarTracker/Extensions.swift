import Foundation

extension Array where Element == Date {
    func firstDayOfWeek() -> Int {
        guard let firstDate = self.first else { return 0 }
        
        return Calendar.current.component(.weekday, from: firstDate) - 1
    }
}
