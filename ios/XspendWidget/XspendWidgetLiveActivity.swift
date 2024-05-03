//
//  XspendWidgetLiveActivity.swift
//  XspendWidget
//
//  Created by Kimsan Lim on 3/5/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct XspendWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct XspendWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: XspendWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension XspendWidgetAttributes {
    fileprivate static var preview: XspendWidgetAttributes {
        XspendWidgetAttributes(name: "World")
    }
}

extension XspendWidgetAttributes.ContentState {
    fileprivate static var smiley: XspendWidgetAttributes.ContentState {
        XspendWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: XspendWidgetAttributes.ContentState {
         XspendWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: XspendWidgetAttributes.preview) {
   XspendWidgetLiveActivity()
} contentStates: {
    XspendWidgetAttributes.ContentState.smiley
    XspendWidgetAttributes.ContentState.starEyes
}
