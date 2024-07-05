import Foundation

enum CoffeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case expressino
    case cortado
}

enum CoffeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name, email: String
    let type: CoffeType
    let size: CoffeSize
}
