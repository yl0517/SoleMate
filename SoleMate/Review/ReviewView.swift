import SwiftUI
import FirebaseDatabase

struct Review: Identifiable {
    let id: String
    let shoeId: Int
    let text: String
    let timestamp: TimeInterval
}

struct ReviewView: View {
    @Binding var isActive: Bool
    @State private var reviews: [Review] = []
    @State private var shoeNames: [Int: String] = [:]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.EEEBE3
                    .ignoresSafeArea()

                List(reviews) { review in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(shoeNames[review.shoeId] ?? "Shoe #\(review.shoeId)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(review.text)
                            .font(.body)
                    }
                    .padding(.vertical, 8)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Reviews")
            .onAppear {
                loadShoeNames()
                loadReviews()
            }
        }
    }

    private func loadShoeNames() {
        guard
            let url = Bundle.main.url(forResource: "mock_shoes", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let allShoes = try? JSONDecoder().decode([Shoe].self, from: data)
        else { return }

        shoeNames = Dictionary(uniqueKeysWithValues: allShoes.map { ($0.id, $0.name) })
    }

    private func loadReviews() {
        let ref = Database.database().reference().child("reviews")
        ref.observe(.value) { snapshot in
            var all: [Review] = []
            for case let child as DataSnapshot in snapshot.children {
                guard let shoeId = Int(child.key) else { continue }
                for case let rs as DataSnapshot in child.children {
                    guard
                        let dict = rs.value as? [String: Any],
                        let text = dict["text"] as? String,
                        let ts   = dict["timestamp"] as? TimeInterval
                    else { continue }

                    all.append(Review(
                        id: rs.key,
                        shoeId: shoeId,
                        text: text,
                        timestamp: ts
                    ))
                }
            }
            reviews = all.sorted { $0.timestamp > $1.timestamp }
        }
    }
}
