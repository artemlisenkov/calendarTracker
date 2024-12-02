import SwiftUI

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
    @State private var days: [Date] = []
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack {
            Text(DateManager.currentMonthAndYear())
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 10)
                
            if let errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 20, weight: .bold))
                    .monospaced()
                    .padding()
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(0..<days.weekdayOffset(), id: \.self) { _ in
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.gray)
                    }
                    
                    ForEach(days, id: \.self) { day in
                        DayView(day: day, isToday: DateManager.isToday(day))
                    }
                }
                .padding()
            }
        }
        .onAppear {
            loadDays()
        }
    }
    
    private func loadDays() {
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


#Preview {
    CalendarView()
}
