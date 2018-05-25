//
//  ViewController.swift
//  ForWantedly
//
//  Created by 石黒晴也 on 2018/05/22.
//  Copyright © 2018年 Haruya Ishiguro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var zero: Any!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        
        // collectionViewnの上のマージンを設定
        let margin_CV: CGFloat = 75
        
        // Cellの定義
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 400)
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
        //layout.headerReferenceSize = CGSize(width:100,height:30)
        // collectionViewの定義
        collectionView = UICollectionView(frame: CGRect(x: 0, y: margin_CV, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-margin_CV ), collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // ViewControllerの背景色設定
        self.view.backgroundColor = Style().background
        // 検索バーの背景色を変える
        let barImageView = searchBar.value(forKey: "_background") as! UIImageView
        barImageView.removeFromSuperview()
        searchBar.backgroundColor = Style().background
        // CollectionViewの背景色を変える
        collectionView.backgroundColor = Style().background
        
        self.view.addSubview(self.collectionView!)
        
        
        // 並列処理用
        DispatchQueue(label: "getJSON").async{
            // 別スレッド
            var json = self.getJSON(url: "https://www.wantedly.com/api/v1/projects?q=swift&page=1")
            
            // メインスレッド
            DispatchQueue.main.async {
                
                
                print(json)
            }
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
                //print(response)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                    
                    if let data = json["data"] as? [[String: AnyObject]]{
                        //print(data)
                        //print("heyhey", data[9]["title"])

                        for item in data {
                            //print(item)
                            //print(item["title"])
                            
                            // とりあえずこの形で色々取得できる
                            let title = item["title"]
                            
                            self.zero = title
                            print(self.zero)
                        }
                    }
                    // _metadata取得
                    if let metadata = json["_metadata"] as? [String: AnyObject]{
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
        cell.textLabel?.text = indexPath.row.description
        
        return cell
    }
}

