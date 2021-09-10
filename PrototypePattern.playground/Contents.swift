/*
 
 This is an example implementation of Prototype Design Pattern
 
 Prototype Design Pattern is a creational design pattern which is
 used when creating new Objects. It reduces the expense of creating
 Objects which have multiple dependencies.
 
 It uses an already created instance and by copying its recourses
 or by copying its values, it creates a clone which can then be
 used as required.
 
 */


import Foundation

// MARK: - Prototype Design Pattern

// MARK: - Basic Implementation
class SmartPhone {
    
    var name: String
    var model: String
    var price: String
    var company: String
    var batteryLife: String
    var operatingSystem: String
    var hasEIS: Bool
    
    init(name: String, model: String, price: String, company: String, batteryLife: String, operatingSystem: String, hasEIS: Bool) {
        self.name               = name
        self.model              = model
        self.price              = price
        self.company            = company
        self.batteryLife        = batteryLife
        self.operatingSystem    = operatingSystem
        self.hasEIS             = hasEIS
    }
    
    func copy() -> SmartPhone {
        return SmartPhone(name: self.name, model: self.model, price: self.price, company: self.company, batteryLife: self.batteryLife, operatingSystem: self.operatingSystem, hasEIS: self.hasEIS)
    }
}


/*
 This is the common way of creating multiple objects of the same type.
 we can reduce the effort and increase efficiancy with using the prototype pattern.
 */

let iPhone8     = SmartPhone(name: "iPhone 8", model: "8", price: "599", company: "Apple", batteryLife: "24 Hrs", operatingSystem: "iOS", hasEIS: false)
let iPhone11    = SmartPhone(name: "iPhone 11", model: "11", price: "899", company: "Apple", batteryLife: "24 Hrs", operatingSystem: "iOS", hasEIS: false)
let iPhone12    = SmartPhone(name: "iPhone 12", model: "12", price: "999", company: "Apple", batteryLife: "24 Hrs", operatingSystem: "iOS", hasEIS: false)
let SamsungS9   = SmartPhone(name: "Samsung S9", model: "S9", price: "599", company: "Samsung", batteryLife: "24 Hrs", operatingSystem: "Android", hasEIS: false)
let SamsungA51  = SmartPhone(name: "Samsung A51", model: "A51", price: "399", company: "Samsung", batteryLife: "24 Hrs", operatingSystem: "Android", hasEIS: false)

// Now by using proto type pattern:

let samsungA71 = iPhone8.copy()
print(samsungA71.name)
print(iPhone8.name)

samsungA71.name = "Samsung A71"
print(samsungA71.name)
print(iPhone8.name)

/* As we can see the new instance created by using the copy method doesnt
 change anything for the prototype object
 */

// Now we try using the Prototype Pattern using the Apple Interface

// MARK: - Apple Interface Implementation
class SmartPhoneApple: NSObject, NSCopying {

    var name: String
    var model: String
    var price: String
    var company: String
    var batteryLife: String
    var operatingSystem: String
    var hasEIS: Bool
    
    init(name: String, model: String, price: String, company: String, batteryLife: String, operatingSystem: String, hasEIS: Bool) {
        self.name               = name
        self.model              = model
        self.price              = price
        self.company            = company
        self.batteryLife        = batteryLife
        self.operatingSystem    = operatingSystem
        self.hasEIS             = hasEIS
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return SmartPhoneApple(name: self.name, model: self.model, price: self.price, company: self.company, batteryLife: self.batteryLife, operatingSystem: self.operatingSystem, hasEIS: self.hasEIS)
    }
}


let iPhone12Pro = SmartPhoneApple(name: "iPhone 12 Pro", model: "12", price: "1299", company: "Apple", batteryLife: "24 Hrs", operatingSystem: "iOS", hasEIS: false)
let iPhone12ProMax = iPhone12Pro.copy() as! SmartPhoneApple
iPhone12ProMax.name = "iPhone 12 Pro Max"

print(iPhone12ProMax.name)
print(iPhone12Pro.name)

/*
 When creating a copy there are two types of copies that are created,
 one is Shallow Copy and one is Deep Copy.
 
 Shallow Copy only duplicates the value types and copies references to the
 reference types. (Copies as little as possible)
 
 Deep Copy duplicates both the value and reference types in the Prototype
 object.
 */


// MARK: - Shallow Copy
class SuperStoreShallow: NSObject, NSCopying {
    
    var name: String
    var location: LocationShallow
    
    init(name: String, location: LocationShallow) {
        self.name = name
        self.location = location
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return SuperStoreShallow(name: self.name, location: self.location)
    }
}


class LocationShallow {
    var sector: String
    var city: String
    
    init(sector: String, city: String) {
        self.sector = sector
        self.city = city
    }
}

let bestBuy = SuperStoreShallow(name: "bestBuy", location: LocationShallow(sector: "F8", city: "Islamabad, Pakistan"))
let saveMart = bestBuy.copy() as! SuperStoreShallow

print(bestBuy.location.city)

saveMart.location.city = "Lahore, Pakistan"

print(saveMart.location.city)
print(bestBuy.location.city)


/*
 As we see when we create a shallow copy it only copies the reference of Location.
 Thus, when we change the value of Location object in the clone it reflects on the Prototype
 object too. We can resolve this issue by creating a deep copy as explained below.
 */


// MARK: - Deep Copy
class SuperStoreDeep: NSObject, NSCopying {
    
    var name: String
    var location: LocationDeep
    
    init(name: String, location: LocationDeep) {
        self.name = name
        self.location = location
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return SuperStoreDeep(name: self.name, location: self.location.copy() as! LocationDeep)
    }
}


class LocationDeep: NSObject, NSCopying {
    var sector: String
    var city: String
    
    init(sector: String, city: String) {
        self.sector = sector
        self.city = city
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return LocationDeep(sector: self.sector, city: self.city)
    }
}

let nikeStore = SuperStoreDeep(name: "bestBuy", location: LocationDeep(sector: "F8", city: "Islamabad, Pakistan"))
let addidasStore = nikeStore.copy() as! SuperStoreDeep

print(nikeStore.location.city)

addidasStore.location.city = "Lahore, Pakistan"

print(nikeStore.location.city)
print(addidasStore.location.city)
