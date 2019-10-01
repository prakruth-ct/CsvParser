//extension String  {
//    var isNumber: Bool {
//        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
//    }
//}

extension String {
    var isNumber : Bool {
        return Double(self) != nil
    }
}
