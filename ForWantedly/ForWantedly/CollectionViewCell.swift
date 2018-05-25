//
//  CollectionViewCell.swift
//  ForWantedly
//
//  Created by 石黒晴也 on 2018/05/24.
//  Copyright © 2018年 Haruya Ishiguro. All rights reserved.
//

import UIKit

class CollectionViewCell : UICollectionViewCell{
    
    var textLabel : UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UILabelを生成.
        textLabel = UILabel(frame: CGRect(x:0, y:0, width:frame.width, height:frame.height))
        textLabel?.text = "nil"
        textLabel?.textAlignment = NSTextAlignment.center
        textLabel?.layer.backgroundColor = Style().white.cgColor
        textLabel?.layer.cornerRadius = 30
        
        // Cellに追加.
        self.contentView.addSubview(textLabel!)
    }
    
}
