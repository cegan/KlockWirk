//
//  ViewController.swift
//  MDRotatingPieChart
//
//  Created by Maxime DAVID on 2015-04-03.
//  Copyright (c) 2015 Maxime DAVID. All rights reserved.
//

import UIKit


class Chart: UIViewController, MDRotatingPieChartDelegate, MDRotatingPieChartDataSource {
    
    var slicesData:Array<Data> = Array<Data>()
    
    var pieChart:MDRotatingPieChart!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pieChart = MDRotatingPieChart(frame: CGRectMake(0, 0, view.frame.width, view.frame.width))
        
        slicesData = [
            Data(myValue: 80.0, myColor: UIColor(red: 0.16, green: 0.73, blue: 0.61, alpha: 1), myLabel:"Line"),
            Data(myValue: 20.0, myColor: UIColor(red: 0.23, green: 0.6, blue: 0.85, alpha: 1), myLabel:"Percentage")]
        
        pieChart.delegate = self
        pieChart.datasource = self
        
        view.addSubview(pieChart)
        
        
        var properties = Properties()
        properties.expand = 15
        
        pieChart.properties = properties
        
        refresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        refresh()
    }
    
    
    func didOpenSliceAtIndex(index: Int) {
        
        print("Open slice at \(index)")
    }
    
    func didCloseSliceAtIndex(index: Int) {
        
    }
    
    func willOpenSliceAtIndex(index: Int) {
        
    }
    
    func willCloseSliceAtIndex(index: Int) {
      
    }
    
    func colorForSliceAtIndex(index:Int) -> UIColor {
        
        return slicesData[index].color
    }
    
    func valueForSliceAtIndex(index:Int) -> CGFloat {
        
        return slicesData[index].value
    }
    
    func labelForSliceAtIndex(index:Int) -> String {
        
        return slicesData[index].label
    }
    
    func numberOfSlices() -> Int {
        
        return slicesData.count
    }
    
    
    func refresh()  {
        
        pieChart.build()
    }
}



class Data {
    var value:CGFloat
    var color:UIColor = UIColor.grayColor()
    var label:String = ""
    
    init(myValue:CGFloat, myColor:UIColor, myLabel:String) {
        value = myValue
        color = myColor
        label = myLabel
    }
}




