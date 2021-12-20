//
//  PagesViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/06.
//

import UIKit
import Pageboy
import RxSwift

class PagesViewController: PageboyViewController {
    
    var pageImages: [UIImage]!
    var chooseIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.view.backgroundColor = .black
        
        self.transition = Transition(style: .push, duration: 1.0)
    }
    
    func viewControllerAtIndex(index : Int) -> ImagePreviewContentViewController {
        let vc = ImagePreviewContentViewController()
        vc.index = index
        vc.image = self.pageImages[index]
        vc.disposeBag = DisposeBag()
        return vc
    }
}

extension PagesViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        pageImages.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllerAtIndex(index: index)
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        .at(index: chooseIdx)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return chooseIdx
    }
}

class ImagePreviewContentViewController: UIViewController {
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var closeButton = UIButton().then {
        $0.backgroundColor = .red
    }
    
    var index: Int!
    var image: UIImage!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        self.view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.getAdjustedHeight(51.0))
            $0.right.equalToSuperview().inset(Constants.getAdjustedWidth(21.0))
            $0.width.height.equalTo(Constants.getAdjustedWidth(15.0))
        }
        imageView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(Constants.getAdjustedWidth(27.0))
            $0.top.equalTo(closeButton.snp.bottom).offset(Constants.getAdjustedHeight(50.0))
            $0.bottom.equalToSuperview().inset(Constants.getAdjustedHeight(20.0))
        }
        self.imageView.image = image
        
        closeButton.rx.tap
            .bind { [weak self] in
                self?.parent?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
    }
}
