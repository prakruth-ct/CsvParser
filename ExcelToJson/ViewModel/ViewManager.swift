import CoreXLSX

class ViewManager {
    
    var fileName: String?
    var excelFile: XLSXFile?
    var fileContents: [[String]]?
    var structuredRowContents: [RowContents]?
    
    func setFileName(fileName: String) {
        self.fileName = fileName
    }
    
    func openCSVFile() {
        guard  let filePath = Bundle.main.path(forResource: fileName, ofType: Constants.FileTypes.csv) else { return }
        
        let fileContents = try? String(contentsOfFile: filePath)
        print(fileContents)
        var cleanedFileContents: [[String]] = [[]]
        let rows = fileContents?.components(separatedBy: "\r\n")
        for eachRow in rows ?? [""] {
            var values: [String] = []
            if eachRow.range(of: "\"") != nil {
                var scanText: String = eachRow
                var newStr: NSString?
                var textScanner = Scanner(string: scanText)
                while(textScanner.string != "") {
                    if (textScanner.string as NSString).substring(to: 1) == "\"" {
                        textScanner.scanLocation += 1
                        textScanner.scanUpTo("\",", into: &newStr)
                        textScanner.scanLocation += 1
                    } else if (textScanner.string as NSString).substring(to: 1) == "," {
                        newStr = ""
                    } else {
                        textScanner.scanUpTo(",", into: &newStr)
                    }
                    values.append(newStr! as String)
                    
                    if textScanner.scanLocation < textScanner.string.count {
                        scanText = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                    } else {
                        scanText = ""
                    }
                    textScanner = Scanner(string: scanText)
                }
                cleanedFileContents.append(values)
            } else {
                let columns = eachRow.components(separatedBy: ",")
                cleanedFileContents.append(columns)
            }
        }
        self.fileContents = cleanedFileContents
        formatRowContents()
    }
    
    func formatRowContents() {
        
        guard let fileContents = fileContents else { return }
//
//        var structuredFileContents: []
//        for row in fileContents {
//            if row[0] == "#" {
//
//            }
//            var rowContents = RowContents(slNo: Int(row[0]), initiative: row[1], description: row[2], pilotData: row[3], clientLaunchData: row[4], online: row, mobile: <#String#>, dda: <#String#>, wealth: <#String#>)
//
//        }
    }
    
    func openExcelFile() {
        guard  let filePath = Bundle.main.path(forResource: fileName, ofType: Constants.FileTypes.xlsx) else { return }
        
        excelFile = XLSXFile(filepath: filePath)
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }
}
