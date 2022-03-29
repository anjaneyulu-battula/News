//
//  NewsListTableCell.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import UIKit

class NewsListTableCell: UITableViewCell {

    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(newsRowViewModel: NewsRowViewModel) {
        pointsLabel.text = "\(newsRowViewModel.points)"
        titleLabel.text = newsRowViewModel.title
        pointsLabel.textColor = newsRowViewModel.isFromTodayColor
        titleLabel.textColor = newsRowViewModel.isFromTodayColor
        backgroundColor = newsRowViewModel.isRead ? .lightGray : .white
    }
}
