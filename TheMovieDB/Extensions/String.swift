//
//  Created by Nikhilesh on 20/07/15.
//  Copyright © 2015 Nikhilesh. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isBlankString()-> Bool {
        return self.trim().count == 0
    }
    
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func getDateStringFromTimeStamp(dateformat:String)-> String {
        let timestamp=Double(self)
        
        
        guard timestamp != nil else {
            return "\(Date())"
        }
        
        let date = Date(timeIntervalSince1970: Double(self)!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateformat//"yyyy-MM-dd HH:mm"          //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
        
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location + nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    
    // MARK:- String class extension for capitalizing first character
    func capitalizingFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: from)])
    }
    
    func startWith(_ find: String) -> Bool {
        return self.hasPrefix(find)
    }
    
    func equals(_ find: String) -> Bool {
        return self == find
    }
    
    func contains(_ find: String) -> Bool {
        if let _ = self.range(of: find) {
            return true
        }
        return false
    }
    
    var length: Int {
        return self.count
    }
    
    var str: NSString {
        return self as NSString
    }
    
    var pathExtension: String {
        return str.pathExtension 
    }
    
    var lastPathComponent: String {
        return str.lastPathComponent 
    }
    
    func boolValue() -> Bool? {
        var returnValue:Bool = false
        let falseValues = ["false", "no", "0"]
        let lowerSelf = self.lowercased()
        
        if falseValues.contains(lowerSelf) {
            returnValue =  false
        } else {
            returnValue = true
        }
        return returnValue
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    var IntValue: Int {
        return Int((self as NSString).intValue)
    }
    
    var isContainAlphabate:Bool {
        let capitalLetterRegEx  = ".*[^A-Za-z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: self) else { return false }
        return true
    }
    
    var isContainUpperCase:Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: self) else { return false }
        return true
    }
    
    var isContainLowerCase:Bool {
        let capitalLetterRegEx  = ".*[a-z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: self) else { return false }
        return true
    }
    
    var isContainNumber:Bool {
        let capitalLetterRegEx  = ".*[0-9]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: self) else { return false }
        return true
    }
    
    var isContainSpecialCharacter:Bool {
        let capitalLetterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: self) else { return false }
        return true
    }
    
    var isContainOnlySpecialCharacter:Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["+", "-", "&", "|", "!", "(", ")", "{", "}", "[", "]", "^",
        "~", "*", "?", ":","\"","\\", "@"]
        return Set(self).isSubset(of: nums)
    }
    
    var isLengthIs8_32:Bool {
        if (self.count >= 8) && (self.count <= 30) { return true
        } else { return false }
    }
    
    func URLEncodedString() -> String {
        let customAllowedSet =  CharacterSet.urlQueryAllowed
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        return escapedString ?? ""
    }
    
    func URLEncoded() -> String? {
        let escapedString = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        return escapedString
    }
    
    func makeURL() -> URL? {
        
        let trimmed = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let url = URL(string: trimmed ?? "") else {
            return nil
        }
        return url
    }
    
    static func heightForText(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        
        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: String.CompareOptions.literal, range: nil)
    }
    static func widthForText(_ text: String, font: UIFont, height: CGFloat) -> CGFloat {
        
        let rect = NSString(string: text).boundingRect(with: CGSize(width:  CGFloat(MAXFLOAT), height:height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    

    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined(separator: "")
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func removeHtmlFromString() -> String {
        
        let content = self
        
        let a = content.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        let b = a.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)

        
        return b
    }
    
    static func nullCheck(string: String?) -> String {
        
        if string == nil {
            return ""
        } else {
            return string!
        }
    }
    
    func removeStringTill(occurence:String) -> String  {
        if let range = self.range(of: occurence) {
            let secondPart = self[range.upperBound...]
            print(secondPart)
            return String(secondPart)
        }
        return self
    }
    
    /// Convert String to Date
    func convertToDate(dateFormat formatType: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType // Your date format
        let serverDate = dateFormatter.date(from:self) // according to date format your date string
        return serverDate
    }
    
    /// Diviation calculation
    func convertToSeconds(dateFormat formatType: String) -> Int {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType
        
        let date: Date = dateFormatter.date(from: self)!
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: date)
        let hour = comp.hour
        let minute = comp.minute
        // let sec = comp.second
        
        let totalSeconds = ((hour! * 60) * 60) + (minute! * 60) //+ sec!
        
        return totalSeconds
    }
    
    /// To Show the Date in String format
    func convertToShowFormatDate(dateFormatForInput inputformat: String, dateFormatForOutput outformat: String) -> String {
        
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = inputformat //Your date format
        
        let serverDate: Date = dateFormatterDate.date(from: self) ?? Date() //according to date format your date string
        
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateFormat = outformat //Your New Date format as per requirement change it own
        let newDate: String = dateFormatterString.string(from: serverDate) //pass Date here
        print(newDate) // New formatted Date string
        
        return newDate
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}

/// To Show Memory address of variable
extension String {
    static func pointer(_ object: AnyObject?) -> String {
        guard let object = object else { return "nil" }
        let opaque: UnsafeMutableRawPointer = Unmanaged.passUnretained(object).toOpaque()
        return String(describing: opaque)
    }
    
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
         return Range(nsRange, in: self)
    }
}

extension UnicodeScalar {
    /// Note: This method is part of Swift 5, so you can omit this.
    /// See: https://developer.apple.com/documentation/swift/unicode/scalar
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        0x1F018...0x1F270, // Various asian characters
        0x238C...0x2454, // Misc items
        0x20D0...0x20FF: // Combining Diacritical Marks for Symbols
            return true
            
        default: return false
        }
    }
    
    var isZeroWidthJoiner: Bool {
        return value == 8205
    }
}

extension String {
    // Not needed anymore in swift 4.2 and later, using `.count` will give you the correct result
    var glyphCount: Int {
        let richText = NSAttributedString(string: self)
        let line = CTLineCreateWithAttributedString(richText)
        return CTLineGetGlyphCount(line)
    }
    
    var isSingleEmoji: Bool {
        return glyphCount == 1 && containsEmoji
    }
    
    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }
    
    var containsOnlyEmoji: Bool {
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji && !$0.isZeroWidthJoiner
            })
    }
    
    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    var emojis: [String] {
        var scalars: [[UnicodeScalar]] = []
        var currentScalarSet: [UnicodeScalar] = []
        var previousScalar: UnicodeScalar?
        
        for scalar in emojiScalars {
            if let prev = previousScalar, !prev.isZeroWidthJoiner, !scalar.isZeroWidthJoiner {
                scalars.append(currentScalarSet)
                currentScalarSet = []
            }
            currentScalarSet.append(scalar)
            
            previousScalar = scalar
        }
        
        scalars.append(currentScalarSet)
        
        return scalars.map { $0.map { String($0) }.reduce("", +) }
    }
    
    fileprivate var emojiScalars: [UnicodeScalar] {
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            if let previous = previous, previous.isZeroWidthJoiner, cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
                
            } else if cur.isEmoji {
                chars.append(cur)
            }
            
            previous = cur
        }
        
        return chars
    }
}

extension String {
    
    var jsonArray:[String]? {
        
        if let data = self.data(using: .utf8) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String] {
                    print(jsonArray) // use the json here
                    return jsonArray
                } else {
                    print("bad json")
                    return nil
                }
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
    
    var array:[String]? {
        return self.components(separatedBy: " ")
    }
}
// Get height and width according to text size and font
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension String {
    
    func subStringAfter(string:String) -> String {
        let phoneNumber = self.components(separatedBy: string)[1]
        return phoneNumber 
    }
    
    func subStringBefore(string:String) -> String {
        let phoneNumber = self.components(separatedBy: string).first
        return phoneNumber ?? ""
    }
    
     func randomString(length: Int) -> String {
//      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let letters = "abcdefghijklmnopqrstuvwxyz0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
extension String {
    func stringByAppendingPathComponent1(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}


extension RangeReplaceableCollection  {
    /// Returns a new collection containing this collection shuffled
    var shuffled: Self {
        var elements = self
        return elements.shuffleInPlace()
    }
    /// Shuffles this collection in place
    @discardableResult
    mutating func shuffleInPlace() -> Self  {
        indices.forEach {
            let subSequence = self[$0...$0]
            let index = indices.randomElement()!
            replaceSubrange($0...$0, with: self[index...index])
            replaceSubrange(index...index, with: subSequence)
        }
        return self
    }
    func choose(_ n: Int) -> SubSequence { return shuffled.prefix(n) }
}

extension StringProtocol {
    subscript(_ offset: Int) -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>) -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}


extension String {
    func isEqualStringInLowerCase(_ string: String) -> Bool {
        if self.lowercased() == string.lowercased(){
            return true
        }else{
            return false
        }
       
    }
}

extension String {
    
    /// Calculates a numeric hash same as Riot Web
    /// See original function here https://github.com/matrix-org/matrix-react-sdk/blob/321dd49db4fbe360fc2ff109ac117305c955b061/src/utils/FormattingUtils.js#L47
    var vc_hashCode: Int32 {
        var hash: Int32 = 0
        
        for character in self {
            let shiftedHash = hash << 5
            hash = shiftedHash.subtractingReportingOverflow(hash).partialValue + Int32(character.vc_unicodeScalarCodePoint)
        }
        return abs(hash)
    }
    
    /// Locale-independent case-insensitive contains
    /// Note: Prefer use `localizedCaseInsensitiveContains` when locale matters
    ///
    /// - Parameter other: The other string.
    /// - Returns: true if current string contains other string.
    func vc_caseInsensitiveContains(_ other: String) -> Bool {
        return self.range(of: other, options: .caseInsensitive) != nil
    }
}

extension Character {
    var vc_unicodeScalarCodePoint: UInt32 {
        return self.unicodeScalars[self.unicodeScalars.startIndex].value
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
