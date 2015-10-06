//
//  ScheduleDetailViewController.swift
//  KlockWirk
//
//  Created by Casey Egan on 9/13/15.
//  Copyright © 2015 KlockWirk. All rights reserved.
//

import UIKit

class ScheduleDetailViewController: UIViewController,ChartViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var tv: UITableView!
    
    let scheduleService = SchedulService()
    let merchantService = MerchantServices()
    var isModal         = false
 
    var selectedSchedule = Schedule()
    var scheduleSummaryFields = NSMutableArray()
       
    init(schedule: Schedule){
        
        super.init(nibName: "ScheduleDetailViewController", bundle: nil);
        
        selectedSchedule = schedule
    }
    
    
    init(schedule: Schedule, initAsModal: Bool){
        
        super.init(nibName: "ScheduleDetailViewController", bundle: nil);
        
        selectedSchedule = schedule
        isModal = initAsModal
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    
    //MARK: View Delegates
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scheduleSummaryFields = getScheduleSummaryFields()
        
        loadKlockWirkersOnSchedule()
        setupViewProperties()
        setupTableViewProperties()
        setupNavigationBar()
        setupTableViewDelegates()
        
        tv.separatorColor = UIColor.redColor()
        
      
        
        setupPieChart()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationItem.title = "Schedule Detail"
        
    }
    
    
    
    

    
    func setupPieChart(){
        
        pieChart.delegate = self
        pieChart.usePercentValuesEnabled = true;
        pieChart.holeTransparent = true;
        pieChart.centerTextFont = UIFont (name: "Gotham-Light", size: 15)!
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
        
        pieChart.data = data
        
    }

    
    
    
    
    func dismissScheduleDetail(){

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    //MARK: Setup Methods
    

    func setupNavigationBar(){
        
        if(isModal){
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissScheduleDetail")
        }
        else{
            
            if(!ApplicationInformation.isReadOnly()){
                
                let deleteSchedule = UIBarButtonItem(title: "Delete", style: UIBarButtonItemStyle.Plain, target: self, action: "deleteScheduleConfirmation")
                self.navigationItem.rightBarButtonItem = deleteSchedule
            }
        }
    }
    
    func setupViewProperties(){
        
        self.navigationItem.title = "Schedule Detail"
    }
    
    func setupTableViewDelegates(){
        
        tv.delegate = self
        tv.dataSource = self
        tv.registerNib(UINib(nibName: "ScheduleSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleSummaryTableViewCell")
    }
    
    func setupTableViewProperties(){
        
        tv.tableFooterView = UIView(frame: CGRectZero)
    }
    
    
    
    
    
    
    
    //MARK: Utility Methods
    
    func getScheduleSummaryFields() -> NSMutableArray{
        
        let scheduleSummarFieldsFields = NSMutableArray()
        
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Goal", val: NumberFormatter.formatDoubleToCurrency(selectedSchedule.line), tag: 1))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Achieved", val: NumberFormatter.formatDoubleToCurrency(selectedSchedule.achieved), tag: 2))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Percentage", val: NumberFormatter.formatDoubleToPercent(selectedSchedule.KlockWirkerPercentage), tag: 3))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift Start", val: DateUtilities.stringValueOfShiftDate(selectedSchedule.startDateTime), tag: 4))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "Shift End", val: DateUtilities.stringValueOfShiftDate(selectedSchedule.endDateTime), tag: 5))
        scheduleSummarFieldsFields.addObject(ScheduleSummaryField(lbl: "KlockWirkers", val: "", tag: 6))
        
        return scheduleSummarFieldsFields
    }
    
    func getSelectedKlockWirkers() -> [KlockWirker]{
        
        var merchant = Merchant()
        let isMerhant = ApplicationInformation.isMerchant()
        
        if(isMerhant){
            
            merchant = MerchantManager.sharedInstance.merchant
            
            for kws in merchant.klockWirkers {
                
                let klockWirker = kws
                
                for k in selectedSchedule.klockWirkers {
                    
                    let kk = k
                    
                    if(klockWirker.klockWirkerId == kk.klockWirkerId){
                        
                        klockWirker.isSelected = true
                    }
                }
            }
        }
        
        return merchant.klockWirkers
    }
    
    func deleteScheduleConfirmation(){
        
        let optionMenu = UIAlertController(title: nil, message: "Delete Schedule Confirmation", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete Schedule", style: .Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
            self.deleteSchedule()
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func deleteSchedule(){
        
        scheduleService.deleteSchedule(selectedSchedule.scheduleId) { (response:NSDictionary) in
            
            self.merchantService.getMerchant(ApplicationInformation.getMerchantId()) {(response: Merchant) in
            
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func loadKlockWirkersOnSchedule(){
        
        scheduleService.getKlockWirkersOnSchedule(selectedSchedule) { (response:[KlockWirker]) in
            
            self.selectedSchedule.klockWirkers = response
        }
        
        tv.reloadData()
    }
    
      
    
    
    //MARK: TableView Delegates
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scheduleSummaryFields.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let scheduleSummaryField = scheduleSummaryFields.objectAtIndex(indexPath.row) as! ScheduleSummaryField
        let cell:ScheduleSummaryTableViewCell = tv.dequeueReusableCellWithIdentifier("scheduleSummaryTableViewCell") as! ScheduleSummaryTableViewCell
        
        cell.bindCellDetails(scheduleSummaryField)
        
        if(indexPath.row == 5){
            
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        switch(indexPath.row){

            case 5:
                
                self.navigationController?.pushViewController(KlockWirkerSelectionTableViewController(kws: selectedSchedule.klockWirkers,readOnly: true), animated: true)

            default:
                return
        }
    }
    
}
