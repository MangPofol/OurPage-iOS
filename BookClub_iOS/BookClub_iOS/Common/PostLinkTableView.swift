//
//  PostLinkTableView.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/05/14.
//

import UIKit

class PostLinkTableView: SelfSizedTableView {
    var postHyperlink: [PostHyperlink] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(PostLinkTableViewCell.self, forCellReuseIdentifier: PostLinkTableViewCell.identifier)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
        self.separatorStyle = .none
        self.rowHeight = 27.1.adjustedHeight
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostLinkTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postHyperlink.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostLinkTableViewCell.identifier, for: indexPath) as! PostLinkTableViewCell
        
        cell.link = self.postHyperlink[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostLinkTableViewCell.identifier, for: indexPath) as! PostLinkTableViewCell
        
        guard let url = URL(string: cell.link?.hyperlink ?? "") else { return }
        UIApplication.shared.open(url)
    }
}

class PostLinkTableViewCell: UITableViewCell {
    static let identifier = "PostLinkTableViewCell"
    
    var linkView = WriteSettingItemView()
    
    var link: PostHyperlink? {
        didSet {
            guard let link = link else {
                return
            }
            
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
            let underlineAttributedString = NSAttributedString(string: link.hyperlinkTitle, attributes: underlineAttribute)
            
            self.linkView.label.attributedText = underlineAttributedString
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.contentView.addSubview(linkView)
        self.linkView.then {
            $0.iconView.image = .LinkIcon.withRenderingMode(.alwaysTemplate)
            $0.isUserInteractionEnabled = false
        }.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(7.0.adjustedHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
