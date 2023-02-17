struct RedditComment : Decodable {
    let author: String
    let author_created_utc: Int32?
    let author_flair_css_class: String?
    let author_flair_text: String?
    let author_fullname: String?
    let body: String
    let controversiality: Int32
    let created_utc: Int32
    let distinguished: String?
    let gilded: Int32
    let id: String
    let link_id: String
    let nest_level: Int32
    let parent_id: String
    let reply_delay: Int32
    let retrieved_on: Int32
    let score: Int32
    let score_hidden: Bool
    let subreddit: String
    let subreddit_id: String
}
