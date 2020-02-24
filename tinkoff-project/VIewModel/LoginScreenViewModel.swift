//
//  LoginScreenViewModel.swift
//  tinkoff-project
//
//  Created by Загид Гусейнов on 23.02.2020.
//  Copyright © 2020 Загид Гусейнов. All rights reserved.
//

import Foundation

class LoginScreenViewModel: LoginScreenViewModelProtocol {

	var login: String
	var password: String
	var isNeedPinCode: Bool

    var didValidateCredentials: ((Bool) -> Void)?

	init(login: String, password: String, isNeedPinCode: Bool = false) {
		self.login = login
		self.password = password
		self.isNeedPinCode = isNeedPinCode
	}

    func changeLogin(_ newLogin: String) {
        self.login = newLogin
        validateCredentials()
    }

    func changePassword(_ newPassword: String) {
        self.password = newPassword
        validateCredentials()
    }

	func setNeedPinCode(_ need: Bool) {
		self.isNeedPinCode = need
	}

    private func validateCredentials() {
        if login.count >= 3 && login.count <= 20 && password.count >= 8 && password.count <= 20 {
            didValidateCredentials?(true)
        } else {
            didValidateCredentials?(false)
        }
    }

}
