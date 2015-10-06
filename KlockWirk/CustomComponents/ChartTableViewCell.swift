//
//  ChartTableViewCell.swift
//  KlockWirk
//
//  Created by Casey Egan on 10/6/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ChartTableViewCell: UITableViewCell,ChartViewDelegate {

    
    @IBOutlet weak var pieChartView: PieChartView!
    var selectedSchedule   = Schedule()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupPieChart()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
    
    //MARK: PieChart Setup
    
    func setupPieChart(){
        
        pieChartView.delegate = self
        pieChartView.usePercentValuesEnabled = true;
        pieChartView.holeTransparent = true;
        pieChartView.centerTextFont = UIFont (name: "Gotham-Light", size: 15)!
        pieChartView.holeRadiusPercent = 0.58;
        pieChartView.transparentCircleRadiusPercent = 0.61;
        pieChartView.descriptionText = "";
        pieChartView.drawCenterTextEnabled = true;
        pieChartView.drawHoleEnabled = true;
        pieChartView.rotationAngle = 0.0;
        pieChartView.rotationEnabled = true;
        pieChartView.centerText = "";
        pieChartView.drawSliceTextEnabled = false
        
        let legend = pieChartView.legend
        legend.position = ChartLegend.ChartLegendPosition.PiechartCenter
        
        legend.xEntrySpace = 7.0;
        legend.yEntrySpace = 50.0;
        legend.yOffset = 50.0;
        
        setupChartData()
        
    }
    
    func setupChartData(){
        
        
        var yVals:[ChartDataEntry] = []
        var xVals:[String] = []
        var colors:[UIColor] = []
        
        colors.append(UIColor(red: 109.0/255.0, green: 110.0/255.0, blue: 113.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 235.0/255.0, green: 68.0/255.0, blue: 17.0/255.0, alpha: 1.0))
        
        
        let percentAchieved = (selectedSchedule.achieved/selectedSchedule.line * 100)
        let goal = ChartDataEntry(value: 100 - percentAchieved, xIndex: 0)
        let achieved = ChartDataEntry(value: percentAchieved, xIndex: 1)
        
    
        
        yVals.append(goal)
        yVals.append(achieved)
        
        xVals.append("Goal")
        xVals.append("Achieved")
        
        
        
        let dataSet = PieChartDataSet(yVals: yVals, label: "")
        dataSet.colors = colors
        

        
        let pFormatter = NSNumberFormatter()
        pFormatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        
        
        let data = PieChartData(xVals: xVals, dataSet: dataSet)
        data.setValueFormatter(pFormatter)
        data.setValueFont(UIFont (name: "Gotham-Medium", size: 12)!)
        data.setValueTextColor(UIColor.whiteColor())
        
        pieChartView.data = data
        
    }
    
    
    func bindScheduleDate(schedule: Schedule){
    
        selectedSchedule = schedule
        
        setupChartData()
    
    }
}
