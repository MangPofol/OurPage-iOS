//
//  RuleViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/22.
//

import UIKit

import RxSwift
import RxCocoa
import FFPopup

final class RuleViewController: UIViewController {
    
    var serviceRuleButton = SettingButton(title: "서비스 이용약관")
    var privacyRuleButton = SettingButton(title: "개인정보 처리 방침")
    private var lineView = UIView()
    var marketingRuleButton = SettingButton(title: "마케팅 정보 수신")
    
    private let disposeBag = DisposeBag()
    
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
        
        self.serviceRuleButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                self?.showRule(title: "서비스 이용약관")
            }
            .disposed(by: disposeBag)
        
        self.privacyRuleButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                self?.showRule(title: "개인정보 처리 방침")
            }
            .disposed(by: disposeBag)
        
        self.marketingRuleButton.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                self?.showRule(title: "마케팅 정보 수신")
            }
            .disposed(by: disposeBag)
    }
    
    private func showRule(title: String) {
        let view = RuleAlertView(title: title)
        let popup = FFPopup(contentView: view, showType: .slideInFromBottom, dismissType: .slideOutToBottom, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        let layout = FFPopupLayout(horizontal: .center, vertical: .bottom)
        
        popup.show(layout: layout)
        
        view.okayButton.rx.tap
            .bind {
                popup.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

final class RuleAlertView: UIView {
    var titleLabel = UILabel()
    var contentTextView = UITextView()
    var okayButton = CMButton()
    
    convenience init(title: String, frame: CGRect = .zero) {
        self.init(frame: frame)

        self.backgroundColor = .white
        self.topRoundCorner(radius: 10.adjustedHeight)
        self.snp.makeConstraints {
            $0.width.equalTo(Constants.screenSize.width)
            $0.height.equalTo(454.adjustedHeight)
        }
        
        self.addSubview(titleLabel)
        self.addSubview(contentTextView)
        self.addSubview(okayButton)
        
        self.titleLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.text = title
            $0.textAlignment = .left
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
        }
        
        switch title {
        case "서비스 이용약관", "개인정보 처리 방침":
            self.contentTextView.text = Constants.ServiceRule
        case "마케팅 정보 수신":
            self.contentTextView.text = Constants.MarketingRule
        default:
            return
        }
        
        self.contentTextView.then {
            $0.font = .defaultFont(size: 12, boldLevel: .regular)
            $0.textColor = UIColor(hexString: "646A88")
            $0.textContainerInset = .zero
            $0.textContainer.lineFragmentPadding = 0.0
            $0.isEditable = false
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.adjustedHeight)
        }
        
        self.okayButton.then {
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.defaultBackgroundColor = .mainColor
            $0.setCornerRadius(radius: 8.adjustedHeight)
            $0.titleLabel?.font = .defaultFont(size: 18, boldLevel: .bold)
        }.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(20.adjustedHeight)
            $0.height.equalTo(52.adjustedHeight)
            $0.left.right.equalToSuperview().inset(20.adjustedHeight)
            $0.bottom.equalToSuperview().inset(34.adjustedHeight)
        }
    }
}
