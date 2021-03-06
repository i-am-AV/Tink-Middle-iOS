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
    var didValidateCredentials: ((Bool) -> Void)? { get set }

	func changeLogin(_ newLogin: String)
	func changePassword(_ newPassword: String)
	func setNeedPinCode(_ need: Bool)
}

class LoginScreenViewController: UIViewController {

	var viewModel: LoginScreenViewModelProtocol!

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
	@IBOutlet weak var pinCodeSwitcher: UISwitch!

    @IBAction func pinCodeSwitch(_ sender: Any) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = LoginScreenViewModel(login: "", password: "")

		validate()
    }

	func validate() {
		viewModel.didValidateCredentials = { [weak self] isValidated in
            self?.enterButton.isEnabled = isValidated
            self?.enterButton.alpha = isValidated ? 1.0 : 0.5
        }
	}

	@IBAction func tapOnScreen(_ sender: Any) {
		resignFirstResponder()
	}

    @IBAction func loginTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }

        viewModel.changeLogin(text)

		validate()
    }

    @IBAction func passwordTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }

        viewModel.changePassword(text)
		validate()
    }

	@IBAction func tapEnterButton(_ sender: UIButton) {
		if pinCodeSwitcher.isOn {
			performSegue(withIdentifier: "ToSetPinView", sender: self)
		} else {
			presentEmptyView()
		}
	}


	func presentEmptyView() {

		let viewController = UIViewController()
		viewController.view.backgroundColor = .lightText
		navigationController?.pushViewController(viewController, animated: true)
	}
}
