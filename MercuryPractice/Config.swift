import Foundation

enum Config {
    /// Where the practice API lives. `setup.sh` fills in your GitHub username.
    static let baseURL = URL(string: "https://raw.githubusercontent.com/manigaya/mercury-practice/main/api")!
}
