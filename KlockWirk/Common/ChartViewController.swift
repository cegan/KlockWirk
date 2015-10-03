//
//  ChartViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/29/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var pieChart: PieChartView!

   // @IBOutlet weak var scheduleDetailTableView: UITableView!
    var scheduleToDisplay = Schedule()
    var scheduleSummaryFields = NSMutableArray()
    
    
    
    
    //MARK: View Initialization
    
    init(schedule: Schedule){
        
        super.init(nibName: "ChartViewController", bundle: nil);
        
        scheduleToDisplay = schedule
    }
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scheduleSummaryFields = getScheduleSummaryFields()
        
        setupPieChart()
        setupNavigationBar()
        setupTableViewDelegates()
        setupTableViewProperties()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Home"
    }
    

    
    
    //MARK: PieChart Setup
    
    func setupPieChart(){
        
        pieChart.delegate = self
        pieChart.usePercentValuesEnabled = true;
        pieChart.holeTransparent = true;
        pieChart.centerTextFont = UIFont (name: "HelveticaNeue", size: 15)!
        pieChart.holeRadiusPercent = 0.58;
        pieChart.transparentCircleRadiusPercent = 0.61;
        pieChart.descriptionText = "";
        pieChart.drawCenterTextEnabled = true;
        pieChart.drawHoleEnabled = true;
        pieChart.rotationAngle = 0.0;
        pieChart.rotationEnabled = true;
        pieChart.centerText = "";
        pieChart.drawSliceTextEnabled = false
        
        let legend = pieChart.legend
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
        
        
        
//        let val1 = ChartDataEntry(value: scheduleToDisplay.line, xIndex: 0)
//        let val2 = ChartDataEntry(value: 2000.00, xIndex: 1)
        
        
        
        let val1 = ChartDataEntry(value: 500.00, xIndex: 0)
        let val2 = ChartDataEntry(value: 2000.00, xIndex: 1)
    
        
        yVals.append(val1)
        yVals.append(val2)
        
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
        data.setValueFont(UIFont (name: "HelveticaNeue-Light", size: 12)!)
        data.setValueTextColor(UIColor.whiteColor())
        
        pieChart.data = data

    }
    
    
    func setupNavigationBar(){
        
        var buttonItem:[UIBarButtonItem] = []
        
         let refresh = UIBarButtonItem(image: UIImage(named: "refresh_normal.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("refreshSchedule"))
        
        
        let scheduleDetails = UIBarButtonItem(image: UIImage(named: "scheduledetails.png")!.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("refreshSchedule"))
        
        buttonItem.append(refresh)
        buttonItem.append(scheduleDetails)
       
        
        self.navigationItem.rightBarButtonItems = buttonItem
    }
    
    
    func refreshSchedule(){
        
        pieChart.animate(xAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutCirc)
    }
    
    
    
    func setupTableViewProperties(){
        
//        scheduleDetailTableView.tableFooterView = UIView(frame: CGRectZero)
//        scheduleDetailTableView.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
    }
    
    func setupTableViewDelegates(){
        
//        scheduleDetailTableView.delegate = self
//        scheduleDetailTableView.dataSource = self
        
    }
    
    
    
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: NumberFormatter.formatDoubleToCurrency(scheduleToDisplay.line), tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Achieved", val: NumberFormatter.formatDoubleToCurrency(scheduleToDisplay.achieved), tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: NumberFormatter.formatDoubleToPercent(scheduleToDisplay.KlockWirkerPercentage), tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift Start", val: DateUtilities.stringValueOfShiftDate(scheduleToDisplay.startDateTime), tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift End", val: DateUtilities.stringValueOfShiftDate(scheduleToDisplay.endDateTime), tag: 5))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 6))
        
        return scheduleSummarFieldsFields
    }
    
    
    
    func displayScheduleDetails(){
        
        
        
        
        
        
    }
    
    
    
    
    
    //MARK: TableView Delegates
    
    
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return scheduleSummaryFields.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let scheduleSummaryField = scheduleSummaryFields.objectAtIndex(indexPath.row) as! ScheduleSummaryField
//        let cell:ScheduleSummaryTableViewCell = scheduleDetailTableView.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell") as! ScheduleSummaryTableViewCell
//        
//        cell.bindCellDetails(scheduleSummaryField)
//        
//        if(indexPath.row == 5){
//            
//            cell.accessoryType = .DisclosureIndicator
//        }
//        else{
//            
//            cell.accessoryType = .None
//        }
//        
//        return cell
//        
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        switch(indexPath.row){
//            
//        case 5:
//            
//            self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: scheduleToDisplay.klockWirkers,readOnly: true), animated: true)
//            
//        default:
//            return
//        }
//    }
//    
//    
    
    
    
    
    
}
