
import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var looking_forArray = [String]()
    var titleArray = [String]()
    var imageURLArray = [String]()
    var compAvatarURLArray = [String]()
    var compNameArray = [String]()
    var supportCountArray = [Int]()
    var candidateCountArray = [Int]()
    
    var imageArray = [UIImage]()
    var compAvatarArray = [UIImage]()
    
    var searchWord         = ""
    var page: Int          = 1
    var total_pages: Int   = 20
    var total_objects: Int = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewControllerの背景色設定
        self.view.backgroundColor = Style().background
        // 検索バーの背景色を変える
        let barImageView = searchBar.value(forKey: "_background") as! UIImageView
        barImageView.removeFromSuperview()
        searchBar.backgroundColor = Style().background
        searchBar.tintColor = Style().white // キャレットの色
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
        searchBar.delegate = self
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        // collectionViewnの上のマージンを設定
        let margin_CV: CGFloat = 75
        
        // Cellの定義
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 37, height: 350)
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 100, 0)
        //layout.headerReferenceSize = CGSize(width:100,height:30)
        // collectionViewの定義
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: margin_CV, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-margin_CV ), collectionViewLayout: layout)
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = Style().background
        self.view.addSubview(self.collectionView!)
        
        // 非同期処理でAPI取得
        DispatchQueue(label: "getJSON").async{
            self.getJSON(url: "https://www.wantedly.com/api/v1/projects?q=&page=1")
        }
    }
    
    //serchボタンが押された時に呼ばれる関数
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //キーボードを閉じる
        self.view.endEditing(true)
        searchWord = searchBar.text!
        page = 1
        
        looking_forArray = [String]()
        titleArray = [String]()
        imageURLArray = [String]()
        compAvatarURLArray = [String]()
        compNameArray = [String]()
        supportCountArray = [Int]()
        candidateCountArray = [Int]()
        imageArray = [UIImage]()
        compAvatarArray = [UIImage]()
        
        self.collectionView.reloadData()
        self.collectionView.setContentOffset(CGPoint(x: 0, y: -self.collectionView.contentInset.top), animated: true) // CollectionViewのスクロールを一番上に持ってくる
        
        print("検索ボタンが押されました")
        
        DispatchQueue(label: "getJSON").async{
            self.getJSON(url: "https://www.wantedly.com/api/v1/projects?q=\(self.searchWord)&page=1")
        }
        print(searchWord)
    }
    
    // TextField以外の部分をタッチした時にキーボード閉じるやつ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // JSONを取得する関数
    func getJSON(url urlString: String!) -> Void{
        let url = URL(string: urlString!.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) // 日本語を許容
        let request = URLRequest(url: url!)
        let queue = OperationQueue.main

        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { response, data, error in
            if let response = response, let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                    
                    if let data = json["data"] as? [[String:AnyObject]] {
                        //
                        var end   = 10
                        if self.page == self.total_pages {
                            end -= self.total_pages * 10 - self.total_objects
                        }
                        
                        for i in 0..<end{
                            // 文字・数字系をJSONから取得
                            let looking_for = data[i]["looking_for"] as! String
                            let title = data[i]["title"] as! String
                            let compName = data[i]["company"]!["name"] as! String
                            let support_count = data[i]["support_count"] as! Int
                            let candidate_count = data[i]["candidate_count"] as! Int
                            
                            // 画像系をJSONから取得
                            if let image = data[i]["image"]{
                                if let imageURL = image["i_320_131"] as? String {
                                    self.imageURLArray.append(imageURL)
                                }else {
                                    self.imageURLArray.append("https://fullfill.sakura.ne.jp/StockList/img/EV185135046_TP_V4.jpg")
                                }
                            }else {
                                self.imageURLArray.append("https://fullfill.sakura.ne.jp/StockList/img/EV185135046_TP_V4.jpg")
                            }
                            
                            if let compAvatar = data[i]["company"]!["avatar"] as? [String:AnyObject] {
                                if let compAvatarURL = compAvatar["s_100"] as? String {
                                    self.compAvatarURLArray.append(compAvatarURL)
                                }else{
                                    self.compAvatarURLArray.append("https://fullfill.sakura.ne.jp/StockList/img/sharp_business_center_black_48dp.png")
                                }
                            }else{
                                self.compAvatarURLArray.append("https://fullfill.sakura.ne.jp/StockList/img/sharp_business_center_black_48dp.png")
                            }
                            
                            self.looking_forArray.append(looking_for)
                            self.titleArray.append(title)
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
                        // トータルのページ数を更新
                        self.total_pages   = metadata["total_pages"] as! Int
                        self.total_objects = metadata["total_objects"] as! Int
                        print(metadata)
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
            print("searchWord   : \(self.searchWord)")
            print("page         : \(self.page)")
            print("total_pages  : \(self.total_pages)")
            print("total_objects: \(self.total_objects)")
            print("compAvatarURLArrayの長さ: \(self.compAvatarURLArray.count)")
            
            let start = (self.page-1)*10
            var end   = start+10
            if self.page == self.total_pages {
                end -= self.total_pages * 10 - self.total_objects
            }
            print("start: ", start)
            print("end  : ", end)
            
            for n in start..<end{
                let imageURL = NSURL(string: self.imageURLArray[n])
                let imageData: NSData = NSData(contentsOf: imageURL! as URL)!
                self.imageArray.append(UIImage(data: imageData as Data)!)
                
                let avatarURL = NSURL(string: self.compAvatarURLArray[n])
                let avatarData: NSData = NSData(contentsOf: avatarURL! as URL)!
                self.compAvatarArray.append(UIImage(data: avatarData as Data)!)
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
        self.view.endEditing(true)
        print("Num: \(indexPath.row)")
    }
    // Cellの総数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 今のページが最後の時
        if page == total_pages {
            return total_objects
        }else {
            return page * 10
        }
    }
    // Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CollectionViewCell
    
        print("indexPath.row: \(indexPath.row)")
        
        // CollectionViewのスクロールが一番下に来た時にページを更新する
        if collectionView.contentOffset.y + collectionView.frame.size.height > collectionView.contentSize.height && collectionView.isDragging {
            // ページ数がトータルのページを超えていない時
            if page < total_pages {
                page += 1
                collectionView.reloadData()
                print("新規ページを追加しました")
                DispatchQueue(label: "getJSON").async{
                    self.getJSON(url: "https://www.wantedly.com/api/v1/projects?q=\(self.searchWord)&page=\(self.page)")
                }
            }
        }
        
        // 文字系
        if looking_forArray.count > indexPath.row {
            cell.looking_for?.text = looking_forArray[indexPath.row]
            cell.title?.text = titleArray[indexPath.row]
            cell.compName?.text = compNameArray[indexPath.row]
            cell.supportCount?.text = String(supportCountArray[indexPath.row])
            cell.candidateCount?.text = String(candidateCountArray[indexPath.row])
        }
        // 画像系
        if (imageArray.count > indexPath.row) && (compAvatarArray.count > indexPath.row) {
            cell.imageView?.image = imageArray[indexPath.row]
            cell.compAvatarView?.image = compAvatarArray[indexPath.row]
        }
    
        return cell
    }
}

