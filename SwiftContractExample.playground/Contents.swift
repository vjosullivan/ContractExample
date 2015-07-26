/*:
## Design by Contract

"The DbC approach assumes all client components that invoke an operation on a server component will meet the preconditions specified as required for that operation."
[Wikipedia](https://en.wikipedia.org/wiki/Design_by_contract)

If the client is responsible for checking preconditions are met then the need for error checking, trapping, throwing and handling is largely designed out of the system and limited to handling genuine errors.
*/

struct Person {
    let name: String
    var age: Int
}

struct PersonViewModel {
    var name: String?
    var age: String?
    
    func personCreateable() -> Bool {
        // Just checking not doing, so no errors thrown.
        guard let _ = age, _ = Int(age!), let name = name
            where name.characters.count > 0 else {
                return false
        }
        return true
    }
    /*:
    Because pre-conditions are assumed to have been met, the operation is greatly simplified and focussed on its own responsibility (meeting the post-conditions).
    */
    func createPerson() -> Person {
        // "Do or do not.  There is no try."
        return Person(name: name!, age: Int(age!)!)
    }
}

var model = PersonViewModel()
if model.personCreateable() {
    let eve = model.createPerson()
} else {
    print("Need more data...")
}
