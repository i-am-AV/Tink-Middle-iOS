//
//  PinCodeViewModel.swift
//  tinkoff-project
//
//  Created by Darya Viter on 24/02/2020.
//  Copyright © 2020 Загид Гусейнов. All rights reserved.
//

import Foundation

protocol PinCodeViewProtocol: class {

	var pinCodeNumbers: String { get set }
	var isFirstPinCodeEnter: Bool { get set }

	func makeDoneButtonActive()
	func shakeButtons()
	func presentEmptyView()
	func changeSingInButton()
}

class PinCodeViweModel {

	var isHasAPinCode: Bool
	var tempPinCode: String = ""
	private weak var view: PinCodeViewProtocol?
	private var pinCode: String
	private var userDefKey = "isHasPinCode"

	init(view: PinCodeViewProtocol) {
		self.isHasAPinCode = false
		self.pinCode = ""
		self.view = view
	}
}

// MARK: - Private
extension PinCodeViweModel {

	private func check() -> Bool {

		if tempPinCode == self.pinCode {
			return true
		} else {
			return false
		}
	}

	private func userCanSingIn() {

		if isHasAPinCode {
			if check() {
				clear()
				view?.presentEmptyView()
			} else {
				clear()
				view?.shakeButtons()
			}
		}
	}

	private func clear() {
		view?.pinCodeNumbers = ""
		tempPinCode = ""
	}

	private func setPinCode() {

		isHasAPinCode = true
		pinCode = tempPinCode
		tempPinCode = ""

		view?.pinCodeNumbers = ""
		view?.changeSingInButton()

		print(self.pinCode)

		UserDefaults.standard.set(true, forKey: userDefKey)
	}

}

extension PinCodeViweModel: PinCodeViewModelPrototcol {

	func setNumInPinCode(_ num: String) {
		tempPinCode += num
		view?.pinCodeNumbers += "*"
	}

	func checkPinCodeStatus(_ senderName: String) {
		if senderName == "Войти" {
			userCanSingIn()
		} else if senderName == "Done" && view?.isFirstPinCodeEnter ?? false {
			setPinCode()
			view?.isFirstPinCodeEnter = false
		}
	}

	func deleteLastNumberInPinCode() {
		tempPinCode.removeLast()
		view?.pinCodeNumbers.removeLast()
	}

	func cancel() {
		view?.pinCodeNumbers = ""
		// TODO: return to main view
	}

}
