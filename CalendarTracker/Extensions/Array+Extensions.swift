import Foundation


extension Array where Element == Date {
    func weekdayOffset() -> Int {
        guard let firstDate = self.first else { return 0 }
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: firstDate)
        
        let offset = (weekday + 5) % 7
        return offset
    }
}
