from pymongo import MongoClient

client = MongoClient('mongodb://localhost', 27017)
restaurants = client['test']['restaurants']

def delete_one_Brooklyn():
    restaurants.delete_one({"borough": "Brooklyn"})

def delete_all_Thai():
    restaurants.delete_many({"cuisine": "Thai"})

delete_one_Brooklyn()
delete_all_Thai()

thais = restaurants.find_one({"cuisine": "Thai"})

if thais is None:
    print("All thai restaurants are deleted")