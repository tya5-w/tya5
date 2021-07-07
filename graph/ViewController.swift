import UIKit
import NCMB
import Charts



class ViewController: UIViewController{
    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rawData: [Int] = [20, 50, 70, 30, 60, 90, 40]
        let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
        let dataSet = BarChartDataSet(entries: entries)
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        
        
    }

}

