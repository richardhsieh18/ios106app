/*
 import Foundation
var numbers = [20, 19, 7, 12]
numbers.map({ (number: Int) -> Int in
    if (number % 2) != 0 { return 0 }
    let result = 3 * number
    return result
})

let name = "Sam"
let height:Double = 170
let weight:Double = 50

print("\(name), Your BMI is \(weight/pow(height/100,2))")
print(String(format:"%.2f", weight/(pow(height/100,2.0))))
*/
/*
var fontenotsCandyJar = ["Choppers","Jaw Bombs"]
var dipresCandyJar = ["Butterbar", "Mrs. Goodbuys", "Giggles"]
fontenotsCandyJar.append("Bubble Tea")
fontenotsCandyJar.insert("ToFu", at: 1)
print(fontenotsCandyJar)

let a1 = ["name": "AAAAAA", "tel": "00000000"]
let a2 = ["name": "CCCCCC", "tel": "22222222"]

var arrDict = [[String:String]]()
arrDict.append(a1)
print(arrDict)
arrDict.append(a2)
print(arrDict)

var address: [String:String] = ["Taipei":"Taipei government", "Kao":"Kaoshiung", "Tai":"Taichung"]
address
print(address["Tai"]!)


//陣列內存放字典
var mydata = [[String:String]]()

//準備第一本字典
let firstDate = ["name":"Perkin", "address":"台東","age":"12"]
mydata.append(firstDate)
print(mydata)

let secondDate = ["name":"Irvis", "address":"美國","age":"80"]
mydata.append(secondDate)
print(mydata)

var emptyArray = [String]()
var emptyDict = [String:Float]()

emptyArray = ["XXXX","YYYY"]
emptyArray.append("OMG")
emptyDict = ["a": 5, "b": 7]
emptyDict["c"] = 888
emptyDict
*/

//Control Flow
let individualScores = [75,5,100,98,11]
var teamScore = 0
for score in individualScores
{
    if score > 50
    {
        teamScore += 3
    }
    else
    {
        teamScore += 1
    }
}

var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
greeting = "Hello, \(name)"
}

var nickName: String? = nil
nickName = "測試"
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)" //nickName != nil ? nickName!:fullName

let vegetable = "red pepper"
switch vegetable
{
    case "celery":
        print("Add some raisins and make ants on a log.")
    case "cucumber", "watercress":
        print("That would make a good tea sandwich.")
    case let x where x.hasSuffix("pepper"):
        print("Is it a spicy \(x)?")
    default:
        print("Everything tastes good in soup.")
}

