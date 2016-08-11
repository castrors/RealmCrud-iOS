//
//  Item.swift
//  RealmCrud
//
//  Created by Alessandro Nakamuta on 8/10/16.
//  Copyright © 2016 Jera. All rights reserved.
//

import UIKit
import RealmSwift

class Item: Object {
    dynamic var title: String?
    dynamic var subtitle: String?
    dynamic var done = false
}
