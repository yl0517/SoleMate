// NavBar.swift
// SoleMate
//

import SwiftUI

struct NavBar: View {
    // Indicates which tab is currently active; you can expand this as needed
    @Binding var activeTab: Tab
    
    enum Tab {
        case home, search, discussion, saved, reviews
    }

    var body: some View {
        HStack(spacing: 0) {
            navBarItem(icon: "house.fill", label: "Home", tab: .home)
            Spacer()
            navBarItem(icon: "magnifyingglass", label: "Search", tab: .search)
            Spacer()
            navBarItem(icon: "bubble.left.and.bubble.right", label: "Discussion", tab: .discussion)
            Spacer()
            navBarItem(icon: "bookmark", label: "Saved", tab: .saved)
            Spacer()
            navBarItem(icon: "star", label: "Reviews", tab: .reviews)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 12)
        .background(Color.FCFBF9)
        .cornerRadius(32)
        .shadow(color: Color.black.opacity(0.07), radius: 10, x: 0, y: 2)
        .padding(.horizontal, 19)
    }

    private func navBarItem(icon: String, label: String, tab: Tab) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(activeTab == tab ? Color.CA0013 : Color.textDark)
            Text(label)
                .font(.system(size: 10, weight: activeTab == tab ? .semibold : .regular))
                .foregroundColor(activeTab == tab ? Color.CA0013 : Color.textDark)
        }
        .onTapGesture {
            activeTab = tab
            // Add navigation logic as needed
        }
    }
}
