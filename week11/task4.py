import datetime
from pymongo import MongoClient

client = MongoClient('mongodb://localhost', 27017)
restaurants = client['test']['restaurants']

def count_A(restaurant_name):
    return restaurants.count_documents({"grades.grade": "A", "name": restaurant_name})

west_park_restaurants = restaurants.find({"address.street": "Prospect Park West"})

for restaurant in west_park_restaurants:
    if count_A(restaurant['name']) > 1:
        restaurants.delete_one(restaurant)
    else:
        updated_grades = restaurant['grades'].append({"date": datetime.datetime(2023, 4, 4), "grade": "A", "score": 15})
        restaurants.update_one(restaurant, {"$set": {"grades": updated_grades}})