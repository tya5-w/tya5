//
//  ScondView Controller.swift
//  NewApp
//
//  Created by 浜田　惇矢 on 2021/06/01.
//

import UIKit
import NCMB


var timekeep = [Int]()
var intArray = [Int]()
var minute = 0
var second = 0
var empArray = [Int]()
var save = [Int]()
var userDefaults = UserDefaults.standard

class SecondViewController: UIViewController {
 
    @IBOutlet var timerMinute: UILabel!
    @IBOutlet var timerSecond: UILabel!
    @IBOutlet var timerMSec: UILabel!
    
    weak var timer: Timer!
    var startTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefaults.array(forKey: "udScore") != nil{
            print("udあり")
        }else{
            let score: [Int] = []
            // 配列の保存
            userDefaults.set(score, forKey: "udScore")
            print("作成しました")
        }
        // 画面背景色を設定してみました
        self.view.backgroundColor = UIColor(red:0.9,green:1.0,blue:0.9,alpha:1.0)
    }
    
    @IBAction func startTimer(_ sender : Any) {
        if timer != nil{
            // timerが起動中なら一旦破棄する
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
        
        startTime = Date()
    }
    
    @IBAction func stopTimer(_ sender : Any) {
        if timer != nil{
            timer.invalidate()
            timekeep.append(minute*60+second)
            print(timekeep)
            timerMinute.text = "00"
            timerSecond.text = "00"
            timerMSec.text = "00"
            
        
            var getScore:[Int] = userDefaults.array(forKey: "udScore") as! [Int]
            let addScore: Int = minute*60+second
            getScore.append(addScore)
            print(getScore)
            userDefaults.set(getScore, forKey: "udScore")
            
            
            
            
            
            
            // testクラスのNCMBObjectを作成
            
            let object : NCMBObject = NCMBObject(className: "TotalScore")
            let user = NCMBUser.currentUser 
            
            //名前とスコアをセット
            
            
            
            
            
            //TotalScoreクラスを検索するNCMBQueryを作成
            var query : NCMBQuery<NCMBObject> = NCMBQuery.getQuery(className: "TotalScore")
            //NameがuserNameと一致するデータを検索する条件を設定
            query.where(field: "Name", equalTo: user?.userName!)
            // 検索を行う
            query.findInBackground(callback: { result in
                switch result {
                    case let .success(array):
                        print("検索取得に成功しました 件数: \(array)")
                        
                        
                    case let .failure(error):
                        print("検索取得に失敗しました: \(error)")
                        
                        object["Score"] = minute*60+second
                        
                }
                //データストアに登録
                object.saveInBackground(callback: { result in
                    switch result {
                    case .success:
                        // 保存に成功した場合の処理
                        print("初回保存に成功しました")
                    case let .failure(error):
                        // 保存に失敗した場合の処理
                        print("初回保存に失敗しました: \(error)")
                    }
                })
            })
            
            
            
        
            
        
            
    //        object["Score"] = NCMBIncrementOperator(amount: minute*60+second)
   
    //       var intArray = [Int]()
    //        intArray.append(minute*60+second)
    //        if let score : [Int] = object["Score"] {
     //          save = intArray + score
    //                   }
    //        object["Score"] = NCMBAddUniqueOperator(elements: save)
    //         print (save)
            
            


            
            

        }
    }
        
    
    @objc func timerCounter() {
        // タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(startTime)
        
        // fmod() 余りを計算
        minute = (Int)(fmod((currentTime/60), 60))
        // currentTime/60 の余り
        second = (Int)(fmod(currentTime, 60))
        // floor 切り捨て、小数点以下を取り出して *100
        let msec = (Int)((currentTime - floor(currentTime))*100)
        
        // %02d： ２桁表示、0で埋める
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        let sMsec = String(format:"%02d", msec)
        
        timerMinute.text = sMinute
        timerSecond.text = sSecond
        timerMSec.text = sMsec
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    //    timer.invalidate()
        
    }
    
}

