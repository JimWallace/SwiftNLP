struct RedditSubmission : Decodable {
    let author: String
    let author_flair_css_class: String?
    let author_flair_text: String?
    let created_utc: Int32?
    let domain: String
    let full_link: String
    let id: String
    let is_self: Bool
    fileprivate let media_embed: AnyDecodableValue // FIXME: Revisit this later
    let num_comments: Int32
    let over_18: Bool
    let permalink: String
    let score: Int32
    let selftext: String
    let subreddit: String
    let subreddit_id: String
    let thumbnail: String
    let title: String
    let url: String
}
