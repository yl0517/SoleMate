//
//  ReviewInputView.swift
//  SoleMate
//
//  Created by Yoobin Lee on 6/8/25.
//

import SwiftUI
import FirebaseDatabase

struct ReviewInputView: View {
    let shoe: Shoe
    @Environment(\.dismiss) private var dismiss
    @State private var reviewText = ""
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $reviewText)
                    .frame(height: 200)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3)))
                    .padding()

                Button(action: submitReview) {
                    Text(isLoading ? "Submitting…" : "Submit Review")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.CA0013)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                          || isLoading)

                Spacer()
            }
            .navigationTitle("Review \(shoe.name)")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    private func submitReview() {
        let text = reviewText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        isLoading = true

        let ref = Database.database().reference()
            .child("reviews")
            .child(String(shoe.id))
            .childByAutoId()
        let data: [String: Any] = [
            "text": text,
            "timestamp": Date().timeIntervalSince1970
        ]

        ref.setValue(data) { error, _ in
            DispatchQueue.main.async {
                self.isLoading = false
                if error == nil {
                    dismiss()
                } else {
                    // TODO: show an error alert
                }
            }
        }
    }
}
