//
//  ViewController.swift
//  nixieWatch
//
//  Created by fjmt on 2019/06/09.
//  Copyright © 2019 fjmt. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

	let activitySummaryType = HKActivitySummaryType.activitySummaryType()
        let readDataTypes: Set<HKObjectType> = [activitySummaryType]
        HKHealthStore().requestAuthorization(toShare: nil, read: readDataTypes, completion: myCompletionHandler)
    }

    func myCompletionHandler(ok :Bool, e:Error?) -> Void{
        if (ok) {
            print("auth ok")
        } else {
            print("auth ng")
        }
    }

}

