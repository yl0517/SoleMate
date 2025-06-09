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
    
    var body: some View {
        NavigationStack {
            List(reviews) { review in
                VStack(alignment: .leading, spacing: 4) {
                    Text("Shoe #\(review.shoeId)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(review.text)
                        .font(.body)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Reviews")
            .onAppear( perform: loadReviews )
        }
    }
    
    private func loadReviews() {
        let ref = Database.database().reference().child("reviews")
        ref.observe(.value) { snapshot in
            var all: [Review] = []
            for case let child as DataSnapshot in snapshot.children {
                guard let shoeId = Int(child.key) else { continue }
                for case let reviewSnap as DataSnapshot in child.children {
                    guard
                        let dict = reviewSnap.value as? [String: Any],
                        let text = dict["text"] as? String,
                        let ts   = dict["timestamp"] as? TimeInterval
                    else { continue }
                    
                    all.append(
                        Review(
                            id: reviewSnap.key,
                            shoeId: shoeId,
                            text: text,
                            timestamp: ts
                        )
                    )
                }
            }
            // newest first
            reviews = all.sorted(by: { $0.timestamp > $1.timestamp })
        }
    }
}
