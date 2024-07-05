import Foundation

enum CoffeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case expressino
    case cortado
}

enum CoffeSize: String, Codable, CaseIterable {
    case pequeno
    case medio
    case grande
}

struct Order: Codable {
    let name, email: String
    let type: CoffeType
    let size: CoffeSize
}

extension Order {
    init?(_ viewModel: AddOrderViewModel) {
        guard let name = viewModel.name,
              let email = viewModel.email,
              let selectedType = CoffeType(rawValue: viewModel.selectedType!.lowercased()),
              let selectedSize = CoffeSize(rawValue: viewModel.selectedType!.lowercased())
        else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
}
