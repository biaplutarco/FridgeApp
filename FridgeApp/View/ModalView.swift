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
        let colorName = "Red"
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
    
    lazy var productDays: String = {
        let days = "expiry date"
        return days
    }()
    
    lazy var iconCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: ModalCollectionFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: "IconCell")
        
        return collectionView
    }()
    
    lazy var colorCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: ModalCollectionFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "ColorCell")
        
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addProduct(_:)), for: .touchUpInside)
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
    
    @objc func addProduct(_ sender: UIButton) {
        let iconName = icons[lastIconIndexPath.row]
        print("colocar um alert aqui pra pessoa nao poder passar sem colocar imagem e cor")
        print("red button tapped")
        delegate?.saveProductWith(title: productTitle, expiryDate: productDays, colorName: selectedColorName, andIconName: iconName)
        print(productDays)
        print(productTitle)
        print(selectedColorName)
        print(iconName)
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
        if collectionView === iconCollectionView {
            guard let color = UIColor.init(named: selectedColorName),
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as? IconCell,
                  let icon = UIImage.init(named: icons[indexPath.row]) else { return UICollectionViewCell() }
            cell.setUpCellWith(image: icon, andSelectedColor: color)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as? ColorCell,
                  let color = UIColor.init(named: colors[indexPath.row]) else { return UICollectionViewCell() }
            cell.setUpCellWith(color: color)
            
            return cell
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? InputCell else { return }
        if indexPath.row == 1 {
            guard let text = cell.textField.text else { return }
            productDays = text
        } else {
            guard let text = cell.textField.text else { return }
            productTitle = text
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/2
    }
}
