
import UIKit

class CollectionViewCell : UICollectionViewCell{
    
    // 下地となるUILabel
    var card: UILabel!
    
    // CellにJSONから取得した要素を表示するView
    var looking_for:        UILabel!
    var title:              UILabel!
    var imageView:          UIImageView!
    var compAvatarView:     UIImageView!
    var compName:           UILabel!
    var supportImageView:   UIImageView!
    var supportCount:       UILabel!
    var candidateImageView: UIImageView!
    var candidateCount:     UILabel!
    var staffing_leader:    UIImageView!
    var staffing_2:         UIImageView!
    var staffing_3:         UIImageView!
    var staffing_4:         UIImageView!
    var staffing_5:         UIImageView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let margin_left: CGFloat   = 10 // 各要素とcardとの左のマージン
        let margin_top:  CGFloat   = 10 // 各要素の上のマージン
        let margin_edge: CGFloat   = 20 // 上下端のマージン
        
        // card(Cellの背景部分)表示部分
        card                       = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        card.layer.backgroundColor = Style().white.cgColor
        card.layer.cornerRadius    = 30
        card.layer.shadowOffset    = CGSize(width: 10.0, height: 10.0)
        card.layer.shadowOpacity   = 0.2
        card.layer.shadowRadius    = 5.0
        self.contentView.addSubview(card)
        
        // looking_for表示部分
        let lfHeight: CGFloat         = 20
        looking_for                   = UILabel(frame: CGRect(x: margin_left, y: margin_left+margin_edge, width: frame.width/2, height: lfHeight))
        looking_for.font              = UIFont.systemFont(ofSize: 16)
        looking_for.textColor         = Style().gold
        looking_for.layer.borderColor = Style().gold.cgColor
        looking_for.layer.borderWidth = 1
        self.contentView.addSubview(looking_for)
        
        // title表示部分
        let ttHeight: CGFloat = 65
        title                 = UILabel(frame: CGRect(x: margin_left, y: lfHeight+margin_top+margin_edge, width: frame.width-margin_left*2, height: ttHeight))
        title.numberOfLines   = 3
        title.font            = UIFont.boldSystemFont(ofSize: 22)
        self.contentView.addSubview(title)
        
        // image表示部分
        let imHeight: CGFloat = (frame.width-margin_left*2)*(131/320)
        imageView             = UIImageView(frame: CGRect(x: margin_left, y: lfHeight+ttHeight+margin_top*3+margin_edge, width: frame.width-margin_left*2, height: imHeight))
        self.contentView.addSubview(imageView)
        
        // avatar表示部分
        let avHeight: CGFloat  = 60
        compAvatarView         = UIImageView(frame: CGRect(x: margin_left, y: lfHeight+ttHeight+imHeight+margin_top*5+margin_edge, width: avHeight, height: avHeight))
        compName               = UILabel(frame: CGRect(x: margin_left+avHeight+5, y: lfHeight+ttHeight+imHeight+margin_top*5+margin_edge, width: 80, height: avHeight))
        compName.font          = UIFont.systemFont(ofSize: 10)
        compName.numberOfLines = 3
        self.contentView.addSubview(compAvatarView)
        self.contentView.addSubview(compName)
        
        // support表示部分
        let suHeight: CGFloat      = 30
        supportImageView           = UIImageView(frame: CGRect(x: frame.width-margin_left-suHeight*4+5, y: lfHeight+ttHeight+imHeight+margin_top*7+margin_edge, width: suHeight, height: suHeight))
        supportImageView.image     = UIImage(named: "baseline_thumb_up_white_24pt")
        supportImageView.tintColor = Style().gray
        supportCount               = UILabel(frame: CGRect(x: frame.width-margin_left-suHeight*3+5, y: lfHeight+ttHeight+imHeight+margin_top*7+margin_edge, width: suHeight, height: suHeight))
        supportCount.textColor     = Style().gray
        self.contentView.addSubview(supportImageView)
        self.contentView.addSubview(supportCount)
        
        // candidate表示部分
        candidateImageView           = UIImageView(frame: CGRect(x: frame.width-margin_left-suHeight*2+5, y: lfHeight+ttHeight+imHeight+margin_top*7+margin_edge, width: suHeight, height: suHeight))
        candidateImageView.image     = UIImage(named: "baseline_group_white_24pt")
        candidateImageView.tintColor = Style().gray
        candidateCount               = UILabel(frame: CGRect(x: frame.width-margin_left-suHeight+5, y: lfHeight+ttHeight+imHeight+margin_top*7+margin_edge, width: suHeight, height: suHeight))
        candidateCount.textColor     = Style().gray
        self.contentView.addSubview(candidateImageView)
        self.contentView.addSubview(candidateCount)
        
        // staffing表示部分
        let sfHeight: CGFloat     = 45
        staffing_leader           = UIImageView(frame: CGRect(x: margin_left, y: frame.height-avHeight-margin_edge, width: avHeight, height: avHeight))
        staffing_2                = UIImageView(frame: CGRect(x: margin_left+avHeight, y: frame.height-sfHeight-margin_edge, width: sfHeight, height: sfHeight))
        staffing_3                = UIImageView(frame: CGRect(x: margin_left+avHeight+suHeight, y: frame.height-sfHeight-margin_edge, width: sfHeight, height: sfHeight))
        staffing_4                = UIImageView(frame: CGRect(x: margin_left+avHeight+suHeight*2, y: frame.height-sfHeight-margin_edge, width: sfHeight, height: sfHeight))
        staffing_5                = UIImageView(frame: CGRect(x: margin_left+avHeight+suHeight*3, y: frame.height-sfHeight-margin_edge, width: sfHeight, height: sfHeight))
        staffing_leader.image     = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_2.image          = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_3.image          = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_4.image          = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_5.image          = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_leader.tintColor = Style().background
        staffing_2.tintColor      = Style().background
        staffing_3.tintColor      = Style().background
        staffing_4.tintColor      = Style().background
        staffing_5.tintColor      = Style().background
        staffing_leader.isHidden  = true
        staffing_2.isHidden       = true
        staffing_3.isHidden       = true
        staffing_4.isHidden       = true
        staffing_5.isHidden       = true
        self.contentView.addSubview(staffing_leader)
        self.contentView.addSubview(staffing_2)
        self.contentView.addSubview(staffing_3)
        self.contentView.addSubview(staffing_4)
        self.contentView.addSubview(staffing_5)
    }
}
