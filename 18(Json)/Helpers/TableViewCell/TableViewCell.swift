//
//  TableViewCell.swift
//  18(Json)
//
//  Created by Mark Goncharov on 07.09.2022.
//

import UIKit


class TableViewCell: UITableViewCell {
    
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var movieYearLabel: UILabel!
    @IBOutlet private var moviePosterImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    static let identifier = "TableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell",
                     bundle: nil)
    }
    
    func configure(with model: Movie) {
        self.movieTitleLabel.text = model.Title
        self.movieYearLabel.text = model.Year
        let url = model.Poster
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.moviePosterImageView.image = UIImage(data: data)
        }
    }
}
