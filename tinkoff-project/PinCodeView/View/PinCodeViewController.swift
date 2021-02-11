//
//  PinCodeViewController.swift
//  tinkoff-project
//
//  Created by Darya Viter on 24/02/2020.
//  Copyright © 2020 Загид Гусейнов. All rights reserved.
//

import UIKit

protocol PinCodeViewModelPrototcol: class {

	var isHasAPinCode: Bool { get }

	func setNumInPinCode(_ num: String)
	func checkPinCodeStatus(_ senderName: String)

	func deleteLastNumberInPinCode()
	func cancel()
}

class PinCodeViewController: UIViewController {

	var isFirstPinCodeEnter = true {
		didSet {
			enterPinLabel.text = "Подтвердите пин-код"
		}
	}
	var pinCodeNumbers: String = "" {
		didSet {
			enteredPinCodeLabel.text? = pinCodeNumbers
		}
	}

	private var model: PinCodeViewModelPrototcol!

	// MARK: - IBOutlet
	@IBOutlet var numButtons: [UIButton]!
	@IBOutlet weak var enterPinLabel: UILabel!
	@IBOutlet weak var doneOrSingInButton: UIButton!
	@IBOutlet weak var enteredPinCodeLabel: UILabel!

	// MARK: - LifeCicle
	override func viewDidLoad() {
		super.viewDidLoad()

		model = PinCodeViweModel(view: self)

		setupViews()
	}

	// MARK: - Actions

	@IBAction func tapNumButton(_ sender: UIButton) {

		guard let number = sender.titleLabel?.text else { return }
		model.setNumInPinCode(number)
	}

	@IBAction func tapSingInButton(_ sender: Any) {

		guard let buttonLabel = doneOrSingInButton.titleLabel?.text else {
			return }
		model.checkPinCodeStatus(buttonLabel)
	}

	@IBAction func tapDeleteButton(_ sender: Any) {
		model.deleteLastNumberInPinCode()
	}

	@IBAction func tapCancelButton(_ sender: Any) {
		model.cancel()
	}
}

// MARK: - Private
extension PinCodeViewController {

	private func setupViews() {
		doneOrSingInButton.setTitle(model.isHasAPinCode ? "Войти" : "Done", for: .normal)
		enteredPinCodeLabel.text = ""

		numButtons.forEach { view in
			self.drawCircle(rect: view.frame, view: view)
		}
	}
	private func drawCircle(rect: CGRect, view: UIButton) {

		view.layer.cornerRadius = 25
		view.layer.borderWidth = 1
		view.layer.borderColor = UIColor.blue.cgColor
	}
}

extension PinCodeViewController: PinCodeViewProtocol {

	func changeSingInButton() {
		doneOrSingInButton.setTitle("Войти", for: .normal)
	}

	func makeDoneButtonActive() {
		guard let buttonText = doneOrSingInButton.titleLabel?.text,
		buttonText == "Done"
		else { return }
	}

	func shakeButtons() {
		numButtons.forEach { view in
			let animationKeyPath = "transform.translation.x"
			let shakeAnimation = "shake"
			let duration = 0.6
			let animation = CAKeyframeAnimation(keyPath: animationKeyPath)
			animation.timingFunction = CAMediaTimingFunction(name: .linear)
			animation.duration = duration
			animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
			view.layer.add(animation, forKey: shakeAnimation)
		}
	}

	func presentEmptyView() {
		
		let viewController = UIViewController()
		viewController.view.backgroundColor = .lightText 
		navigationController?.pushViewController(viewController, animated: true)
	}
}
