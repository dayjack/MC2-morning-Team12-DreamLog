//
//  DreamBoardWidget.swift
//  DreamBoardWidget
//
//  Created by ChoiYujin on 2023/05/11.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct DreamBoardWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    @State var text = ""
    
    var boardImage = UIImage(named: "BoardDummy") ?? UIImage(systemName: "questionmark")!
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                Image(uiImage: boardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Spacer()
                    Text(text)
                        .font(.system(size: 12, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(.white.opacity(0.9))
                }
                .padding(.bottom)
                //.padding을 주면 radius 부분이 안짤림
            }
        case .systemMedium:
            ZStack {
                Image(uiImage: boardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
                VStack {
                    Text(text)
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(.white.opacity(0.9))
                    
                }
                .padding(.top, 120)
            }
        case .systemLarge:
            ZStack {
                Image(uiImage: boardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Text(text)
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(.white.opacity(0.9))
                }
                .padding(.top, 290)
            }
        @unknown default:
            Text("Unknown widget size")
        }
    }
}

struct DreamBoardWidget: Widget {
    let kind: String = "DreamBoardWidget"
    
    let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.mc2-DreamLog")?.appendingPathComponent("ddd.jpg")
    

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DreamBoardWidgetEntryView(entry: entry,text: UserDefaults.init(suiteName: "group.mc2-DreamLog")?.string(forKey: "WidgetCheer") ?? "응원을 작성해 보세요!")
                .onAppear {
                    print(path)
                }
        }
        .configurationDisplayName("드림 보드 위젯입니다!!")
        .description("당신의 목표들을 항상 볼 수 있는 곳에 두세요!!")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct DreamBoardWidget_Previews: PreviewProvider {
    static var previews: some View {
        DreamBoardWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        DreamBoardWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        DreamBoardWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
