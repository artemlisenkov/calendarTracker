import SwiftUI


struct CalendarView: View {
    @State private var days: [Date] = []
    @State private var events: [Date: [Event]] = [:]
    @State private var errorMessage: String? = nil
    
    @State private var selectedDay: Date = Date()
    @State private var isAddingEvent: Bool = false
    
    var body: some View {
        VStack (spacing: 30) {
            
            HStack {
                Text(DateManager.currentMonthAndYear())
                    .font(.system(size: 32, weight: .bold))
                    .padding(.bottom, 10)
            }
            // Error displaying
            if let errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 20, weight: .bold))
                    .monospaced()
                    .padding()
            } else {
                // Starting offset
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(0..<days.weekdayOffset(), id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(minWidth: 45, minHeight: 65)
                            .foregroundStyle(Color.gray.opacity(0.1))
                    }
                    
                    // Day displaying
                    ForEach(days, id: \.self) { day in
                        DayView(
                            day: day,
                            isToday: DateManager.isToday(day),
                            events: events[day] ?? []
                        )
                        .onTapGesture {
                            selectedDay = day
                            isAddingEvent = true
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            loadDays()
        }
        .sheet(isPresented: $isAddingEvent) {
            AddEventView(isAddingEvent: $isAddingEvent,
                         events: $events,
                         selectedDay: $selectedDay)
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
