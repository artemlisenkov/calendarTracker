import Foundation

extension Date {
    private static let mediumFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var formattedDate: String {
        Self.mediumFormatter.string(from: self)
    }
}

