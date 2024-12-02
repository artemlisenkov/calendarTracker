import SwiftUI


struct CalendarView: View {
    @State private var days: [Date] = []
    @State private var events: [Event] = []
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
                        Color.clear
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
