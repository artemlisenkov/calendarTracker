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
                            HStack {
                                Text(event.date.formattedDate)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Circle()
                                    .fill(event.color)
                                    .frame(width: 10, height: 10)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Events")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

