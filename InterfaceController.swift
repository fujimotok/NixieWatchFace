//
//  InterfaceController.swift
//  Nixie WatchKit Extension
//
//  Created by fjmt on 2019/06/22.
//  Copyright © 2019 fjmt. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

// cracking for hiding right-top mini clock
fileprivate extension NSObject {
    @objc class func sharedApplication() -> NSObject? { fatalError() }
    @objc func keyWindow() -> NSObject? { fatalError() }
    @objc func rootViewController() -> NSObject? { fatalError() }
    @objc func viewControllers() -> Array<NSObject> { fatalError() }
    @objc func view() -> NSObject? { fatalError() }
    @objc func subviews() -> Array<NSObject>? { fatalError() }
    @objc func timeLabel() -> NSObject? { fatalError() }
    @objc func layer() -> NSObject? { fatalError() }
    @objc func setOpacity(_ opacity: CDouble) { fatalError() }
}

func getSPFullScreenView() -> NSObject? {
    let UIApplication = NSClassFromString("UIApplication") as? NSObject.Type
    
    if let views = UIApplication?.sharedApplication()?.keyWindow()?
        .rootViewController()?.viewControllers().first?.view()?.subviews() {
        for view in views {
            if type(of: view) == NSClassFromString("SPFullScreenView") {
                return view
            }
        }
    }
    
    return nil
}

var hideDefaultTimeLabelOnce: () -> Void = {
    getSPFullScreenView()?.timeLabel()?.layer()?.setOpacity(0)
    
    return {}
}()
// end cracking

class InterfaceController: WKInterfaceController {
    // UI elements
    @IBOutlet weak var Battery100Img: WKInterfaceImage!
    @IBOutlet weak var Battery010Img: WKInterfaceImage!
    @IBOutlet weak var Battery001Img: WKInterfaceImage!
    
    @IBOutlet weak var DateYear1000Img: WKInterfaceImage!
    @IBOutlet weak var DateYear0100Img: WKInterfaceImage!
    @IBOutlet weak var DateYear0010Img: WKInterfaceImage!
    @IBOutlet weak var DateYear0001Img: WKInterfaceImage!
    @IBOutlet weak var DateMonth10Img: WKInterfaceImage!
    @IBOutlet weak var DateMonth01Img: WKInterfaceImage!
    @IBOutlet weak var DateDay10Img: WKInterfaceImage!
    @IBOutlet weak var DateDay01Img: WKInterfaceImage!
    @IBOutlet weak var DateWeekDayImg: WKInterfaceImage!
    
    @IBOutlet weak var ClockHour10Img: WKInterfaceImage!
    @IBOutlet weak var ClockHour01Img: WKInterfaceImage!
    @IBOutlet weak var ClockMin10Img: WKInterfaceImage!
    @IBOutlet weak var ClockMin01Img: WKInterfaceImage!
    @IBOutlet weak var ClockSec10Img: WKInterfaceImage!
    @IBOutlet weak var ClockSec01Img: WKInterfaceImage!
    
    @IBOutlet weak var ActivityMove1000Img: WKInterfaceImage!
    @IBOutlet weak var ActivityMove0100Img: WKInterfaceImage!
    @IBOutlet weak var ActivityMove0010Img: WKInterfaceImage!
    @IBOutlet weak var ActivityMove0001Img: WKInterfaceImage!
    @IBOutlet weak var ActivityExercize100Img: WKInterfaceImage!
    @IBOutlet weak var ActivityExercize010Img: WKInterfaceImage!
    @IBOutlet weak var ActivityExercize001Img: WKInterfaceImage!
    @IBOutlet weak var ActivityStand10Img: WKInterfaceImage!
    @IBOutlet weak var ActivityStand01Img: WKInterfaceImage!
    
    @objc func timerUpdate() {
        nowTime()
    }
    
    @objc func nowTime() {
        let hour = Calendar.current.component(.hour, from: Date())
        let min  = Calendar.current.component(.minute, from: Date())
        let sec  = Calendar.current.component(.second, from: Date())
        ClockHour10Img.setImageNamed(String(hour/10) + ".png")
        ClockHour01Img.setImageNamed(String(hour%10) + ".png")
        ClockMin10Img.setImageNamed(String(min/10)  + ".png")
        ClockMin01Img.setImageNamed(String(min%10)  + ".png")
        ClockSec10Img.setImageNamed(String(sec/10)  + ".png")
        ClockSec01Img.setImageNamed(String(sec%10)  + ".png")
    }
    
    func nowDate() {
        let year = Calendar.current.component(.year, from: Date())
        let mon  = Calendar.current.component(.month, from: Date())
        let day  = Calendar.current.component(.day, from: Date())
        let week = Calendar.current.component(.weekday, from: Date())
        
        DateYear1000Img.setImageNamed(String(year/1000) + ".png")
        DateYear0100Img.setImageNamed(String(year/100%10) + ".png")
        DateYear0010Img.setImageNamed(String(year/10%10)  + ".png")
        DateYear0001Img.setImageNamed(String(year%10)  + ".png")
        DateMonth10Img.setImageNamed(String(mon/10)  + ".png")
        DateMonth01Img.setImageNamed(String(mon%10)  + ".png")
        DateDay10Img.setImageNamed(String(day/10) + ".png")
        DateDay01Img.setImageNamed(String(day%10) + ".png")
        DateWeekDayImg.setImageNamed(String(week-1)  + ".png")
    }
    
    func nowBattery() {
        WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
        let bat = Int(WKInterfaceDevice.current().batteryLevel*100)
        Battery100Img.setImageNamed(String(bat/100) + ".png")
        Battery010Img.setImageNamed(String(bat/10%10) + ".png")
        Battery001Img.setImageNamed(String(bat%10)  + ".png")
    }
    
    func nowActivity() {
        let healthStore = HKHealthStore()
        
        if HKHealthStore.isHealthDataAvailable() != true {
            print("not available")
            return
        }
        
        let activitySummaryType = HKActivitySummaryType.activitySummaryType()
        let readDataTypes: Set<HKObjectType> = [activitySummaryType]
        healthStore.requestAuthorization(toShare: nil, read: readDataTypes, completion: myCompletionHandler)
        
        // Create the date components for the predicate
        guard let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {
            fatalError("*** This should never fail. ***")
        }
        
        let endDate = NSDate()
        
        guard let startDate = calendar.date(byAdding: .day, value: 0, to: endDate as Date, options: []) else {
            fatalError("*** unable to calculate the start date ***")
        }
        
        let units: NSCalendar.Unit = [.day, .month, .year, .era]
        
        var startDateComponents = calendar.components(units, from: startDate)
        startDateComponents.calendar = calendar as Calendar
        
        var endDateComponents = calendar.components(units, from: endDate as Date)
        endDateComponents.calendar = calendar as Calendar
        
        let summariesWithinRange = HKQuery.predicate(forActivitySummariesBetweenStart: startDateComponents, end: endDateComponents)
        let query = HKActivitySummaryQuery(predicate: summariesWithinRange) { (query, summaries, error) -> Void in
            if error != nil {
                fatalError("*** Did not return a valid error object. Healthkit capability not acepted ***")
            }
            
            if let activitySummaries = summaries {
                for summary in activitySummaries {
                    //do something with the summary here...
                    let move = Int((summary.activeEnergyBurned).doubleValue(for: HKUnit.kilocalorie()))
                    self.ActivityMove1000Img.setImageNamed(String(move/1000) + ".png")
                    self.ActivityMove0100Img.setImageNamed(String(move/100%10) + ".png")
                    self.ActivityMove0010Img.setImageNamed(String(move/10%10) + ".png")
                    self.ActivityMove0001Img.setImageNamed(String(move%10) + ".png")
                    let exercise = Int((summary.appleExerciseTime).doubleValue(for: HKUnit.minute()))
                    self.ActivityExercize100Img.setImageNamed(String(exercise/100) + ".png")
                    self.ActivityExercize010Img.setImageNamed(String(exercise/10%10) + ".png")
                    self.ActivityExercize001Img.setImageNamed(String(exercise%10) + ".png")
                    let stand = Int((summary.appleStandHours).doubleValue(for: HKUnit.count()))
                    self.ActivityStand10Img.setImageNamed(String(stand/10) + ".png")
                    self.ActivityStand01Img.setImageNamed(String(stand%10) + ".png")
                }
            }
        }
        healthStore.execute(query)
        
        // Create the predicate for the query
    }
    
    func myCompletionHandler(ok :Bool, e:Error?) -> Void{
        if (ok) {
            print("auth ok")
        } else {
            print("auth ng")
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        setTitle(" ")
        nowTime()
        nowDate()
        nowBattery()
        nowActivity()
        Timer.scheduledTimer(timeInterval: 1, target: self,
                             selector: #selector(InterfaceController.timerUpdate),
                             userInfo: nil, repeats: true)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didAppear() {
        // Hack to make the digital time overlay disappear
        // from: https://github.com/steventroughtonsmith/SpriteKitWatchFace
        hideDefaultTimeLabelOnce()
    }
}
