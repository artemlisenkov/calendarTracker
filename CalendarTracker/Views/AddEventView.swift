import SwiftUI

struct AddEventView: View {
    @ObservedObject var viewModel: AddEventViewModel
    @Binding var isAddingEvent: Bool
    @Binding var selectedDay: Date

    var body: some View {
        NavigationView {
            Form {
                TextField("Event Name", text: $viewModel.eventName)
                ColorPicker("Event Color", selection: $viewModel.eventColor)
                Stepper("Total: \(viewModel.goalQuantity)", value: $viewModel.goalQuantity, in: 1...100)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.callout)
                        .padding(.vertical, 5)
                }
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
                        if viewModel.saveEvent(for: selectedDay) {
                            isAddingEvent = false
                        }
                    }
                }
            }
        }
    }
}
