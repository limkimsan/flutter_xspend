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
        SimpleEntry(date: Date(), income: "៛12,000,000.00", kFormatIncome: "៛12M", expense: "-៛10,000.00", kFormatExpense: "-៛10K", total: "៛13,990,000.00")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = UserDefaults.init(suiteName: "group.SummaryWidget")
        let entry = SimpleEntry(
            date: Date(),
            income: data?.string(forKey: "income") ?? "\(data?.string(forKey: "currency") == "km" ? "៛" : "$")0",
            kFormatIncome: data?.string(forKey: "kFormatIncome") ?? "\(data?.string(forKey: "currency") == "km" ? "៛" : "$")0",
            expense: data?.string(forKey: "expense") ?? "\(data?.string(forKey: "currency") == "km" ? "៛" : "$")0",
            kFormatExpense: data?.string(forKey: "kFormatExpense") ?? "\(data?.string(forKey: "currency") == "km" ? "៛" : "$")0",
            total: data?.string(forKey: "total") ?? "\(data?.string(forKey: "currency") == "km" ? "៛" : "$")0"
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let income: String
    let kFormatIncome: String
    let expense: String
    let kFormatExpense: String
    let total: String
}

struct SummaryWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    let data = UserDefaults.init(suiteName: "group.SummaryWidget")
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
                        Text(data?.string(forKey: "locale") == "km" ? "ចំណូល:" : "Income:")
                            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)

                        Text(data?.string(forKey: "locale") == "km" ? "ចំណាយ:" : "Expense:")
                            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 6)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(widgetFamily == .systemMedium ? entry.income : entry.kFormatIncome)")
                            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
                            .foregroundColor(Color.green)
                        Text("\(widgetFamily == .systemMedium ? entry.expense : entry.kFormatExpense)")
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
                        Text(data?.string(forKey: "locale") == "km" ? "សរុប" : "Total")
                            .font(.custom("KantumruyPro-SemiBold", size: 16))
                            .foregroundColor(.white)
                        Spacer()
                        Text(entry.total)
                            .font(.custom("KantumruyPro-SemiBold", size: 16))
                            .foregroundColor(.green)
                            .padding(.top, 2)
                    }
                }
                else {
                    Text(data?.string(forKey: "locale") == "km" ? "សរុប" : "Total")
                        .font(.custom("KantumruyPro-SemiBold", size: 14))
                        .foregroundColor(.white)
                    Text(entry.total)
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
        .configurationDisplayName("Cash flow summary Widget")
        .description("This is the widget of the cash flow summary of the current month")
    }
}

#Preview(as: .systemSmall) {
    SummaryWidget()
} timeline: {
    SimpleEntry(date: Date(), income: "៛12,000,000.00", kFormatIncome: "៛12M", expense: "-៛10,000.00", kFormatExpense: "-៛10K", total: "៛13,990,000.00")
}

#Preview(as: .systemMedium) {
    SummaryWidget()
} timeline: {
    SimpleEntry(date: Date(), income: "៛12,000,000.00", kFormatIncome: "៛12M", expense: "-៛10,000.00", kFormatExpense: "-៛10K", total: "៛13,990,000.00")
}
