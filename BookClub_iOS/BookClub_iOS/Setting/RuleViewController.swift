//
//  RuleViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/22.
//

import UIKit

final class RuleViewController: UIViewController {
    
    var serviceRuleButton = SettingButton(title: "서비스 이용약관")
    var privacyRuleButton = SettingButton(title: "개인정보 처리 방침")
    private var lineView = UIView()
    var marketingRuleButton = SettingButton(title: "마케팅 정보 수신")
    
    override func loadView() {
        self.view = UIView()
        self.title = "이용약관"
        self.view.backgroundColor = .white
        
        self.view.addSubview(serviceRuleButton)
        self.view.addSubview(privacyRuleButton)
        self.view.addSubview(lineView)
        self.view.addSubview(marketingRuleButton)
        
        self.serviceRuleButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.privacyRuleButton.snp.makeConstraints {
            $0.top.equalTo(serviceRuleButton.snp.bottom).inset(1.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.lineView.then {
            $0.backgroundColor = UIColor(hexString: "EFF0F3")
        }.snp.makeConstraints {
            $0.top.equalTo(privacyRuleButton.snp.bottom).offset(6.adjustedHeight)
            $0.height.equalTo(1.13)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        self.marketingRuleButton.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(6.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
