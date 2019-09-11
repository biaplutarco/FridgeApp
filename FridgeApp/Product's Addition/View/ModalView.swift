//
//  ModalView.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ModalView: UIView {
    weak var delegate: ModalViewDelegate?
    
    lazy var icons: [String] = {
        let icons = PListData.readPropertyList(resource: "IconPList")
        return icons
    }()
    
    lazy var colors: [String] = {
        let colors = PListData.readPropertyList(resource: "ColorPList")
        return colors
    }()
    
    lazy var selectedColorName: String = {
        let colorName = "ActionColor"
        return colorName
    }()
    
    lazy var lastIconIndexPath: IndexPath = {
        let indexPath = IndexPath()
        return indexPath
    }()
    
    lazy var productTitle: String = {
        let title = "Title"
        return title
    }()
    
    lazy var expiryDate: Date = {
        let date = Date()
        return date
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    lazy var iconCollectionView: ModalCollectionView = {
        let collectionView = ModalCollectionView(registerCellOfType: IconCell.self, isStatic: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var colorCollectionView: ModalCollectionView = {
        let collectionView = ModalCollectionView(registerCellOfType: ColorCell.self, isStatic: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tableView.register(InputCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    lazy var redButton: TextRedButton = {
        let button = TextRedButton()
        button.setTitle("Colocar", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configView()
        addSubviews()
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(iconCollectionView)
        addSubview(colorCollectionView)
        addSubview(tableView)
        addSubview(redButton)
    }
    
    private func configView() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        let product = createProduct()
        delegate?.saveProduct(product)
    }
    
    private func createProduct() -> Product {
        let imageName = "Cut\(icons[lastIconIndexPath.row])"
        let titleIndex = IndexPath(row: 0, section: 0)
        let dateIndex = IndexPath(row: 1, section: 0)
        let product = Product(context: Product.context)
        product.color = selectedColorName
        product.image = imageName
        
        if let titleCell = tableView.cellForRow(at: titleIndex) as? InputCell,
            let text = titleCell.textField.text {
            product.title = text
        }
        
        if let dateCell = tableView.cellForRow(at: dateIndex) as? InputCell, let text = dateCell.textField.text,
            let date = dateFormatter.date(from: text) {
            product.days = date
        }
        
        return product
    }
    
    private func cellForCollectionView(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === iconCollectionView {
            guard let image = UIImage.init(named: icons[indexPath.row]), let color = UIColor.init(named: selectedColorName)
                else { fatalError() }
            
            let cell = collectionView.dequeueCell(of: IconCell.self, forIndexPath: indexPath)
            cell.setUpCellWith(image: image, andSelectedColor: color)
            
            return cell
        } else {
            let cell = collectionView.dequeueCell(of: ColorCell.self, forIndexPath: indexPath)
            guard let color = UIColor.init(named: colors[indexPath.row]) else { fatalError() }
            cell.setUpCellWith(color: color)
            
            return cell
        }
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            iconCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            iconCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            iconCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
            ])
        
        NSLayoutConstraint.activate([
            colorCollectionView.topAnchor.constraint(equalTo: iconCollectionView.bottomAnchor),
            colorCollectionView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            colorCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorCollectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
            ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: colorCollectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            tableView.heightAnchor.constraint(equalTo: iconCollectionView.heightAnchor, multiplier: 1.2)
            ])
        
        NSLayoutConstraint.activate([
            redButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            redButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            redButton.heightAnchor.constraint(equalTo: iconCollectionView.heightAnchor, multiplier: 0.5),
            redButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            ])
    }
}

extension ModalView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === iconCollectionView {
            return icons.count
        } else {
            return colors.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForCollectionView(collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        if collectionView === iconCollectionView {
            guard let iconCell = iconCollectionView.cellForItem(at: indexPath) as? IconCell,
                  let color = UIColor.init(named: selectedColorName) else { return }
            iconCell.imageView.tintColor = color
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            lastIconIndexPath = indexPath
        } else {
            guard let iconCell = iconCollectionView.cellForItem(at: lastIconIndexPath) as? IconCell,
                  let color = UIColor.init(named: colors[indexPath.row]) else { return }

            iconCell.imageView.tintColor = color
            selectedColorName = colors[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform.identity
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = CGFloat(32)
        let iconHeight = iconCollectionView.frame.height/1.2 - insets
        let colorHeight = colorCollectionView.frame.height - insets
        
        if collectionView === iconCollectionView {
            return CGSize(width: iconHeight, height: iconHeight)
        } else {
            return CGSize(width: colorHeight, height: colorHeight)
        }
    }
}

extension ModalView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? InputCell else { return UITableViewCell() }
        cell.setUpCellWith(title: "Title", placeholder: "title", withDatePicker: false)
        
        if indexPath.row == 1 {
            cell.setUpCellWith(title: "Expiry date", placeholder: "expiry date", withDatePicker: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/2
    }
}
