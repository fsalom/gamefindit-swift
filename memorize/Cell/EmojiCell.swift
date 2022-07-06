//
//  CollectionViewCell.swift
//  memorize
//
//  Created by Fernando Salom Carratala on 23/6/22.
//

import UIKit

class EmojiCell: UICollectionViewCell {
  @IBOutlet weak var emojiLabel: UILabel!
  @IBOutlet weak var emojiView: UIView!
  var emoji = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }

  func setupUI(){
    emojiView.layer.cornerRadius = 5.0
    emojiView.layer.borderWidth = 1.0
    emojiView.layer.borderColor = UIColor.black.cgColor
    emojiLabel.text = emoji
  }

}
