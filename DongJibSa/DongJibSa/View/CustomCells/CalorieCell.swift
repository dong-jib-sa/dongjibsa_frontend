//
//  CalorieCell.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/22.
//

import UIKit

class CalorieCell: UITableViewCell {
    static let cellId: String = "CalorieTableViewCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "칼로리 정보"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let calorieInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "칼로리가 등록된 레시피에요"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let descriptionButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        return button
    }()
    
    let toolTipView = ToolTipView(title: "칼로리가 등록된 레시피는 평균 칼로리 계산 시 사용할 수 있습니다.")
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, calorieInfoLabel, descriptionButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.contentView.addSubview(cellView)
        cellView.addSubview(stackView)
        cellView.addSubview(toolTipView)
        
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        calorieInfoLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        calorieInfoLabel.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        descriptionButton.setContentHuggingPriority(.init(251), for: .horizontal)
        descriptionButton.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
//        toolTipView.snp.makeConstraints { make in
//            make.top.equalTo(stackView.snp.bottom)
//            make.height.equalTo(60)
//            make.width.equalTo(240)
//        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
