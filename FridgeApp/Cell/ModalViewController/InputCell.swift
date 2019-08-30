//
//  InputCell.swift
//  FridgeApp
//
//  Created by Bia on 26/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        textField.text = dateFormatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func setUpCellWith(title: String, placeholder: String, withDatePicker: Bool) {
        label.text = title
        textField.placeholder = placeholder
        if withDatePicker == true {
            textField.inputView = datePicker
        }
    }
    
    private func addSubviews() {
        addSubview(label)
        addSubview(textField)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ])
    }
}
