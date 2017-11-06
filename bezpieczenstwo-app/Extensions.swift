//
//  Extensions.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 10.10.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    func showAlertOK(_title: String, _message: String) {
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func invalidTokenAlert() {
        let alert = UIAlertController(title: "Error", message: "Access token expired", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_: UIAlertAction!) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginView")
            self.present(loginVC, animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func userCreatedAlert() {
        let alert = UIAlertController(title: "Created", message: "You can log in now!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_: UIAlertAction!) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginView")
            self.present(loginVC, animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension UIButton {
    func setupBackButton() {
        titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
        setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
    }
}
