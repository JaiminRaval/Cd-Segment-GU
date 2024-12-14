//
//  AlertManager.swift
//  Cd-Segment-GU
//
//  Created by Jaimin Raval on 14/12/24.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    private init() {}
    
    
    func okayAlert(
        on VC: UIViewController,
        title: String,
        msg: String,
        btnTitle: String = "OK",
        btnAction: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: btnTitle, style: .default) { _ in
            btnAction?()
        }
        alert.addAction(action)
        VC.present(alert, animated: true)
        
    }

    
    func classicAlert(
        on VC: UIViewController,
        title: String,
        msg: String,
        yesBtnTitle: String = "Yes",
        yesBtnAction: (() -> Void)? = nil,
        cancelTitle: String = "Cancel",
        cancelBtnAction: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default) { _ in
            cancelBtnAction?()
        }
        let action = UIAlertAction(title: yesBtnTitle, style: .default) { _ in
            yesBtnAction?()
        }
        alert.addAction(cancelAction)
        alert.addAction(action)

        VC.present(alert, animated: true)
        
    }
    
    
}
