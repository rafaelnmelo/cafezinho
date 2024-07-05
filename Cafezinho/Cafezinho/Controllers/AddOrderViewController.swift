import UIKit

//MARK: - CLASS -
class AddOrderViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = AddOrderViewModel()
}

//MARK: - TABLEVIEW DATASOURCE -
extension AddOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CofeeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.viewModel.types[indexPath.row]
        
        return cell
    }
}

//MARK: - TABLEVIEW DELEGATE -
extension AddOrderViewController: UITableViewDelegate {
    
}
