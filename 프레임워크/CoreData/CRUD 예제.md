# CRUD 예제

간단한 예제로 CRUD와 추가로 갯수를 구하는 카운트 메소드도 정의해 보겠습니다.  

# 예제 Entity
<img width="948" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/a0fd9b53-2565-4aae-9d95-b0033886d4a5">


# context 생성 
```swift
private var context: NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}
```

coredata stack중 Context 객체를 통해 저장, 삭제 등을 실행하게 되는데 이를 coredata manager 클래스에서 접근 할 수 있도록 생성해 줍니다. 
get 프로퍼티, init시 변수 초기화, 각 메소드마다 context변수 정의 등의 방법이 있을 것으로 생각 되는데 저는 전자로 만들어 보았습니다. 

UIkit에서는 프로젝트를 생성할 때 Coredata옵션을 체크하면 appDelegate에 persistentContainer 변수가 생성이 되고 이를 이용해 context에 접근할 수 있습니다. 

```swift
// in appdelegate
// MARK: - Core Data stack

lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
    */
    let container = NSPersistentContainer(name: "SearchApp")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()
```

체크를 못했다면, SwiftUI라면? 

# Create
만약 entity의 종류가 더 많다면? 제너릭을 사용한다면 재사용성이 높아지지 않을까?

try 구문은 핸들링을 할 수 있도록 . 

save()가 자주 사용 된다면 따로 메소드를 정의해 모듈화

```swift
// MARK: - Create
func saveRecord(word: String) {
    guard let entity = NSEntityDescription.entity(forEntityName: "SearchRecord", in: context) else { return }
    let object = NSManagedObject(entity: entity, insertInto: self.context)

    object.setValue(word, forKey: "word")
    object.setValue(Date(), forKey: "time")

    try? self.context.save()
}

func saveRecord2(word: String) {
    let object = SearchRecord(context: self.context)
    
    object.word = word
    object.time = Date()

    try? self.context.save()
}
```

# Read
read 이후 사용할 때 NSManagedObject 프로토콜보단 프로토콜을 채택한 entity 클래스로 read하면 접근시 일반 클래스 처럼 dot syntax로 접근하면 되어 더 편리 한 듯. 

```swift
// MARK: - Read
func readRecord() -> [NSManagedObject] {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SearchRecord")
//        let fetchRequest = NSFetchRequest<SearchRecord>(entityName: "SearchRecord")
    let result = try? self.context.fetch(fetchRequest)
    return result!
}

func readRecord2() -> [SearchRecord] {
    let fetchRequest = SearchRecord.fetchRequest()
    let result = try? self.context.fetch(fetchRequest)
    return result!
}
```

# update
index로도 접근하는 예제를 본 것 같은데 고유값인 objectID를 바탕으로 업데이트 하는 것이 더 안전 할 것 같습니다. 

```swift
// MARK: - Update

// 변경할 오브젝트의 오브젝트아이디를 바탕으로 기존의 오브젝트를 변경합니다.
func updateObject2(object: SearchRecord) {
    let updated = self.context.object(with: object.objectID) as? SearchRecord
    // 변경 속성
    updated?.word = object.word
}
```

# delete
```swift
// MARK: - Delete
func deleteAll() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchRecord")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    try? self.context.execute(deleteRequest)
}

// deleteAll() 이랑 다르게 연속 호출시 에러 ????? 뭔 차이지..
func deleteAll2() {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SearchRecord.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    try? self.context.execute(deleteRequest)
}

func deleteObject(object: NSManagedObject) {
    self.context.delete(object)
    try? self.context.save()
}

func deleteObject2(object: SearchRecord) {
    self.context.delete(object)
    try? self.context.save()
}
```

# Count
```swift
// MARK: - Count
func getCount() -> Int? {
    do {
        let count = try self.context.count(for: SearchRecord.fetchRequest())
        return count
    } catch {
        return nil
    }
}
```

# 전체 
```swift
import CoreData
import UIKit

class CoreDataManager {
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    static let shared = CoreDataManager()

    private init() { }


    // MARK: - Create
    func saveRecord(word: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "SearchRecord", in: context) else { return }
        let object = NSManagedObject(entity: entity, insertInto: self.context)

        object.setValue(word, forKey: "word")
        object.setValue(Date(), forKey: "time")

        try? self.context.save()
    }

    func saveRecord2(word: String) {
        let object = SearchRecord(context: self.context)
        
        object.word = word
        object.time = Date()

        try? self.context.save()
    }

    // MARK: - Read
    func readRecord() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SearchRecord")
//        let fetchRequest = NSFetchRequest<SearchRecord>(entityName: "SearchRecord")
        let result = try? self.context.fetch(fetchRequest)
        return result!
    }

    func readRecord2() -> [SearchRecord] {
        let fetchRequest = SearchRecord.fetchRequest()
        let result = try? self.context.fetch(fetchRequest)
        return result!
    }

    // MARK: - Update

    // 변경할 오브젝트의 오브젝트아이디를 바탕으로 기존의 오브젝트를 변경합니다.
    func updateObject2(object: SearchRecord) {
        let updated = self.context.object(with: object.objectID) as? SearchRecord
        // 변경 속성
        updated?.word = object.word
    }

    // MARK: - Delete
    func deleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchRecord")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        try? self.context.execute(deleteRequest)
    }

    // deleteAll() 이랑 다르게 연속 호출시 에러 ????? 뭔 차이지..
    func deleteAll2() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SearchRecord.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        try? self.context.execute(deleteRequest)
    }

    func deleteObject(object: NSManagedObject) {
        self.context.delete(object)
        try? self.context.save()
    }

    func deleteObject2(object: SearchRecord) {
        self.context.delete(object)
        try? self.context.save()
    }

    // MARK: - Count
    func getCount() -> Int? {
        do {
            let count = try self.context.count(for: SearchRecord.fetchRequest())
            return count
        } catch {
            return nil
        }
    }

}
```
