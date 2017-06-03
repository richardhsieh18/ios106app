import UIKit
/*
var str = "Hello, playground"

str = "test"

print(str)
//=======Simple Values(簡單值)=======
//使用let宣告常數，使用var宣告變數
var myVariable = 42     //使用型別推測
myVariable = 50
let myConstant = 42
//常數一開始可以不設值
let aConstant:Double
aConstant = 59.99   //常數一但在第一次設值之後，就不可以更動其值

let implicitInteger = 70    //推測成Int型別（32位元系統上，實際上是使用Int32，如果是64位元系統，實際上是使用Int64）
let implicitDouble = 70.0   //推測成Double型別
let explicitDouble:Double = 70  //明確指定型別為Double，不使用型別推測機制

//練習1：宣告一個常數，明確指定其型別為Float，初值設為4
let testContant:Float = 4.0

//Swift不會幫你自動轉型
let label = "The width is "
let width = 94
let widthLabel = label + String(width)

//練習2：試著移除最後一行的字串轉換，看看會有什麼錯誤

//使用\()語法可以值加入字串當中
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

//練習3：計算某人的BMI值（《體重kg》除以《身高公尺》的平方）
let name = "Perkin"
let bodyWeight = 60.5
let bodyHeight = 1.68
String(format: "%.2f", bodyWeight/(bodyHeight*bodyHeight))
let bmiMessage = "\(name),你的BMI值是：\(String(format: "%.2f", bodyWeight/(bodyHeight*bodyHeight)))"

//使用中括號[]來宣告陣列或字典，最後的逗號可以保留
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1]
//更改陣列元素的值
shoppingList[1] = "bottle of water"
shoppingList
//-------------補充-------------
//在陣列的最後加上一筆資料
shoppingList.append("banna")
shoppingList
//在陣列的特定位置加上一筆資料
shoppingList.insert("new", at: 2)
shoppingList
//-----------------------------

//字典內的元素為key:value的配對
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
//在字典內增加一筆新的查詢值（因為關鍵詞"Jayne"不存在原字典中）
occupations["Jayne"] = "Public Relations"

occupations

//當關鍵詞存在時，則修改字典內的值
occupations["Kaylee"] = "Engineer"

occupations

//---------<補充>陣列內存放字典---------
//宣告存放字典的陣列
var myData = [[String:String]]()

//準備第一本字典
let firstData = ["name":"Perkin","address":"新竹市光復路一段120號","age":"35"]

//將第一本字典加入陣列
myData.append(firstData)
myData

//第二本字典
let secondData = ["name":"Mary","address":"台北市林森北路一段300號","age":"25"]
myData.append(secondData)
myData
//--------------------------------

//使用初始化語法建立空陣列或空字典
var emptyArray = [String]()                 //原範例為let
var emptyDictionary = [String: Float]()     //原範例為let

//------------<補充>------------
//將資料加入空陣列
emptyArray = ["fdjfls","dfdfs"]
emptyArray.append("testdfdfd")

//將資料加入空字典
emptyDictionary = ["a":5,"b":3.5]
emptyDictionary["c"] = 6.9
//-----------------------------
shoppingList
shoppingList = []   //前方等號後的語法同此～[String]()
shoppingList

occupations = [:]   //前方等號後的語法同此～[String:String]()

//=======Control Flow(流程控制)=======
//使用if和switch來做狀況判斷，使用for-in、for、while、repeat-while來執行迴圈
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
//用for-in迴圈列出陣列
for score in individualScores
{
    if score > 50   //狀況判斷的小括號可以省略，但body的大括號不能省略！
    {
        teamScore += 3      //teamScore = teamScore + 3
    }
    else
    {
        teamScore += 1
    }
}
print(teamScore)

//使用問號（?）來標記選擇性變數
var optionalString:String? = "Hello"
//使用驚嘆號（！）將選擇性變數拆封（unwrap）使用
print(optionalString!)  //選擇性變數拆封時，必須確保有內含物（不是nil的狀態）
//檢查選擇性變數是否為nil
print(optionalString == nil)


var optionalName: String? = "John Appleseed"    //練習4：清空成nil的方式1~宣告後不設定初值，即為nil
optionalName = nil                              //練習4：清空成nil的方式2
var greeting = "Hello!"
//使用選擇性綁定（optional binding）語法來判斷選擇值是否存在
if let name = optionalName  //如果綁定成功，表示選擇值存在，才會進入if區段執行
{
    greeting = "Hello, \(name)" //選擇性綁定語法測試成功，變數自動拆封
}
else        //練習4：加上else區段
{
    greeting = "Hi"
}

//使用??運算符號為選擇值提供預設值
var nickName: String? = nil                 //原範例為let
nickName = "測試"
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"     //nickName != nil ? nickName!:fullName

//Swift的switch語法可以檢測任意型別，不限於只能檢測整數
let vegetable = "red pepper"
//-----<補充>字串的檢測-----
vegetable.hasPrefix("red")  //檢測以～開頭的字串
vegetable.hasSuffix("a")    //檢測以～結尾的字串
vegetable.contains("pp")    //檢測是否包含～字串
//-----------------------

switch vegetable
{
    case "celery":
        print("Add some raisins and make ants on a log.")
    case "cucumber", "watercress":
        print("That would make a good tea sandwich.")
    case let x where x.hasSuffix("pepper"):
        print("Is it a spicy \(x)?")
    default:        //當上面的case無法涵蓋所有檢測狀況時，必須提供default分支     //練習5：取消default，觀察錯誤訊息
        print("Everything tastes good in soup.")
}

//可以利用for-in迴圈來列出字典的key-value配對值
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],      //質數
    "Fibonacci": [1, 1, 2, 3, 5, 8],    //費式數列
    "Square": [1, 4, 9, 16, 25],        //平方
]
var largest = 0
//外迴圈列出字典的key-value配對
for (kind, numbers) in interestingNumbers
{
    //內迴圈列出該筆查詢值的陣列元素
    for number in numbers       //列出每一筆查詢值的陣列
    {
        if number > largest
        {
            largest = number
        }
    }
}
print(largest)

//練習6：在上面程式段中，加入另一個變數來追蹤最大的數字會出現在哪一類
largest = 0     //歸零
var largestKind = ""        //新增最大類別的追蹤
//外迴圈列出字典的key-value配對
for (kind, numbers) in interestingNumbers
{
    //內迴圈列出該筆查詢值的陣列元素
    for number in numbers       //列出每一筆查詢值的陣列
    {
        if number > largest
        {
            largest = number
            largestKind = kind      //新增紀錄最大數的類別所在
        }
    }
}
print("最大數：\(largest)在\(largestKind)")

//while迴圈，先檢測條件，再決定是否執行迴圈
var n = 2
while n < 100       //其實是可以多次檢測條件的if迴圈
{
    n *= 2
}
print(n)

//repeat-while迴圈是先執行一次，再檢測條件
var m = 2
repeat
{
    m *= 2
} while m < 100
print(m)

//可以使用..<來做成迴圈的區間索引範圍（..<不含上標，...包含上標）
var total = 0
for i in 0..<4
{
    total += i
}
print(total)

//使用倒轉區間來執行迴圈
total = 0
for i in (0..<4).reversed()
{
    total += i
}
print(total)

//迴圈正轉，但每次加2（不含上標）
total = 0
for i in stride(from: 0, to: 10, by: 2)
{
    total += i
}
print(total)

//迴圈正轉，但每次加2（包含上標）
total = 0
for i in stride(from: 0, through: 10, by: 2)
{
    total += i
}
print(total)

//迴圈反轉，但每次減2（不含上標）
total = 0
for i in stride(from: 10, to: 0, by: -2)
{
    total += i
}
print(total)

//迴圈反轉，但每次減2（包含上標）
total = 0
for i in stride(from: 10, through: 0, by: -2)
{
    total += i
}
print(total)

*/
/*

func greet(person: String, lunch: String) -> String {
    return "Hello \(person), today lunch is \(lunch)."
}

func greet(_ person: String, day: String) -> String {
    return "Hello \(person), today lunch is \(day)."
}
print(greet(person: "Bob", lunch: "pork"))
greet("Bob", day: "777")


let http404Error = (404, "not Found")

let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

let (justTheStatusCode, _) = http404Error
print("The status message is \(justTheStatusCode)")

print("The status message is \(http404Error.0)")
print("The status message is \(http404Error.1)")

var http200Status = (statusCode: 200,  description: "Ok")
print(http200Status)
print(http200Status.statusCode)

http200Status = http404Error
print(http200Status)

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)


func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
func averOf(numbers:Int...) ->Float{
    var sum = 0
    for number in numbers {
        sum += number
        
    }
    return Float(sum) / Float(numbers.count)
}
sumOf()
sumOf(numbers: 42, 597, 12)
let result = averOf(numbers: 4,5,7)
String(format: "%.2f", result)

func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()


func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)


func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

numbers.map { (num) -> Int in
    return num * 3
}

var numberArray = numbers.map { (num) -> Int in
    if num % 2 != 0
    {
        return 0
    }else{
    return num
    }
}
print(numberArray)

var numberArray1 = numbers.map { (num) -> Int in
    num % 2 != 0 ? 0 : num
}
print(numberArray1)


let sortedNumbers = numbers.sorted { (first, second)-> Bool in
    return first < second
}
print(sortedNumbers)

//Class

class Shape {
    var numberOfSides = 0
    let dimension = "EEE"
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    func howManySide(height: Int)->String{
        return "SSS sides\(dimension)"
    }
}

var shape = Shape()
shape.dimension
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()



class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    init(){
        name = "未知形狀"
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
var nameshape = NamedShape(name: "正方形")
nameshape.numberOfSides
nameshape.simpleDescription()
nameshape.name

//繼承
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

class Circle: NamedShape{
    var radius: Double
    
    init(radius: Double, name:String){
        self.radius = radius
        super.init(name: name)
    }
    
    func area() -> Double {
        return radius * radius * Double.pi
    }
    
    override func simpleDescription() -> String {
        return "A \(name) 的半徑為 \(radius)，面積為\(area())."
    }
}
let cir = Circle(radius: 10, name: "圓形")
cir.area()
cir.simpleDescription()

//convenience init
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
	}
}
var f = Food()
f.name


class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    var area:Double{
        get{
            let s = sideLength * 3 / 2
            let k = s*(s-sideLength)*(s-sideLength)*(s-sideLength)
            return sqrt(k)
            //return sqrt(((sideLength * 3)/2) * (((sideLength * 3)/2) - sideLength))  //算錯了，要修正
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)
print(triangle.area)



class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
    deinit {
        print("三角形與正方形被釋放了")
    }
}

var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
print(triangleAndSquare.square.sideLength)

/*  對class reference有疑問，待釋疑
var a = triangleAndSquare.square.sideLength
triangleAndSquare.square.sideLength = 80
print(a)
*/

let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
print(sideLength)  //尚未解封

var optionalTriangleAndSquare:TriangleAndSquare? = TriangleAndSquare(size: 5, name: "新三角形與正方形")
var aSideLength = optionalTriangleAndSquare?.square.sideLength    //選擇性串連
print(optionalTriangleAndSquare?.square.sideLength) //未拆封

optionalTriangleAndSquare = nil  //試deinit，下方Optional Binding則因為nil不執行
if let length = optionalTriangleAndSquare?.square.sideLength{
    print("邊長三倍\(length * 3)")
}
*/
//  =====Enumerations and Structures======0603======

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue)
        }
    }

}
let ace = Rank.ace
let aceRawValue = ace.rawValue

var five = Rank.five
five.rawValue
five.simpleDescription()

func compare(rank1:Rank, rank2:Rank) -> String {
    if rank1.rawValue > rank2.rawValue{
        return "前面\(rank1)大於後面\(rank2)"
    }else if rank1.rawValue < rank2.rawValue {
        return "前面\(rank1)小於後面\(rank2)"
    }else{
        return "前面\(rank1)等於後面\(rank2)"
    }
}
var r1 = Rank.two
var r2 = Rank.jack
compare(rank1: r1, rank2: r2)

enum CompassPoint3:String{
    case north = "N"
    case south = "S"
    case east
    case west
}

let dCP = CompassPoint3.south
dCP.rawValue


if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
		}


enum Suit:Int {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "♤"
        case .hearts:
            return "♡"
        case .diamonds:
            return "♢"
        case .clubs:
            return "♧"
        }
    }
    func color() -> String {
        switch self {
            case .spades,.clubs:
                return "Black"
            default:
                return "Red"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()
let heartsColor = hearts.color()


//================Struct===================

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }

    static func fullStack() -> [Card]   {
        var cards = [Card]()
        for s in Suit.spades.rawValue...Suit.clubs.rawValue
        {
            for r in Rank.ace.rawValue...Rank.king.rawValue
            {
                let card = Card(rank: Rank(rawValue: r)!, suit: Suit(rawValue: s)!)
                //return "The \(r.simpleDescription()) of \(s.simpleDescription())"
                cards.append(card)
            }
        }
        return cards
    }
}
var threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

var testCard = threeOfSpades  //此處動作為copy,not refference
testCard.simpleDescription()
threeOfSpades = Card(rank: .five, suit: .diamonds)
threeOfSpades.simpleDescription()
testCard.simpleDescription()

Card.fullStack()

//值型別(Value Type)   Vs. 引用型別(Reference Type)
//「結構」和「列舉」是值型別(Value Type)，Int,Double,Dictionary,Array都是結構!
//「類別」是引用型別(Reference Type)，涉及到記憶體的引用計數(Reference Counting)之釋放

struct Resolution{
    var width = 0
    var height = 0
}

class VideoMode{
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    
    deinit {
        print("釋放記憶體")
    }
}
let someResolution = Resolution()
let someVideoMode = VideoMode()

print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

let vga = Resolution(width: 640, height: 480)
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd   //結構值的copy
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

enum CompassPoint4 {
    case north, south, east, west
}
var currentDirection = CompassPoint4.west
let rememberedDirection = currentDirection    // enum 的 copy
currentDirection = .east
if rememberedDirection == .west {
    print("The remembered direction is still .west")
}

// class是引用型別(Reference Type)

var tenEighty:VideoMode! = VideoMode()  //此處調整為var 和Optional，此時引用計數為1
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

//此處為class實體「記憶體位置」的引用
var alsoTenEighty:VideoMode! = tenEighty   //此處調整為var 和Optional，此時引用計數為2
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

alsoTenEighty.resolution = vga  //改掉原值，因為是引用同個記憶體位置
print("\(tenEighty.resolution)")
print("\(alsoTenEighty.resolution)")



tenEighty = nil         //引用計數降為1
alsoTenEighty = nil  //引用計數降為0，此時觸發ARC機制，釋放已經配置的記憶體空間


if tenEighty === alsoTenEighty {
print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."


//============Protocols and Extensions ===================

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    
    func adjust() {
     simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
    simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
