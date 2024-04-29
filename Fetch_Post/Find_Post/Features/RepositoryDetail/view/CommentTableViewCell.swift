//
//  CommentTableViewCell.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

class CommentTableViewCell: UITableViewCell {
    @IBOutlet var userId: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var body: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    private func setupLayout() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true

        self.body.preferredMaxLayoutWidth = self.body.bounds.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(data: CommentItem?) {
        self.userId.text = AppConstants.userID + "\(data?.id ?? 0)"
        self.name.text = data?.name
        self.email.text = data?.email
        self.body.text = data?.body
    }
}
