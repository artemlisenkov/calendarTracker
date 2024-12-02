import SwiftUI

protocol EventProtocol {
    var id: UUID { get }
    var name: String { get }
    var date: Date { get }
    var color: Color { get }
    var targetQuantity: Int { get }
}
