import SwiftUI


// MARK: - fucntions
func generateDaysInMonth() -> [Date] {
    let calendar = Calendar.current
    let today = Date()
    
    guard let range = calendar.range(of: .day,
                                     in: .month,
                                     for: today) else { return [] }
    
    return range.compactMap { day -> Date? in
        var components = calendar.dateComponents([.year, .month], from: today)
        components.day = day
        
        return calendar.date(from: components)
    }
}


func currentMonthAndYear() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM, yyyy"
    
    return formatter.string(from: Date())
}


private func isToday(_ date: Date) -> Bool {
    return Calendar.current.isDateInToday(date)
}


// MARK: - content views
struct DayView: View {
    let day: Date
    let isToday: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(minWidth: 45, minHeight: 65)
            .foregroundStyle(isToday ? Color.red.opacity(0.6) : Color.gray.opacity(0.25))
        
            .overlay(
                Text("\(Calendar.current.component(.day, from: day))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 20)
            )
    }
}


struct CalendarView: View {
    private let days: [Date] = generateDaysInMonth()
    
    var body: some View {
        VStack {
            Text(currentMonthAndYear())
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 10)
                
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(0..<days.firstDayOfWeek(), id: \.self) { _ in
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.gray)
                }
                
                ForEach(days, id: \.self) { day in
                    DayView(day: day, isToday: isToday(day))
                }
            }
            .padding()
        }
    }
}


#Preview {
    CalendarView()
}
