//
//  Alerts.swift
//  newsr
//
//  Created by Rahul Shirphule on 2019/10/09.
//  Copyright © 2019 Bryn Divey. All rights reserved.
//

import UIKit

class Alerts: NSObject {
    
    func showMessage(withTitle:String,withText:String,forView: UIViewController) {
        
        let alert = UIAlertController(title: withTitle, message: withText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            @unknown default:
                print("unknown default")
            }}))
        forView.present(alert, animated: true, completion: nil)
        
    }

}
