public struct Section {
    
    public struct Row {
        public let rowID: Int
        public let initiative: String
        public let description: String
        public let pilotDate: String
        public let clientLaunchDate: String
        public let online: String
        public let mobile: String
        public let dda: String
        public let wealth: String
    }
    
    public let sectionID: Int
    public let sectionTitle: String
    public let rows: [Section.Row]
}
