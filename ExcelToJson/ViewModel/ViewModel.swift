import Foundation

class ViewModel {
    
    private var csvParser = CSVPasrserManager()
    var fileName: String?
    var dataSrc: [Section]?
    
    func setFileName(fileName: String) {
        self.fileName = fileName
    }
    
    func getDataFromCSV() {
        dataSrc = csvParser.parseCSVFile(fileName: fileName ?? "")
    }
}
