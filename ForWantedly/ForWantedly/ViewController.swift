
import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var zero = ["","","","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewControllerの背景色設定
        self.view.backgroundColor = Style().background
        // 検索バーの背景色を変える
        let barImageView = searchBar.value(forKey: "_background") as! UIImageView
        barImageView.removeFromSuperview()
        searchBar.backgroundColor = Style().background
        
        
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
            
            /* ここなくていいかも
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                print("reloaded")
            }
            */
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
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    
                    if let data = json["data"] as? [[String: AnyObject]]{
                        //
                        for i in 0..<10{
                            let title = data[i]["title"] as! String
                            self.zero[i] = title
                        }
                        // 取得でき次第メインスレッドでCollectionViewを更新
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            print("reloaded")
                        }
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
        //cell.textLabel?.text = indexPath.row.description
        cell.textLabel?.text = zero[indexPath.row]
        
        print("indexPath.row: \(indexPath.row)")
        
        return cell
    }
}

