//
//  PinCodeViewController.swift
//  tinkoff-project
//
//  Created by Darya Viter on 24/02/2020.
//  Copyright © 2020 Загид Гусейнов. All rights reserved.
//

import UIKit

class PinCodeViewController: UIViewController {

	@IBOutlet var numButtons: [UIButton]!

	override func viewDidLoad() {
        super.viewDidLoad()

		numButtons.forEach { view in
			self.drawCircle(rect: view.frame, view: view)
		}
		print("end")
    }
}

extension PinCodeViewController {

	private func drawCircle(rect: CGRect, view: UIButton) {

		view.layer.cornerRadius = 25
		view.layer.borderWidth = 1
		view.layer.borderColor = UIColor.blue.cgColor

	}
}
