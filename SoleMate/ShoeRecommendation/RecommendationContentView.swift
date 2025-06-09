import SwiftUI

struct RecommendationContentView: View {
    let shoes: [Shoe]
    @Binding var favorites: [Shoe]
    @StateObject private var repo = FirebaseFavoritesRepository()
    
    // MARK: – UI State
    @State private var searchText: String = ""
    @State private var selectedActivities: Set<String> = []
    @State private var useCustomFilter: Bool = false
    @State private var config: ShoeConfiguration? = nil
    
    // For presenting the review sheet
    @State private var selectedForReview: Shoe?
    
    // derive unique activity filters from your data
    private var allActivities: [String] {
        Array(Set(shoes.flatMap { $0.activities })).sorted()
    }
    
    // combined filter: search + activity pills + optional custom config
    private var filteredShoes: [Shoe] {
        shoes.filter { shoe in
            let matchesSearch = searchText.isEmpty ||
                shoe.name.localizedCaseInsensitiveContains(searchText)
            
            let matchesActivity = selectedActivities.isEmpty ||
                !selectedActivities.intersection(shoe.activities).isEmpty
            
            let matchesCustom: Bool = {
                guard useCustomFilter, let cfg = config else { return true }
                
                // convert user-entered measurements into cm
                let lengthCm = (cfg.footLengthUnit == .inches)
                    ? cfg.footLength * 2.54
                    : cfg.footLength
                guard
                    lengthCm >= shoe.sizeRange.minFootLength,
                    lengthCm <= shoe.sizeRange.maxFootLength
                else {
                    return false
                }
                
                let widthCm = (cfg.footWidthUnit == .inches)
                    ? cfg.footWidth * 2.54
                    : cfg.footWidth
                guard
                    widthCm >= shoe.sizeRange.minFootWidth,
                    widthCm <= shoe.sizeRange.maxFootWidth
                else {
                    return false
                }
                
                // arch type match
                guard shoe.archType.localizedCaseInsensitiveContains(cfg.archType.rawValue) else {
                    return false
                }
                
                // sizing option match (women/men/both)
                let opt  = shoe.sizingOption.lowercased()
                let want = cfg.sizingOption.rawValue.lowercased()
                guard opt == want || opt == "both" else { return false }
                
                return true
            }()
            
            return matchesSearch && matchesActivity && matchesCustom
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search shoes…", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            
            // Pills
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Text("Custom")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(useCustomFilter ? .white : Color.CA0013)
                        .padding(.horizontal, 8)
                        .frame(height: 26)
                        .background(useCustomFilter ? Color.CA0013 : Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.CA0013, lineWidth: 1))
                        .cornerRadius(12)
                        .onTapGesture { useCustomFilter.toggle() }
                    
                    ForEach(allActivities, id: \.self) { activity in
                        let isSelected = selectedActivities.contains(activity)
                        Text(activity)
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(isSelected ? .white : Color.CA0013)
                            .padding(.horizontal, 8)
                            .frame(height: 26)
                            .background(isSelected ? Color.CA0013 : Color.clear)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.CA0013, lineWidth: 1))
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
            
            // Shoe list
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(filteredShoes) { shoe in
                        ShoeCardView(
                            shoe: shoe,
                            isFavorite: repo.favorites.contains(shoe),
                            onFavoriteToggle: { repo.toggleFavorite(shoe) },
                            onReview: { selectedForReview = shoe }
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .padding(.bottom, 140)
            }
        }
        .onAppear {
            config = UserDefaults.standard.shoeConfiguration
        }
        .sheet(item: $selectedForReview) { shoe in
            ReviewInputView(shoe: shoe)
        }
    }
}
