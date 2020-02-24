//
//  LoginScreenViewController.swift
//  tinkoff-project
//
//  Created by Загид Гусейнов on 24.02.2020.
//  Copyright © 2020 Загид Гусейнов. All rights reserved.
//

import UIKit

protocol LoginScreenViewModelProtocol: class {
	var login: String { get }
	var password: String { get }
	var isNeedPinCode: Bool { get }

	func changeLogin(_ newLogin: String)
	func changePassword(_ newPassword: String)
	func setNeedPinCode(_ need: Bool)
}

class LoginScreenViewController: UIViewController {

	var viewModel: LoginScreenViewModelProtocol!

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBAction func pinCodeSwitch(_ sender: Any) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

		viewModel = LoginScreenViewModel(login: "", password: "")
    }

	@IBAction func tapOnScreen(_ sender: Any) {
		resignFirstResponder()
	}

}

extension LoginScreenViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let text = textField.text else {
			return
		}
		switch textField {
		case loginTextField:
			viewModel.changeLogin(text)
		case passwordTextField:
			viewModel.changePassword(text)
		default:
			break
		}
	}
}
