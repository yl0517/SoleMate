// RecommendationContentView.swift
import SwiftUI

struct RecommendationContentView: View {
    let shoes: [Shoe]
    @StateObject private var repo = FirebaseFavoritesRepository()

    @Binding var favorites: [Shoe]

    // MARK: – UI State
    @State private var searchText: String = ""
    @State private var selectedActivities: Set<String> = []
    @State private var useCustomFilter: Bool = false
    @State private var config: ShoeConfiguration? = nil

    // derive unique activity filters from your data
    private var allActivities: [String] {
        Array(Set(shoes.flatMap { $0.activities })).sorted()
    }

    // combined filter: search + activity pills + optional custom config
    private var filteredShoes: [Shoe] {
        shoes.filter { shoe in
            // 1) text search
            let matchesSearch = searchText.isEmpty ||
                shoe.name.localizedCaseInsensitiveContains(searchText)

            // 2) activity pills
            let matchesActivity = selectedActivities.isEmpty ||
                !selectedActivities.intersection(shoe.activities).isEmpty

            // 3) user config filter if toggled on
            let matchesCustom: Bool = {
                guard useCustomFilter, let cfg = config else { return true }
                // length in range & same unit
                guard cfg.footLengthUnit.rawValue == shoe.sizeRange.footLengthUnit,
                      cfg.footLength >= shoe.sizeRange.minFootLength,
                      cfg.footLength <= shoe.sizeRange.maxFootLength
                else { return false }
                // width in range & same unit
                guard cfg.footWidthUnit.rawValue == shoe.sizeRange.footWidthUnit,
                      cfg.footWidth >= shoe.sizeRange.minFootWidth,
                      cfg.footWidth <= shoe.sizeRange.maxFootWidth
                else { return false }
                // arch matches
                guard shoe.archType.localizedCaseInsensitiveContains(cfg.archType.rawValue)
                else { return false }
                // sizing option matches or shoe allows both
                let opt = shoe.sizingOption.lowercased()
                let want = cfg.sizingOption.rawValue.lowercased()
                guard opt == want || opt == "both" else { return false }
                return true
            }()

            return matchesSearch && matchesActivity && matchesCustom
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // 1) Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search shoes…", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)

            // 2) Pills: Custom + dynamic activities
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    // Custom filter pill
                    Text("Custom")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(useCustomFilter ? Color.white : Color.CA0013)
                        .padding(.horizontal, 8)
                        .frame(height: 26)
                        .background(useCustomFilter ? Color.CA0013 : Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.CA0013, lineWidth: 1)
                        )
                        .cornerRadius(12)
                        .onTapGesture { useCustomFilter.toggle() }

                    // Activity pills
                    ForEach(allActivities, id: \.self) { activity in
                        let isSelected = selectedActivities.contains(activity)
                        Text(activity)
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(isSelected ? Color.white : Color.CA0013)
                            .padding(.horizontal, 8)
                            .frame(height: 26)
                            .background(isSelected ? Color.CA0013 : Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.CA0013, lineWidth: 1)
                            )
                            .cornerRadius(12)
                            .onTapGesture {
                                if isSelected {
                                    selectedActivities.remove(activity)
                                } else {
                                    selectedActivities.insert(activity)
                                }
                            }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }

            // 3) Filtered shoe list
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(filteredShoes) { shoe in
                        ShoeCardView(
                            shoe: shoe,
                            isFavorite: repo.favorites.contains(shoe),
                            onFavoriteToggle: {
                                repo.toggleFavorite(shoe)
                            },
                            onReview: { }
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 140)
            }
        }
        .onAppear {
            config = UserDefaults.standard.shoeConfiguration
        }
    }
}
