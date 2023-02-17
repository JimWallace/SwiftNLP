struct RedditCommentData : Decodable {
    let index: [String: Int32]
    let posts: [RedditComment]
    
    init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()
            var tmp_index: [String: Int32]? = nil
            var elements: [RedditComment] = []
            
            do {
                tmp_index = try container.decode([String: Int32].self)
            } catch {
//                _ = try? container.decode(AnyDecodableValue.self)
            }
        
            while !container.isAtEnd {
                do {
                        let value = try container.decode(RedditComment.self)
                        elements.append(value)
                    } catch {
 //                       _ = try? container.decode(AnyDecodableValue.self)
                    }
            }
        if let idx = tmp_index {
            index = idx
        } else {
            index = [String: Int32]()
        }
        posts = elements
        }
}
