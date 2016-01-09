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
        
        pieChartView.delegate                       = self
        pieChartView.centerTextFont                 = UIFont (name: "Gotham-Light", size: 15)!
        pieChartView.holeRadiusPercent              = 0.58;
        pieChartView.transparentCircleRadiusPercent = 0.61;
        pieChartView.rotationEnabled                = true;
        pieChartView.drawCenterTextEnabled          = true;
        pieChartView.usePercentValuesEnabled        = true;
        pieChartView.holeTransparent                = true;
        pieChartView.drawHoleEnabled                = true;
        pieChartView.drawSliceTextEnabled           = false
        pieChartView.rotationAngle                  = 0.0;
        pieChartView.centerText                     = "";
        pieChartView.descriptionText                = "";
        
        let legend = pieChartView.legend
        legend.position = ChartLegend.ChartLegendPosition.PiechartCenter
        
        legend.xEntrySpace = 7.0;
        legend.yEntrySpace = 50.0;
        legend.yOffset = 50.0;
        
        setupChartData()
        
    }
    
    func setupChartData(){
        
        
        var yVals:[ChartDataEntry]  = []
        var xVals:[String]          = []
        var colors:[UIColor]        = []
        
        if(selectedSchedule.hasGoalBeenReached()){
            
            colors.append(KlockWirkColors.Orange)
            
            let achieved = ChartDataEntry(value: 100, xIndex: 1)
            
            yVals.append(achieved)
 
            let dataSet = PieChartDataSet(yVals: yVals, label: "Goal Reached!")
            dataSet.colors = colors

            let data = PieChartData(xVals: xVals, dataSet: dataSet)
            data.setValueFont(UIFont (name: "Gotham-Medium", size: 0)!)
            data.setValueTextColor(UIColor.whiteColor())
            
            pieChartView.data = data
        }
        else{
            
            colors.append(KlockWirkColors.Orange)
            colors.append(KlockWirkColors.DarkGrey)
            
            let percentAchieved = (selectedSchedule.achieved/selectedSchedule.goal * 100)
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
    }
    
    
    func bindScheduleData(schedule: Schedule){
    
        selectedSchedule = schedule
        
        setupChartData()
    
    }
}
