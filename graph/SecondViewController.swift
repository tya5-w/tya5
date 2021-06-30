//
//  ScondView Controller.swift
//  NewApp
//
//  Created by 浜田　惇矢 on 2021/06/01.
//
import UIKit

var timekeep = [Int]()
var minute = 0
var second = 0
class SecondViewController: UIViewController {
 
    @IBOutlet var timerMinute: UILabel!
    @IBOutlet var timerSecond: UILabel!
    @IBOutlet var timerMSec: UILabel!
    
    weak var timer: Timer!
    var startTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
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

