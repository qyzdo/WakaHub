//
//  User.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import Foundation

struct User: Codable {
    let data: UserDataClass
}

// MARK: - DataClass
struct UserDataClass: Codable {
    let bio, colorScheme: String
    let createdAt: String
    let dateFormat, defaultDashboardRange, displayName, email: String
    let fullName: String
    let hasPremiumFeatures: Bool
    let humanReadableWebsite, identifier: String
    let isEmailConfirmed, isEmailPublic, isHireable, languagesUsedPublic: Bool
    let lastHeartbeatAt: String
    let lastPlugin, lastPluginName, lastProject, location: String
    let loggedTimePublic: Bool
    let modifiedAt: String?
    let needsPaymentMethod: Bool
    let avatarUrl: String
    let photoPublic: Bool
    let plan: String
    let publicEmail: String?
    let showMachineNameIP, timeFormat24Hr: Bool
    let timeout: Int
    let timezone, username, website: String
    let weekdayStart: Int
    let writesOnly: Bool

    enum CodingKeys: String, CodingKey {
        case bio
        case colorScheme = "color_scheme"
        case createdAt = "created_at"
        case dateFormat = "date_format"
        case defaultDashboardRange = "default_dashboard_range"
        case displayName = "display_name"
        case email
        case fullName = "full_name"
        case hasPremiumFeatures = "has_premium_features"
        case humanReadableWebsite = "human_readable_website"
        case identifier = "id"
        case isEmailConfirmed = "is_email_confirmed"
        case isEmailPublic = "is_email_public"
        case isHireable = "is_hireable"
        case languagesUsedPublic = "languages_used_public"
        case lastHeartbeatAt = "last_heartbeat_at"
        case lastPlugin = "last_plugin"
        case lastPluginName = "last_plugin_name"
        case lastProject = "last_project"
        case location
        case loggedTimePublic = "logged_time_public"
        case modifiedAt = "modified_at"
        case needsPaymentMethod = "needs_payment_method"
        case avatarUrl = "photo"
        case photoPublic = "photo_public"
        case plan
        case publicEmail = "public_email"
        case showMachineNameIP = "show_machine_name_ip"
        case timeFormat24Hr = "time_format_24hr"
        case timeout, timezone, username, website
        case weekdayStart = "weekday_start"
        case writesOnly = "writes_only"
    }
}
