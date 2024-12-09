import SwiftUI


struct CalendarView: View {
    @StateObject var viewModel = CalendarViewModel()

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    viewModel.changeMonth(by: -1)
                },
                       label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding()
                })
                
                Spacer()
                
                Text(viewModel.monthAndYear)
                    .font(.system(size: 32, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    viewModel.changeMonth(by: 1)
                },
                       label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .padding()
                })
            }
            .padding(.bottom, 10)

            HStack {
                ForEach(DateManager.shortWeekdaySymbols(), id: \.self) { day in
                    Text(day)
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 20, weight: .bold))
                    .monospaced()
                    .padding()
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(0..<viewModel.days.weekdayOffset(), id: \.self) { _ in
                        Text("")
                    }
                    
                    ForEach(viewModel.days, id: \.self) { day in
                        DayView(
                            day: day,
                            isToday: DateManager.isToday(day),
                            events: viewModel.eventManager.getEvents(for: day)
                        )
                        .onTapGesture {
                            viewModel.selectedDay = day
                            viewModel.isAddingEvent = true
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.loadDays()
        }
        .sheet(isPresented: $viewModel.isAddingEvent) {
            AddEventView(
                viewModel: AddEventViewModel(eventManager: viewModel.eventManager),
                isAddingEvent: $viewModel.isAddingEvent,
                selectedDay: $viewModel.selectedDay
            )
        }
    }
}


#Preview {
    @Previewable @StateObject var eventManager: EventManager = EventManager()
    
    CalendarView()
        .environmentObject(eventManager)
}
