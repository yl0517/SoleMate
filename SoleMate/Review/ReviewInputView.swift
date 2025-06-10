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
            VStack(spacing: 0) {
                // TextEditor with clipped rounded background
                TextEditor(text: $reviewText)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding()
                
                // Centered, intrinsic-sized Submit button
                HStack {
                    Spacer()
                    Button(action: submitReview) {
                        Text(isLoading ? "Submitting…" : "Submit Review")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.CA0013)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading)
                    Spacer()
                }
                .padding(.bottom, 20)
                
                Spacer()
            }
            .navigationTitle("Review \(shoe.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
            .background(Color.EEEBE3.ignoresSafeArea())
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        hideKeyboard()
                    }
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
