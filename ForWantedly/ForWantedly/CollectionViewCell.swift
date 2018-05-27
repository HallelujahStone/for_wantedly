
import UIKit

class CollectionViewCell : UICollectionViewCell{
    
    var card: UILabel!
    
    var looking_for: UILabel!
    var title: UILabel!
    var imageView: UIImageView!
    var compAvatarView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let margin_left: CGFloat   = 10
        let margin_top:  CGFloat   = 20
        let lfHeight:    CGFloat = 30
        let ttHeight:    CGFloat = 50
        let imHeight:    CGFloat = (frame.width-margin_left*2)*(131/320)
        let avHeight:    CGFloat = 60
        
        // card(Cellの背景部分)を定義
        card = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        card.layer.backgroundColor = Style().white.cgColor
        card.layer.cornerRadius = 30
        
        //
        looking_for = UILabel(frame: CGRect(x: margin_left, y: margin_left, width: 100, height: lfHeight))
        looking_for.font = UIFont.systemFont(ofSize: 12)
        //
        title = UILabel(frame: CGRect(x: margin_left, y: lfHeight+margin_top, width: frame.width-margin_left*2, height: ttHeight))
        title.numberOfLines = 2
        
        //
        imageView = UIImageView(frame: CGRect(x: margin_left, y: lfHeight+ttHeight+margin_top*2 , width: frame.width-margin_left*2, height: imHeight))
        
        //
        compAvatarView = UIImageView(frame: CGRect(x: margin_left, y: lfHeight+ttHeight+imHeight+margin_top*3 , width: avHeight, height: avHeight))
        
        // Cell内の各要素をわかりやすく着色する関数
        //background()
        
        // Cellに追加
        self.contentView.addSubview(card)
        self.contentView.addSubview(looking_for)
        self.contentView.addSubview(title)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(compAvatarView)
    }
    
    // Cell内の各要素をわかりやすく着色する関数
    func background(){
        looking_for.backgroundColor = Style().background
        title.backgroundColor = Style().background
    }
    
}
