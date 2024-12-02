import SwiftUI


struct DayView: View {
    let day: Date
    let isToday: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(minWidth: 45, minHeight: 65)
            .foregroundStyle(isToday ? Color.red.opacity(0.6) : Color.gray.opacity(0.25))
        
            .overlay(
                Text("\(Calendar.current.component(.day, from: day))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 20)
            )
    }
}
