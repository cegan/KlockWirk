//
//  ChartViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/29/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ActiveScheduleViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var achievedLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var viewScheduleDetails: UIButton!

    var merchant          = Merchant()
    var klockWirker       = KlockWirker()
    var currentSchedule   = Schedule()
    
    
    
    //MARK: View Initialization
    
    init(schedule: Schedule){
        
        super.init(nibName: "ActiveScheduleViewController", bundle: nil);
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        refreshHomeView()
        setupNavigationBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        refreshHomeView()
        setupPieChartProperties()
        
        self.navigationItem.title = "Home"
    }
    

    
    
    //MARK: Events
    
    @IBAction func viewScheduleDetailsTouched(sender: AnyObject) {
        
        self.presentViewController(UINavigationController(rootViewController:ScheduleDetailTableViewController2(schedule: currentSchedule)), animated: true, completion: nil)
    }
    
    
    
    
    //MARK: PieChart Setup
    
    func setupPieChartProperties(){
        
        pieChart.delegate                       = self
        pieChart.centerTextFont                 = UIFont (name: "Gotham-Light", size: 15)!
        pieChart.holeRadiusPercent              = 0.58;
        pieChart.transparentCircleRadiusPercent = 0.61;
        pieChart.rotationAngle                  = 0.0;
        pieChart.drawCenterTextEnabled          = true;
        pieChart.drawHoleEnabled                = true;
        pieChart.rotationEnabled                = true;
        pieChart.usePercentValuesEnabled        = true;
        pieChart.holeTransparent                = true;
        pieChart.drawSliceTextEnabled           = false
        pieChart.descriptionText                = "";
        pieChart.centerText                     = "";
        
        let legend = pieChart.legend
        legend.position = ChartLegend.ChartLegendPosition.PiechartCenter
        
        legend.xEntrySpace = 7.0;
        legend.yEntrySpace = 50.0;
        legend.yOffset = 50.0;
        
        setupPieChartData()
   
    }
    
    func setupPieChartData(){
        
        var yVals:[ChartDataEntry]  = []
        var xVals:[String]          = []
        var colors:[UIColor]        = []

        colors.append(KlockWirkColors.Orange)
        colors.append(KlockWirkColors.DarkGrey)
        
        
        let percentAchieved = (currentSchedule.achieved/currentSchedule.goal * 100)
        let goal            = ChartDataEntry(value: 100 - percentAchieved, xIndex: 0)
        let achieved        = ChartDataEntry(value: percentAchieved, xIndex: 1)
        
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
        
        pieChart.data = data

    }
    
    func setupNavigationBar(){
        
         let refresh = UIBarButtonItem(image: UIImage(named: "refresh_normal.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("refreshSchedule"))
        
        self.navigationItem.rightBarButtonItem = refresh
    }
    
    func refreshSchedule(){
        
        NotificationUtilities.postNotification(NotificationConstants.UserDidRefreshSchedule)
    }

    func refreshHomeView(){
        
        if(ApplicationInformation.isMerchant()){
            
            merchant = MerchantManager.sharedInstance.merchant
            
            if(merchant.schedules.count > 0){
                
                if let schedule = DateUtilities.getCurrentSchedule(merchant.schedules){
                    
                    pieChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutBack)
                    currentSchedule = schedule
                    
                    goalLabel.text = "Goal " + NumberFormatter.formatDoubleToCurrency(currentSchedule.goal)
                    achievedLabel.text = "Achieved " + NumberFormatter.formatDoubleToCurrency(currentSchedule.achieved)
                }
            }
        }
        else{
            
            klockWirker = KlockWirkerManager.sharedInstance.klockWirker
            
            if(klockWirker.schedules.count > 0){
                
                if let schedule = DateUtilities.getCurrentSchedule(klockWirker.schedules){
                    
                    pieChart.animate(xAxisDuration: 1.0, easingOption: ChartEasingOption.EaseOutCirc)
                    currentSchedule = schedule
                    
                    goalLabel.text = "Goal " + NumberFormatter.formatDoubleToCurrency(currentSchedule.goal)
                    achievedLabel.text = "Achieved " + NumberFormatter.formatDoubleToCurrency(currentSchedule.achieved)
                }
            }
            
        }
    }
}
