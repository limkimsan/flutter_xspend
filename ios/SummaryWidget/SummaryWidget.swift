//
//  SummaryWidget.swift
//  SummaryWidget
//
//  Created by Kimsan Lim on 4/5/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        if context.family == .systemMedium {
            SimpleEntry(date: Date(),income: "62,000,000.00", expense: "-10,000.00", total: "61,990,000.00")
        } else {
            SimpleEntry(date: Date(),income: "62M", expense: "-100K", total: "61,990,000.00")
        }
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), income: "12M", expense: "-100K", total: "19,990,000.00")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
              let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            let entry = SimpleEntry(date: entryDate, income: "12M", expense: "-10K", total: "19,990,000.00")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let income: String
    let expense: String
    let total: String
}

struct SummaryWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("សាច់ប្រាក់ខែ\(entry.date.formatted(Date.FormatStyle().month(.wide)))")
                    .font(.custom("KantumruyPro-SemiBold", size: widgetFamily == .systemMedium ? 18 : 15))
                    .foregroundColor(Color.white)
                    .padding(.bottom, 6)
                    .padding(.top, widgetFamily == .systemMedium ? 0 : 4)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("ចំណូល:")
                            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)

                        Text("ចំណាយ:")
                            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 6)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("៛ \(entry.income)")
                            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
                            .foregroundColor(Color.green)
                        Text("៛ \(entry.expense)")
                            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
                            .foregroundColor(.red)
                            .padding(.top, 6)
                    }
                }
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.gray)
                    .padding(.top, 6)
                    .padding(.bottom, 6)
                
                if widgetFamily == .systemMedium {
                    HStack {
                        Text("សរុប")
                            .font(.custom("KantumruyPro-SemiBold", size: 16))
                            .foregroundColor(.white)
                        Spacer()
                        Text("៛ \(entry.total)")
                            .font(.custom("KantumruyPro-SemiBold", size: 16))
                            .foregroundColor(.green)
                            .padding(.top, 2)
                    }
                }
                else {
                    Text("សរុប")
                        .font(.custom("KantumruyPro-SemiBold", size: 14))
                        .foregroundColor(.white)
                    Text("៛ \(entry.total)")
                        .font(.custom("KantumruyPro-SemiBold", size: 14))
                        .foregroundColor(.green)
                        .padding(.top, 0.5)
                }
            }
            .padding(.top, -4)
        } .padding(-2)
    }
}

struct SummaryWidget: Widget {
    let kind: String = "SummaryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                let customColor = Color("WidgetBackground")
                SummaryWidgetEntryView(entry: entry)
                    .containerBackground(customColor, for: .widget)
            } else {
                SummaryWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    SummaryWidget()
} timeline: {
    SimpleEntry(date: .now, income: "12M", expense: "-100K", total: "19,990,000.00")
}

#Preview(as: .systemMedium) {
    SummaryWidget()
} timeline: {
    SimpleEntry(date: .now, income: "12,000,000.00", expense: "-10,000.00", total: "19990000.00")
}
