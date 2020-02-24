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

	init(login: String, password: String, isNeedPinCode: Bool = false) {
		self.login = login
		self.password = password
		self.isNeedPinCode = isNeedPinCode
	}

	func changeLogin(_ newLogin: String) {

		if newLogin.count >= 3 && newLogin.count <= 20 {
			self.login = newLogin
		}
	}

	func changePassword(_ newPassword: String) {
		if newPassword.count >= 8 && newPassword.count <= 20 {
			self.password = newPassword
		}
	}

	func setNeedPinCode(_ need: Bool) {
		self.isNeedPinCode = need
	}

}
