struct RedditAuthResponse: Decodable
{
    let access_token: String
    let token_type: String
    let expires_in: Int
    let scope: String
}
