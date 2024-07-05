import Foundation

//MARK: - ORDERS LIST -
class OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel {
    func orderViewModel(at index: Int) -> OrderViewModel {
        self.ordersViewModel[index]
    }
}

//MARK: - ORDERS -
struct OrderViewModel {
    let order: Order
}

extension OrderViewModel {
    var name: String { self.order.name }
    var email: String { self.order.email }
    var type: String { self.order.type.rawValue.capitalized }
    var size: String {self.order.size.rawValue.capitalized }
}
