//
//  RespositoryListCell.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 18/01/22.
//

import UIKit

class RespositoryListCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    
    @IBOutlet weak var projectNameLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var authorProfileImageView: UIImageView!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    
    var cellViewModel: RepositoryCellViewModel? {
        didSet {
            projectNameLabel.attributedText = cellViewModel?.repoName.parseStringByColon()
            authorNameLabel.attributedText = cellViewModel?.authorName.parseStringByColon()
            languageLabel.attributedText = cellViewModel?.language.parseStringByColon()
            if let imgUrl = cellViewModel?.userImageUrl {
                authorProfileImageView.load(url:imgUrl)
            }
            
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        authorProfileImageView.layer.cornerRadius = authorProfileImageView.frame.size.height / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.accessoryType = .disclosureIndicator
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}



