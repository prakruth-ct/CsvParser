import UIKit
//ABS PATH IN CONSTANT

class ViewController: UIViewController {
    
    var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setFileName(fileName: Constants.filePath5)
        viewModel.getDataFromCSV()
    }
}

