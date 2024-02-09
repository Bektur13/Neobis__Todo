//
//  CustomTableViewCell.swift
//  TodoApp
//
//  Created by Бектур Дуйшембеков on 2/7/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var doneTask = false
    weak var delegate: TaskCellDelegate?
    var isEditingMode = false
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
//        title.text = "Hello world"
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return title
    }()
    
    lazy var descriptionLabel: UILabel = {
       let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.numberOfLines = 0
        return description
    }()
    
    lazy var isDone: UIButton = {
       let button = UIButton()
        return button
    }()
    
    lazy var checkImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "circle"))
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(red: 240 / 255, green: 158 / 255 , blue: 30 / 255, alpha: 1)
        return image
    }()
    
    lazy var infoImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "info.circle"))
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.systemBlue
        return image
    }()
    
    lazy var arrowImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.lightGray
        return image
    }()
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraint()
        isDone.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        selectionStyle = .none
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        let fittingSize = CGSize(width: targetSize.width, height: UIView.layoutFittingCompressedSize.height)
        return contentView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
    
    func setUpConstraint() {
        contentView.addSubview(infoImage)
        contentView.addSubview(arrowImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(isDone)
        isDone.addSubview(checkImage)
        
        [titleLabel, descriptionLabel, isDone, infoImage, arrowImage, checkImage].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            isDone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            isDone.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            isDone.heightAnchor.constraint(equalToConstant: 22),
            isDone.widthAnchor.constraint(equalToConstant: 22),
            checkImage.centerXAnchor.constraint(equalTo: isDone.centerXAnchor),
            checkImage.centerYAnchor.constraint(equalTo: isDone.centerYAnchor),
            checkImage.heightAnchor.constraint(equalToConstant: 22),
            checkImage.widthAnchor.constraint(equalToConstant: 22),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 20),
            arrowImage.widthAnchor.constraint(equalToConstant: 20),
            
            infoImage.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -8),
            infoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoImage.heightAnchor.constraint(equalToConstant: 28),
            infoImage.widthAnchor.constraint(equalToConstant: 28),
            
            titleLabel.leadingAnchor.constraint(equalTo: isDone.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: infoImage.leadingAnchor, constant: -8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: isDone.trailingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: infoImage.leadingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)        ])
    }
    
    @objc func donePressed() {
        checkImage.image = UIImage(systemName: doneTask ? "circle" : "checkmark.circle")
        doneTask.toggle()
        delegate?.taskCellDidToggleDone(for: self)
    }
    
    func setEditingMode(_ isEditing: Bool) {
        isEditingMode = isEditing
        infoImage.isHidden = isEditing
        arrowImage.isHidden = isEditing
    }
    
    func configureCell(title: String, description: String, isDone: Bool, image: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        doneTask = isDone
        checkImage.image = UIImage(systemName: image)
    }
    
    lazy var view: UIView = {
        let cellView = UIView()
        cellView.backgroundColor = .white
        return cellView
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
