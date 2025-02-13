//
//  InfoViewModel.swift
//  Twitimer
//
//  Created by Brais Moure on 23/4/21.
//

import SwiftUI

enum InfoViewType {
    case countdown, search, channel, streamer, auth, schedule
}

final class InfoViewModel: ObservableObject {

    // Properties
    
    private let router: InfoRouter
    let type: InfoViewType
    let extra: String?
    private let action: (() -> Void)?
    
    // Localization
    
    var image: String {
        switch type {
        case .countdown:
            return "timer"
        case .search:
            return "examine"
        case .channel:
            return "risk_assesment"
        case .streamer:
            return "radio_microphone"
        case .auth:
            return "secure_connection"
        case .schedule:
            return "schedule"
        }
    }
    
    var title: LocalizedStringKey {
        switch type {
        case .countdown:
            return "info.countdown.title".localizedKey
        case .search:
            return "info.search.title".localizedKey
        case .channel:
            return "info.channel.title".localizedKey
        case .streamer:
            return "info.streamer.title".localizedKey
        case .auth:
            return "info.auth.title".localizedKey
        case .schedule:
            return "info.schedule.title".localizedKey
        }
    }
    
    var body: String {
        switch type {
        case .countdown:
            return "info.countdown.body".localized
        case .search:
            return "info.search.body".localized
        case .channel:
            return String(format: "info.channel.body".localized, extra?.capitalized ?? "")
        case .streamer:
            return "info.streamer.body".localized
        case .auth:
            return "info.auth.body".localized
        case .schedule:
            return "info.schedule.body".localized
        }
    }
    
    func advice(number: Int) -> LocalizedStringKey {
        switch type {
        case .countdown:
            return "info.countdown.advice.\(number)".localizedKey
        case .search:
            return "info.search.advice.\(number)".localizedKey
        case .channel:
            return "info.channel.advice.\(number)".localizedKey
        case .streamer:
            return "info.streamer.advice.\(number)".localizedKey
        case .auth:
            return "info.auth.advice.\(number)".localizedKey
        case .schedule:
            return "info.schedule.advice.\(number)".localizedKey
        }
    }
    
    private var shareText: String {
        return String(format: "info.channel.share".localized, extra ?? "")
    }

    // Initialization
    
    init(router: InfoRouter, type: InfoViewType, extra: String?, action: (() -> Void)?) {
        self.router = router
        self.type = type
        self.extra = extra
        self.action = action
    }
    
    // Public
    
    func infoAction() {
        self.action?()
    }
        
    func tweet() {        
        let tweetText = "https://twitter.com/intent/tweet?text=\(shareText)"
        let shareText = tweetText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        if let url = URL(string: shareText) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func share() {
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
}
