//
//  StartScreenCell.swift
//  AliloBunny
//
//  Created by Андрей on 9.9.22.
//

import UIKit

class StartScreenCell: UITableViewCell {
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var customContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUIForContentView()
    }
}

extension StartScreenCell {
    func setCell(number: Int) {
        numberLabel.text = String(number)
    }
    
    func selectCell() {
        UIView.animate(withDuration: 0.3) {
            if self.isSelected {
                self.customContentView.backgroundColor = UIColor.systemBlue
                self.customContentView.layer.shadowColor = UIColor.blue.cgColor
                self.customContentView.layer.shadowOpacity = 0.7
                self.numberLabel.textColor = UIColor.white
            } else {
                self.customContentView.backgroundColor = UIColor.white
                self.customContentView.layer.shadowColor = UIColor.black.cgColor
                self.customContentView.layer.shadowOpacity = 0.3
                self.numberLabel.textColor = UIColor.black
            }
            
            self.customContentView.backgroundColor = self.isSelected ? UIColor.systemBlue : UIColor.white
            self.numberLabel.textColor = self.isSelected ? UIColor.white : UIColor.black
        }
    }
}

private extension StartScreenCell {
    func configUIForContentView() {
        customContentView.layer.cornerRadius = customContentView.frame.height * 0.3
        customContentView.layer.shadowColor = UIColor.black.cgColor
        customContentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        customContentView.layer.shadowRadius = 3
        customContentView.layer.shadowOpacity = 0.3
    }
}
