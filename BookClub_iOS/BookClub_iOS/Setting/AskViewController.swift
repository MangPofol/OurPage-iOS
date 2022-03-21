//
//  AskViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2022/02/22.
//

import UIKit

import MessageUI
import RxSwift

final class AskViewController: UIViewController {
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    var emailButtonImageView = UIImageView()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        self.title = "1:1 문의 / 요청"
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(contentLabel)
        self.view.addSubview(emailButtonImageView)
        
        self.titleLabel.then {
            $0.font = .defaultFont(size: 16, boldLevel: .bold)
            $0.textColor = .mainColor
            $0.text = "Contact us"
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(245.adjustedHeight)
        }
        
        self.contentLabel.then {
            $0.font = .defaultFont(size: 12, boldLevel: .light)
            $0.textColor = .mainColor
            $0.numberOfLines = 2
            $0.text = "Our page 사용 중 문의사항이 있다면\n언제든지 편하게 문의해주세요!"
            $0.textAlignment = .center
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20.adjustedHeight)
        }
        
        self.emailButtonImageView.then {
            $0.image = UIImage(named: "EmailSendImage")
            $0.contentMode = .scaleAspectFit
        }.snp.makeConstraints {
            $0.width.equalTo(126.adjustedHeight)
            $0.height.equalTo(32.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(15.5.adjustedHeight)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailButtonImageView.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                if MFMailComposeViewController.canSendMail() {
                    
                    let compseVC = MFMailComposeViewController()
                    compseVC.mailComposeDelegate = self
                    
                    compseVC.setToRecipients(["ourpageapp@gmail.com"])
                    compseVC.setSubject("")
                    compseVC.setMessageBody("", isHTML: false)
                    
                    self.present(compseVC, animated: true, completion: nil)
                    
                }
                else {
                    self.showSendMailErrorAlert()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func showSendMailErrorAlert() {
            let sendMailErrorAlert = UIAlertController(title: "메일을 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) {
                (action) in
                print("확인")
            }
            sendMailErrorAlert.addAction(confirmAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
}

extension AskViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
