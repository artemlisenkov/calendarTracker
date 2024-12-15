import SwiftUI

struct EventsListView: View {
    @Binding var events: [Event]
    var selectedDay: Date

    var body: some View {
        NavigationView {
            VStack {
                if events.isEmpty {
                    Text("No events for \(selectedDay.formattedDate)")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(events) { event in
                        VStack(alignment: .leading) {
                            Text(event.name)
                                .font(.headline)
                            Text(event.date.formattedDateAndTime)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Events")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

