//
//  Constants.swift
//  Chat
//
//  Created by Alla Golovinova on 04.10.2021.
//

struct K {
    static let appName = "Your Chat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let gray = "BrandGray"
        static let lightGray = "BrandLightGray"
        static let pink = "BrandPink"
        static let lightPink = "BrandLightPink"
        static let textColor = "BrandTextColor"
    }
    
    struct FStore {
        static let collectionUserNames = "usernames"
        static let UIuser = "uid"
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
        static let name = "name"
    }
}
