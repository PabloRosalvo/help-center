//
//  LocalizedString.swift
//  lightning-network
//
//  Created by Pablo Rosalvo de Melo Lopes on 24/06/24.
//

import Foundation

enum LocalizedString: String {
    case titleHome = "title_home"
    case titleButtonHome = "title_home_button"
    case clickHereToAccessList = "click_here_to_access_list"
    case messageError = "message_error"
    case checkInternet = "check_internet"
    case tryAgain = "try_again"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
