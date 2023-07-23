//
//  SystemMessage.swift
//  AzowoScratchCards
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation
import UIKit

class SystemMessage: NSObject {
    
    static let LONG_DELAY   : Double = 3.5
    static var timer        : Timer!
    
    static func showToast(customString: String = "") {

        DispatchQueue.main.async {

            let currentWindow = UIApplication.shared.windows.first
            let view = SystemToastView()
            view.titleLbl.text = customString
            currentWindow?.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: currentWindow, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0).isActive = true
            
            NSLayoutConstraint(item: currentWindow!, attribute: NSLayoutConstraint.Attribute.bottomMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
            
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: currentWindow, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0).isActive = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (LONG_DELAY - Animation.TIME), execute: {
                UIView.animate(withDuration: Animation.TIME, animations: {
                    view.alpha = 0.0
                }, completion: { (true) in
                    view.removeFromSuperview()
                })
            })
            
        }
        
    }
    
}
