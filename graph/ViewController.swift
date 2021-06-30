//
//  ViewController.swift
//  graph
//
//  Created by 浜田　惇矢 on 2021/06/08.
//
import Charts
import UIKit


class ViewController: UIViewController,ChartViewDelegate{
    var barChart = BarChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        // Do any additional setup after loading the view.
    
    
       func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x:0,y:0,width: self.view.frame.size.width,height: self.view.frame.size.height)
        barChart.center = view.center
        
        view.addSubview(barChart)
        
        var entries = [BarChartDataEntry]()
        
            print(timekeep)
            for x in 0..<10{
                entries.append(BarChartDataEntry(x:Double(x),
                                                 y:Double(x)))
            }
            //Double(timekeep[x]
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }

    }
}

