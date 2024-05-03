//
//  XspendWidgetBundle.swift
//  XspendWidget
//
//  Created by Kimsan Lim on 3/5/24.
//

import WidgetKit
import SwiftUI

@main
struct XspendWidgetBundle: WidgetBundle {
    var body: some Widget {
        XspendWidget()
        XspendWidgetLiveActivity()
    }
}
