
import UIKit

class CollectionViewCell : UICollectionViewCell{
    
    var card: UILabel!
    
    var looking_for: UILabel!
    var title: UILabel!
    var imageView: UIImageView!
    var compAvatarView: UIImageView!
    var compName: UILabel!
    var supportImageView: UIImageView!
    var supportCount: UILabel!
    var candidateImageView: UIImageView!
    var candidateCount: UILabel!
    var staffing_leader: UIImageView!
    var staffing_2: UIImageView!
    var staffing_3: UIImageView!
    var staffing_4: UIImageView!
    var staffing_5: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let margin_left: CGFloat   = 10
        let margin_top:  CGFloat   = 5
        let lfHeight:    CGFloat = 30
        let ttHeight:    CGFloat = 50
        let imHeight:    CGFloat = (frame.width-margin_left*2)*(131/320)
        let avHeight:    CGFloat = 60
        let suHeight:    CGFloat = 30
        
        // card(Cellの背景部分)を定義
        card = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        card.layer.backgroundColor = Style().white.cgColor
        card.layer.cornerRadius = 30
        self.contentView.addSubview(card)
        //
        looking_for = UILabel(frame: CGRect(x: margin_left, y: margin_left, width: 100, height: lfHeight))
        looking_for.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(looking_for)
        //
        title = UILabel(frame: CGRect(x: margin_left, y: lfHeight+margin_top, width: frame.width-margin_left*2, height: ttHeight))
        title.numberOfLines = 2
        self.contentView.addSubview(title)
        //
        imageView = UIImageView(frame: CGRect(x: margin_left, y: lfHeight+ttHeight+margin_top*2 , width: frame.width-margin_left*2, height: imHeight))
        self.contentView.addSubview(imageView)
        //
        compAvatarView = UIImageView(frame: CGRect(x: margin_left, y: lfHeight+ttHeight+imHeight+margin_top*3 , width: avHeight, height: avHeight))
        compName = UILabel(frame: CGRect(x: margin_left+avHeight, y: lfHeight+ttHeight+imHeight+margin_top*3 , width: 100, height: avHeight))
        compName.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(compAvatarView)
        self.contentView.addSubview(compName)
        //
        supportImageView = UIImageView(frame: CGRect(x: frame.width-margin_left-suHeight*3, y: lfHeight+ttHeight+imHeight+margin_top*3 , width: suHeight, height: suHeight))
        supportImageView.image = UIImage(named: "baseline_thumb_up_white_24pt")
        supportImageView.tintColor = Style().gray
        supportCount = UILabel(frame: CGRect(x: frame.width-margin_left-suHeight*2, y: lfHeight+ttHeight+imHeight+margin_top*3 , width: suHeight, height: suHeight))
        self.contentView.addSubview(supportImageView)
        self.contentView.addSubview(supportCount)
        //
        candidateImageView = UIImageView(frame: CGRect(x: frame.width-margin_left-suHeight, y: lfHeight+ttHeight+imHeight+margin_top*3 , width: suHeight, height: suHeight))
        candidateImageView.image = UIImage(named: "baseline_group_white_24pt")
        candidateImageView.tintColor = Style().gray
        candidateCount = UILabel(frame: CGRect(x: frame.width-margin_left, y: lfHeight+ttHeight+imHeight+margin_top*3 , width: suHeight, height: suHeight))
        self.contentView.addSubview(candidateImageView)
        self.contentView.addSubview(candidateCount)
        //
        staffing_leader = UIImageView(frame: CGRect(x: margin_left, y: lfHeight+ttHeight+imHeight+avHeight+margin_top*4 , width: avHeight, height: avHeight))
        staffing_2      = UIImageView(frame: CGRect(x: margin_left+avHeight, y: lfHeight+ttHeight+imHeight+avHeight+margin_top*4 , width: suHeight, height: suHeight))
        staffing_3      = UIImageView(frame: CGRect(x: margin_left+avHeight+suHeight, y: lfHeight+ttHeight+imHeight+avHeight+margin_top*4 , width: suHeight, height: suHeight))
        staffing_4      = UIImageView(frame: CGRect(x: margin_left+avHeight+suHeight*2, y: lfHeight+ttHeight+imHeight+avHeight+margin_top*4 , width: suHeight, height: suHeight))
        staffing_5      = UIImageView(frame: CGRect(x: margin_left+avHeight+suHeight*3, y: lfHeight+ttHeight+imHeight+avHeight+margin_top*4 , width: suHeight, height: suHeight))
        staffing_leader.image = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_2.image      = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_3.image      = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_4.image      = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_5.image      = UIImage(named: "baseline_account_circle_white_36pt")
        staffing_leader.tintColor = Style().background
        staffing_2.tintColor      = Style().background
        staffing_3.tintColor      = Style().background
        staffing_4.tintColor      = Style().background
        staffing_5.tintColor      = Style().background
        //staffing_leader.isHidden = true
        self.contentView.addSubview(staffing_leader)
        self.contentView.addSubview(staffing_2)
        self.contentView.addSubview(staffing_3)
        self.contentView.addSubview(staffing_4)
        self.contentView.addSubview(staffing_5)
        

        // Cell内の各要素をわかりやすく着色する関数
        //background()
    }
    
    // Cell内の各要素をわかりやすく着色する関数
    func background(){
        looking_for.backgroundColor = Style().background
        title.backgroundColor = Style().background
    }
    
}
