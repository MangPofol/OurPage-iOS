//
//  CreateBookClubViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/08/05.
//

import UIKit
import SnapKit
import Then

class CreateBookClubViewController: UIViewController {
    lazy var customView = CreateBookClubView()
    lazy var underBarButton = UnderBarButton()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(customView)
        self.view.addSubview(underBarButton)
        underBarButton.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(Constants.screenSize.height / 12.5)
        }
        customView.snp.makeConstraints {
            $0.bottom.equalTo(underBarButton.snp.top)
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        customView.makeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .lightGray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        makeButtonsCircular(buttons: [customView.redButton, customView.blueButton, customView.greenButton])
        
    }
    
    private func makeButtonsCircular(buttons: [UIButton]) {
        buttons.forEach {
//            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = $0.frame.width/2
        }
    }
}

class CreateBookClubView: UIView {
    var titleLabel = UILabel().then {
        $0.text = Constants.createBookClubTitleText
    }
    
    var lineView = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: 1.0)).then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    var nameTextField = UITextField().then {
        $0.placeholder = "이름을 적어주세요."
        $0.textAlignment = .left
    }
    
    var colorLabel = UILabel().then {
        $0.text = "색상"
    }
    
    var colorDividerView = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: 1.0)).then {
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.gray.cgColor
    }
    
    var redButton = UIButton().then {
        $0.backgroundColor = .red
    }
    var greenButton = UIButton().then {
        $0.backgroundColor = .green
    }
    var blueButton = UIButton().then {
        $0.backgroundColor = .blue
    }
    
    var createButton = UIButton().then {
        $0.setTitle("생성하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.addSubview(lineView)
        self.addSubview(nameTextField)
        self.addSubview(colorLabel)
        self.addSubview(colorDividerView)
        self.addSubview(redButton)
        self.addSubview(greenButton)
        self.addSubview(blueButton)
        self.addSubview(createButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(Constants.screenSize.height / 10.0)
            $0.left.right.equalToSuperview().inset(Constants.screenSize.width / 20.0)
        }
        lineView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(Constants.screenSize.width / 20.0)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(Constants.screenSize.width / 20.0)
        }
        
        colorLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Constants.screenSize.height / 15.0)
            $0.left.right.equalToSuperview().inset(Constants.screenSize.width / 20.0)
        }
        colorDividerView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.top.equalTo(colorLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(Constants.screenSize.width / 20.0)
        }
        
        redButton.snp.makeConstraints {
            $0.height.width.equalTo(Constants.screenSize.width / 7.5)
            $0.top.equalTo(colorDividerView.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(Constants.screenSize.width / 20.0)
        }
        greenButton.snp.makeConstraints {
            $0.height.width.equalTo(Constants.screenSize.width / 7.5)
            $0.top.equalTo(colorDividerView.snp.bottom).offset(8)
            $0.left.equalTo(redButton.snp.right).offset(Constants.screenSize.width / 20.0)
        }
        blueButton.snp.makeConstraints {
            $0.height.width.equalTo(Constants.screenSize.width / 7.5)
            $0.top.equalTo(colorDividerView.snp.bottom).offset(8)
            $0.left.equalTo(greenButton.snp.right).offset(Constants.screenSize.width / 20.0)
        }
        createButton.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().inset(Constants.screenSize.width / 20.0)
        }
    }
}
