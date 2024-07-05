import Foundation

struct AddOrderViewModel {
    var name, email: String?
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {CoffeType.allCases.map { $0.rawValue.capitalized }}
    var sizes: [String] {CoffeSize.allCases.map { $0.rawValue.capitalized }}
}
