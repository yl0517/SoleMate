import SwiftUI
import FirebaseAuth

struct DiscussionView: View {
    @StateObject private var viewModel = DiscussionViewModel()
    @State private var message = ""
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Title Bar
            HStack {
                Text("Discussion")
                    .font(.title2).bold()
                    .foregroundColor(Color.CA0013)
                Spacer()
            }
            .padding()
            .background(Color.FCFBF9)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
            
            // Messages List
            ScrollViewReader { proxy in
                List {
                    ForEach(viewModel.posts) { post in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.userNames[post.userId] ?? post.userId)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(post.message)
                                .padding(10)
                                .background(Color.FCFBF9)
                                .cornerRadius(10)
                            Text(Date(timeIntervalSince1970: post.timestamp), style: .time)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        .listRowBackground(Color.clear)
                        .id(post.id)
                    }
                }
                .listStyle(.plain)
                .background(Color.EEEBE3)
                .onChange(of: viewModel.posts.count) {
                    if let last = viewModel.posts.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            // Input Bar
            HStack {
                TextField("Type a message...", text: $message)
                    .padding(10)
                    .background(Color.FCFBF9)
                    .cornerRadius(16)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                hideKeyboard()
                            }
                        }
                    }
                Button(action: {
                    if let user = Auth.auth().currentUser, !message.trimmingCharacters(in: .whitespaces).isEmpty {
                        viewModel.sendPost(userId: user.uid, message: message)
                        message = ""
                        isInputActive = false
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 22))
                        .foregroundColor(Color.CA0013)
                        .padding(.horizontal, 8)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.white.shadow(radius: 2))
        }
        .background(Color.EEEBE3.ignoresSafeArea())
    }
}
