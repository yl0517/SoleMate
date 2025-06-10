import FirebaseDatabase
import FirebaseAuth

class DiscussionViewModel: ObservableObject {
    @Published var posts: [DiscussionPost] = []
    @Published var userNames: [String: String] = [:] // userId: name
    var authListenerHandle: AuthStateDidChangeListenerHandle?

    private var ref = Database.database().reference()

    init() {
        listenForPosts()
    }

    func listenForPosts() {
        ref.child("discussions").observe(.value) { snapshot in
            var newPosts: [DiscussionPost] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let jsonData = try? JSONSerialization.data(withJSONObject: dict),
                   let post = try? JSONDecoder().decode(DiscussionPost.self, from: jsonData) {
                    newPosts.append(post)
                    self.fetchUserName(userId: post.userId)
                }
            }
            newPosts.sort { $0.timestamp < $1.timestamp }
            DispatchQueue.main.async {
                self.posts = newPosts
            }
        }
    }

    func fetchUserName(userId: String) {
        // Only fetch if not already cached
        if userNames[userId] != nil { return }
        ref.child("users").child(userId).child("name").observeSingleEvent(of: .value) { snapshot in
            if let name = snapshot.value as? String {
                DispatchQueue.main.async {
                    self.userNames[userId] = name
                }
            }
        }
    }

    func sendPost(userId: String, message: String) {
        let postRef = ref.child("discussions").childByAutoId()
        let post = DiscussionPost(
            id: postRef.key ?? UUID().uuidString,
            userId: userId,
            message: message,
            timestamp: Date().timeIntervalSince1970
        )
        let postDict: [String: Any] = [
            "id": post.id,
            "userId": post.userId,
            "message": post.message,
            "timestamp": post.timestamp
        ]
        postRef.setValue(postDict)
    }
}