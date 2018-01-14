//
//  searchViewController.swift
//  UISearchBarSample
//
//  Created by Mitsuya-Daisa on 2018/01/13.
//  Copyright © 2018年 mitsuya-daisa. All rights reserved.
//

import UIKit

// プロトコルを生成する。
protocol ModalViewControllerDelegate{
    // 検索結果を引数とするデリゲートメソッド
    func modalDidFinished(searchResultReturn: NSArray)
}

class searchViewController: UIViewController,UISearchBarDelegate {

    var delegate : ModalViewControllerDelegate! = nil // デリゲート
    var items : NSArray = []                          // 検索用配列
    private var searchResult : NSArray = []           // 検索結果配列
    
    @IBOutlet weak var searchBar: UISearchBar!        // 検索バー
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートを設定
        searchBar.delegate = self
    }
    
    // 渡された文字列を含む要素を検索する。
    func searchItems(searchText: String){
        // 要素を検索する。
        if searchText != "" {
            searchResult = items.filter { item in
                return (item as! String).contains(searchText)
                } as NSArray
        }else{
            // 渡された文字列が空の場合は全てを表示する。
            searchResult = items
        }
    }
    
    // SearchBarのデリゲードメソッド
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // キャンセルされた場合、検索は行わない。
        searchBar.text = ""
        self.view.endEditing(true)
        searchResult = items
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる。
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func kensakuBut(_ sender: UIButton) {
        // 検索処理を実行する。
        searchItems(searchText: searchBar.text! as String)
        // デリゲートメソッドを実行する。
        self.delegate.modalDidFinished(searchResultReturn: searchResult)
        // 画面を閉じる。
        dismiss(animated: true, completion: nil)
    }
}
