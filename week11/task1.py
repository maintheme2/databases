from pymongo import MongoClient

client = MongoClient('mongodb://localhost', 27017)

restaurants = client['test']['restaurants']

def display_Irish():
    for restaurant in restaurants.find({'cuisine': 'Irish'}):
        print(restaurant['name'])

def display_Irish_and_Russian():
    for restaurant in restaurants.find({"$or": [{'cuisine': 'Italian'}, {'cuisine': 'Russian'}]}):
        print(restaurant['name'])

def find_by_address(address: list):
    street_name = address[0]
    building = address[1]
    zipcode = address[2]
    restaurant = restaurants.find_one({"address.street": street_name, 
                                        "address.building": building, 
                                        "address.zipcode": zipcode})
    print(restaurant['name'])

print("Irish cuisine:")
display_Irish()
print("\n")
print("Irish and Russian cuisine:")
display_Irish_and_Russian()
print("\n")
print("Find by address:")
find_by_address(['Prospect Park West', '284', '11215'])