class UserModel: BaseJsonModel4{
    var id: Int? = 0
    var age: Int? = 0
    var pic: Data? = nil
    var userId: String? = nil
    var name: String? = nil
    var gender: String? = nil
    var friends: [FriendModel]? = nil
}

class FriendModel: BaseJsonModel4{
    var name: String? = nil
}

class BaseJsonModel4 {
    
    class func parseJson<T: Codable>(klass: T, _ jsonStr: String) -> Array<T> {
        let decoder = JSONDecoder()
        do {
            let responseData = jsonStr.data(using: String.Encoding.utf8)
            return try decoder.decode(T.self, from: responseData!)
        } catch {
            print("error trying to convert data to JSON")
            print(error)
            return nil
        }
    }
    
}

let jsonStr = "{\"userId\":\"123\", \"name\":\"Kitty\", \"gender\":\"女\", \"friends\": [ {\"name\":\"小明\"}, {\"name\":\"小軒\"}] }"

let u: UserModel? = UserModel.parseJson(jsonStr)
print("u = \(String(describing: u))")
print("u?.gender=\(String(describing: u?.gender))")
print("u?.friends=\(String(describing: u?.friends![1].name))")
