import SwiftUI

@main
struct CalendarTrackerApp: App {
    @StateObject private var eventManager: EventManager = EventManager()
    
    var body: some Scene {
        WindowGroup {
            CalendarView()
                .environmentObject(eventManager)
        }
    }
}
