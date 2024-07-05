import UIKit

//MARK: - PROTOCOL -
protocol AddOrderDelegate {
    func addOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addOrderViewControllerDidClose(controller: UIViewController)
}

//MARK: - CLASS -
class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var sizesSegmentedControl: UISegmentedControl!
    private var viewModel = AddOrderViewModel()
    
    var delegate: AddOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - IBACTIONS -
extension AddOrderViewController {
    @IBAction func close() {
        if let delegate = self.delegate {
            delegate.addOrderViewControllerDidClose(controller: self)
        }
    }
    
    @IBAction func saveOrder() {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.sizesSegmentedControl.titleForSegment(at: self.sizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Error in selecting coffee!")
        }
        
        self.viewModel.name = name
        self.viewModel.email = email
        self.viewModel.selectedSize = selectedSize
        self.viewModel.selectedType = self.viewModel.types[indexPath.row]
        
        WebService().load(resource: Order.create(viewModel: self.viewModel)) { result in
            switch result {
            case .success(let order):
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.addOrderViewControllerDidSave(order: order,
                                                               controller: self)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - FUNCTIONS -
extension AddOrderViewController{
    private func setupUI() {
        self.sizesSegmentedControl = UISegmentedControl(items: self.viewModel.sizes)
        self.sizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.sizesSegmentedControl)
        
        self.sizesSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 8).isActive = true
        self.sizesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
