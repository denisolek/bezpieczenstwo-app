//
//  Extensions.swift
//  bezpieczenstwo-app
//
//  Created by Denis Olek on 10.10.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import AES256CBC

func make32Chars(_text: String) -> String {
    return _text + String(repeating: "a", count: 32-_text.count)
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    func showAlertInfo(_title: String, _message: String) {
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertControllerStyle.alert)
        present(alert, animated: true, completion: nil)
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
    
    func decryptionErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong - its impossible to decrypt message", preferredStyle: UIAlertControllerStyle.alert)
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

extension String {
    func encrypt(_password: String) -> String {
        return AES256CBC.encryptString(self, password: make32Chars(_text: _password))!
    }
    
    func decrypt(_password: String) -> String {
        return AES256CBC.decryptString(self, password: make32Chars(_text: _password))!
    }
}
