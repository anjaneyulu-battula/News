//
//  NewsListTableCell.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import UIKit
import Combine

class NewsListTableCell: UITableViewCell {

    private var disposables = Set<AnyCancellable>()

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

        newsRowViewModel.$isFromTodayColor
            .sink {[weak self] resultColor in
                guard let weakSelf = self else { return }
                weakSelf.pointsLabel.textColor = resultColor
                weakSelf.titleLabel.textColor = resultColor
            }
            .store(in: &disposables)

        backgroundColor = newsRowViewModel.isReadColor
    }
}
