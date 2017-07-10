//
//  Constants.swift

//
//  Created by Apple on 9/07/17.
//  Copyright © 2017 Salman. All rights reserved.
//
import UIKit
 
struct Constants {
    struct URLs {
        
        
        static let kBaseUrl = "http://50.63.165.179:3000/bong/list"
      
    }
    struct StoryBoardIDStrings {
        
        static let kDetialViewControllerID = "DetialViewControllerID"
    }
    

    // MARK: Font Struct
    struct FontsStrings {
        static func montserratSemiBoldFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        }
        
        static func montserratBoldFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Bold", size: size)!
        }
        
        static func montserratRegularFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Regular", size: size)!
        }
    
        static func montserratExtraBoldFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-ExtraBold", size: size)!
        }
        
        static func montserratLightFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Light", size: size)!
        }
        
        static func montserratUltraLightFontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-UltraLight", size: size)!
        }

    }

    struct ErrorStrings {
        
        static let nNetworkError = "Network Error"
        static let nNotReachable = "The network is not reachable"
        static let nUnknown = "It is unknown whether the network is reachable"
        static let nWrong = "Something went wrong!!!"
    }
    struct ColorStrings {
        static let cTextColor = "#1D1D26"
    }
    struct GeneralStrings {
        static let kSorry = "Sorry"
        static let KOk = "Ok"
    }
}

