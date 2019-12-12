//
//  FormTextField.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 12/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class FormTextField: UITextField {
    let padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

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
