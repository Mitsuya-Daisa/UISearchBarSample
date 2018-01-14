//
//  ViewController.swift
//  UISearchBarSample
//
//  Created by Mitsuya-Daisa on 2018/01/13.
//  Copyright © 2018年 mitsuya-daisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate,UITableViewDataSource,ModalViewControllerDelegate {
    
    // テーブルビュー
    @IBOutlet weak var tableView: UITableView!
    // データ操作用の配列
    private var items: NSArray = []
    // 出力用の配列
    private var outputItems: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テーブルビューに表示する配列
        items = ["ねずみ", "うし", "とら", "うさぎ", "りゅう", "へび", "うま","ひつじ","さる","とり","いぬ","いのしし","ねこ","しまうま","やぎ","くま","しろくま","こぶら","ごりら","ぶた","ぞう","おおかみ"]
        // 初期表示を設定
        outputItems = items
        
        //デリゲートの設定
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 検索ボタンタップ
    @IBAction func tapKensaku(_ sender: UIButton) {
        performSegue(withIdentifier: "toKensakuView", sender: nil)
    }
    
    // 画面遷移処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 検索画面に値を渡す。
        let searchViewController:searchViewController = segue.destination as! searchViewController
        searchViewController.items = items
        // 検索画面のデリゲートを設定する。
        searchViewController.delegate = self
    }
    
    // テーブルビューのデリゲードメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // テーブルビューのセル数の設定する。
        return self.outputItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //outputItemsをセルに出力する。
        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell", for:indexPath as IndexPath)
        cell.textLabel?.text = self.outputItems[indexPath.row] as? String
        return cell
    }
    
    // 検索画面のデリゲートメソッド
    func modalDidFinished(searchResultReturn: NSArray){
        // 検索画面にて検索した結果を出力用に設定する。
        outputItems = searchResultReturn
        
        // tableViewを再表示する。
        tableView.reloadData()
    }
}

