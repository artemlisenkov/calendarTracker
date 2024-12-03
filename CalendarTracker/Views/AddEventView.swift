import SwiftUI

struct AddEventView: View {
    @Binding var isAddingEvent: Bool
    @Binding var events: [Date: [Event]]
    @Binding var selectedDay: Date

    @State private var eventName: String = ""
    @State private var eventColor: Color = .blue
    @State private var goalQuantity: Int = 1

    var body: some View {
        NavigationView {
            Form {
                TextField("Event Name", text: $eventName)
                ColorPicker("Event Color", selection: $eventColor)
                Stepper("Total: \(goalQuantity)", value: $goalQuantity, in: 1...100)
            }
            .navigationTitle("Add Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isAddingEvent = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveEvent()
                        isAddingEvent = false
                    }
                }
            }
        }
    }

    private func saveEvent() {
        guard !eventName.isEmpty else { return }
        
        let newEvent = Event(
            name: eventName,
            date: selectedDay,
            color: eventColor,
            targetQuantity: goalQuantity,
            timePeriod: .weekOfYear
        )
        
        if events[selectedDay] == nil {
            events[selectedDay] = []
        }
        events[selectedDay]?.append(newEvent)
    }
}
