import SwiftUI


struct DayView: View {
    let day: Date
    let isToday: Bool
    @State var events: [Event]
    
    @State private var showMenu: Bool = false
    @State private var showEvents: Bool = false
    @State private var showAddEvent: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 45, height: 65)
                .foregroundStyle(isToday ? Color.red.opacity(0.6) : Color.gray.opacity(0.25))
            
            VStack {
                HStack(spacing: 3) {
                    ForEach(events.prefix(3), id: \.id) { event in
                        Circle()
                            .fill(event.color)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 12)
               
                Spacer()

                Text("\(Calendar.current.component(.day, from: day))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
            }
        }
        .contextMenu {
            Button("Add") { showAddEvent.toggle() }
            Button("Events") { showEvents.toggle() }
        }

        .sheet(isPresented: $showAddEvent) {
            AddEventView(
                viewModel: AddEventViewModel(eventManager: EventManager()),
                isAddingEvent: $showAddEvent,
                selectedDay: .constant(day)
            )
        }
        
        .sheet(isPresented: $showEvents) {
            EventsListView(events: $events, selectedDay: day)
        }
    }
}
