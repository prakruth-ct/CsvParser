import UIKit

class ViewManager {
    
    var fileName: String?
    var fileContents: [[String]]?
    var structuredRowContents: [Section.Row]?
    var dataSrc: [Section] = []
    
    func setFileName(fileName: String) {
        self.fileName = fileName
    }
    
    func openCSVFile() {
        guard  let filePath = Bundle.main.path(forResource: fileName, ofType: Constants.FileTypes.csv) else { return }

        let fileContents = try? String(contentsOfFile: filePath)
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
        
        var sectionTitles: [String] = []
        var sectionContents: [[Section.Row]] = []
        var sectionCount = -1
        
        guard let fileContents = fileContents else { return }
        
        for row in fileContents {
            if row.first == "Table 1" || row.first == Constants.hashString || row.first?.isEmpty ?? true || row.isEmpty {
                continue
            } else if row[2].isEmpty {
                sectionTitles.append(row.first ?? "")
                sectionCount += 1
                sectionContents.append([])
            } else {
                sectionContents[sectionCount].append(Section.Row(rowID: Int(row[0]) ?? 0, initiative: row[1], description: row[2], pilotDate: row[3], clientLaunchDate: row[4], online: row[5], mobile: row[6], dda: row[7], wealth: row[8]))
            }
        }
        sectionCount = 0
        for section in sectionContents {
            if section.isEmpty{
                continue
            }
            dataSrc.append(Section(sectionID: sectionCount + 1, sectionTitle: sectionTitles[sectionCount], rows: section))
            sectionCount += 1
        }
    }
}
