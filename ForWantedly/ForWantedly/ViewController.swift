
import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var looking_forArray = [String]()
    var titleArray = [String]()
    var imageURLArray = [String]()
    var compAvatarURLArray = [String]()
    var compNameArray = [String]()
    var supportCountArray = [Int]()
    var candidateCountArray = [Int]()
    
    var imageDictionary = [UIImage]()
    var compAvatarDictionary = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewControllerの背景色設定
        self.view.backgroundColor = Style().background
        // 検索バーの背景色を変える
        let barImageView = searchBar.value(forKey: "_background") as! UIImageView
        barImageView.removeFromSuperview()
        searchBar.backgroundColor = Style().background
        searchBar.tintColor = Style().white // 文字入力中のパカパカの色
        let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
        searchTextField?.textColor = Style().white // 入力する文字の色
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            let attributeDict = [NSAttributedStringKey.foregroundColor: Style().white_alpha, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "地域や特徴など条件を追加", attributes: attributeDict) // プレースホルダーの文字と色とフォント
        }
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = Style().white // 検索アイコンの色
        for subView in searchBar.subviews {
            for secondSubView in subView.subviews {
                secondSubView.backgroundColor = Style().background_light // 検索バーの中の色
            }
        }
        
        
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        // collectionViewnの上のマージンを設定
        let margin_CV: CGFloat = 75
        
        // Cellの定義
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 37, height: 400)
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
        //layout.headerReferenceSize = CGSize(width:100,height:30)
        // collectionViewの定義
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: margin_CV, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-margin_CV ), collectionViewLayout: layout)
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = Style().background
        self.view.addSubview(self.collectionView!)
        
        // 並列処理用
        //let q = DispatchQueue(label: "getJSON")
        DispatchQueue(label: "getJSON").async{
            self.getJSON(url: "https://www.wantedly.com/api/v1/projects?q=swift&page=1")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // JSONを取得する関数
    func getJSON(url urlString: String) -> Void{
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let queue = OperationQueue.main

        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { response, data, error in
            if let response = response, let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                    
                    if let data = json["data"] as? [[String:AnyObject]] {
                        //
                        for i in 0..<10{
                            let looking_for = data[i]["looking_for"] as! String
                            let title = data[i]["title"] as! String
                            let imageURL = data[i]["image"]!["i_320_131"] as! String
                            let compName = data[i]["company"]!["name"] as! String
                            let support_count = data[i]["support_count"] as! Int
                            let candidate_count = data[i]["candidate_count"] as! Int
                            
                            if let compAvatar = data[i]["company"]!["avatar"] as? [String:AnyObject] {
                                let compAvatarURL = compAvatar["s_100"] as! String
                                self.compAvatarURLArray.append(compAvatarURL)
                            }
                            
                            self.looking_forArray.append(looking_for)
                            self.titleArray.append(title)
                            self.imageURLArray.append(imageURL)
                            self.compNameArray.append(compName)
                            self.supportCountArray.append(support_count)
                            self.candidateCountArray.append(candidate_count)
                        }
                    }
                    
                    // JSONが取得でき次第メインスレッドでCollectionViewを更新
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        print("reloaded")
                        
                        // URLから画像を取得する
                        self.getImage()
                    }
                    // _metadata取得
                    if let metadata = json["_metadata"] as? [String: AnyObject]{
                        print("metadata: \(metadata)")
                    }
                } catch {
                    print("")
                }
            } else {
                print(error ?? "")
            }
        }
    }
    
    // imageやavatarの画像を取得してくる関数
    func getImage(){
        // サブスレッドでURLから画像を取得して辞書に入れる
        DispatchQueue(label: "getImage").async{
            for n in 0..<10{
                let imageURL = NSURL(string: self.imageURLArray[n])
                let imageData: NSData = NSData(contentsOf: imageURL! as URL)!
                self.imageDictionary.append(UIImage(data: imageData as Data)!)
                
                let avatarURL = NSURL(string: self.compAvatarURLArray[n])
                let avatarData: NSData = NSData(contentsOf: avatarURL! as URL)!
                self.compAvatarDictionary.append(UIImage(data: avatarData as Data)!)
            }
            
            // 画像が取得でき次第CoolectionViewを更新する
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print("reloaded after getImage")
            }
        }
    }
    
    // Cellが選択された時に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    // Cellの総数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    // Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CollectionViewCell
    
        // 文字系
        if looking_forArray.count > indexPath.row{
            cell.looking_for?.text = looking_forArray[indexPath.row]
            cell.title?.text = titleArray[indexPath.row]
            cell.compName?.text = compNameArray[indexPath.row]
            cell.supportCount?.text = String(supportCountArray[indexPath.row])
            cell.candidateCount?.text = String(candidateCountArray[indexPath.row])
        }
        // 画像系
        if imageDictionary.count > indexPath.row{
            cell.imageView?.image = imageDictionary[indexPath.row]
            cell.compAvatarView?.image = compAvatarDictionary[indexPath.row]
        }
        
        print("indexPath.row: \(indexPath.row)")
        
        return cell
    }
}

