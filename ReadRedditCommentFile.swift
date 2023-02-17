import Foundation

func readRedditCommentFile(fileName: String) -> RedditCommentData?
    {
        var json: RedditCommentData?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                //json = try? JSONSerialization.jsonObject(with: data)
                
                json = try JSONDecoder().decode(RedditCommentData?.self, from: data)
            } catch {
                // Handle error here
                print("Unexpected error: \(error).")
            }
        }
        return json
    }
