//
//  FormTextField.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 12/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class FormTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    func setupUI() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.autocorrectionType = .no
    }

}
