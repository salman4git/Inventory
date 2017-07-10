//
//  Helper.swift
//  Inventory
//
//  Created by Apple on 7/7/17.
//  Copyright © 2017 Salman. All rights reserved.
//

import Foundation
import UIKit

class Utility
{
    static func infoAlertWithMessage(_ title:String, message:String,viewController:UIViewController) -> Void {
        let actionSheetController: UIAlertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: Constants.GeneralStrings.KOk, style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        viewController.present(actionSheetController, animated: true, completion: nil)
    }
}

