//
//  TDTask.swift
//  TADA
//
//  Created by Anak Mirasing on 10/18/2558 BE.
//  Copyright © 2558 iGROOMGRiM. All rights reserved.
//

import RealmSwift

class TDTask: Object {
    dynamic var title = ""
    dynamic var taskDescription = ""
    dynamic var done: Bool = false
    dynamic var created = NSDate()
}
