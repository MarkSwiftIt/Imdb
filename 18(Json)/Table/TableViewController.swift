//
//  TableViewController.swift
//  18(Json)
//
//  Created by Mark Goncharov on 24.03.2022.
//

import Foundation
import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let identifier: String = "test identifier"

    var publishedAt: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }


    func configure() {
        publishedAt = UILabel(frame: .zero)
        self.contentView.addSubview(publishedAt)
        publishedAt.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(50)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


