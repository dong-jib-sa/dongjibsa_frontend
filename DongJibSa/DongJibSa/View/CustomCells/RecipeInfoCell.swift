//
//  RecipeInfoCell.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/31.
//

import UIKit

class RecipeInfoCell: UITableViewCell {
    static let cellId: String = "RecipeInfoCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새우 부추전 파티원 모집합니다."
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    let writeDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.08.06."
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
//        label.text = "1시간 전"
        label.text = "방금"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    
    lazy var timeLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [writeDateLabel, timeLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "양배추랑 돼지고기가 많이 남는데 필요하신 분 있나요? 재료 나눔합니다~"
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 4)
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let recipeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피 정보"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "예상가: 25,000원"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let participantLabel: UILabel = {
        let label = UILabel()
        label.text = "파티원: 4명"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let pricePerPersonLabel: UILabel = {
        let label = UILabel()
        label.text = "1인당 예상 구매가: 6500원"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeInfoLabel, priceLabel, participantLabel, pricePerPersonLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let calorieInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "칼로리 정보"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    let calorieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "칼로리가 등록된 레시피에요"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let calorieDescriptionButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        return button
    }()
    
    let toolTipView = ToolTipView(title: "칼로리가 등록된 레시피는 평균 칼로리 계산 시 사용할 수 있습니다.")
    
    lazy var calorieDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calorieInfoLabel, calorieDescriptionLabel, calorieDescriptionButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupCell() {
        
        self.contentView.addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(timeLineStackView)
        cellView.addSubview(detailLabel)
        cellView.addSubview(descriptionStackView)
        cellView.addSubview(calorieDescriptionStackView)
        cellView.addSubview(toolTipView)
        
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(250)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        
        timeLineStackView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLineStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        
        descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        calorieInfoLabel.setContentHuggingPriority(.init(251), for: .horizontal)
        calorieInfoLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        calorieDescriptionLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        calorieDescriptionLabel.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        calorieDescriptionButton.setContentHuggingPriority(.init(251), for: .horizontal)
        calorieDescriptionButton.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        
        calorieDescriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionStackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        
        toolTipView.snp.makeConstraints { make in
            make.top.equalTo(calorieDescriptionStackView.snp.bottom)
            make.height.equalTo(60)
            make.width.equalTo(240)
        }
    }
}
