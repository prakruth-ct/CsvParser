import UIKit
import CoreXLSX


//ABS PATH IN CONSTANT

class ViewController: UIViewController {
    
    var viewModel = ViewManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setFileName(fileName: Constants.filePath5)
        viewModel.openCSVFile()
        print(viewModel.fileContents)
    }
}

