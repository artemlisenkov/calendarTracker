import SwiftUI

class AddEventViewModel: ObservableObject {
    @Published var eventName: String = ""
    @Published var eventColor: Color = .blue
    @Published var goalQuantity: Int = 1
    
    @Published var errorMessage: String?

    let eventManager: EventManager

    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
    }

    
    func saveEvent(for selectedDay: Date) -> Bool {
        guard !eventName.isEmpty else {
            errorMessage = "Event name cannot be empty."
            return false
        }

        do {
            try eventManager.createEvent(
                name: eventName,
                color: eventColor,
                goalQuantity: goalQuantity,
                date: selectedDay
            )
            return true
        } catch let error as EventError {
            errorMessage = error.errorDescription
            return false
        } catch {
            errorMessage = "Unexpected error occurred."
            return false
        }
    }
}
