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
                dateText()
                incomeExpenseSection
                
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

    private func dateText() -> some View {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: data?.string(forKey: "locale") == "km" ? "km_KH" : "en_US")
        dateFormatter.dateFormat = "MMM" // "MMM" gives the 3 first characters of the month name
        let month = dateFormatter.string(from: entry.date)

        return Text("\(data?.string(forKey: "locale") == "km" ? "សាច់ប្រាក់ខែ" : "Cash flow of ")\(month)")
            .font(.custom("KantumruyPro-SemiBold", size: widgetFamily == .systemMedium ? 18 : 15))
            .foregroundColor(Color.white)
            .padding(.bottom, 6)
            .padding(.top, widgetFamily == .systemMedium ? 0 : 4)
    }

    private func localeAwareText(khmer: String, english: String) -> Text {
        Text(data?.string(forKey: "locale") == "km" ? khmer : english)
    }

    private func itemLabel(kmLabel: String, enLabel: String, paddingTop: CGFloat?) -> some View {
        localeAwareText(khmer: kmLabel, english: enLabel)
            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
            .padding(.top, paddingTop)
    }

    private var incomeExpenseSection: some View {
        HStack {
            VStack(alignment: .leading) {
                itemLabel(kmLabel: "ចំណូល:", enLabel: "Income:", paddingTop: 0)
                itemLabel(kmLabel: "ចំណាយ:", enLabel: "Expense:", paddingTop: 6)
            }
            Spacer()
            VStack(alignment: .trailing) {
                amountLabel(label: "\(widgetFamily == .systemMedium ? entry.income : entry.kFormatIncome)", color: .green, paddingTop: 2)
                amountLabel(label: "\(widgetFamily == .systemMedium ? entry.expense : entry.kFormatExpense)", color: .red, paddingTop: 6)
            }
        }
    }

    private func amountLabel(label: String, color: Color, paddingTop: CGFloat?) -> some View {
        Text(label)
            .font(.custom("KantumruyPro-Regular", size: widgetFamily == .systemMedium ? 15 : 13))
            .foregroundColor(color)
            .padding(.top, paddingTop)
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
        .supportedFamilies([.systemSmall, .systemMedium])     // Allow the widget to be available in small and medium sizes
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
