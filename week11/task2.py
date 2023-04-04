import datetime
from pymongo import MongoClient

client = MongoClient('mongodb://localhost', 27017)
restaurants = client['test']['restaurants']


def insert_restaraunt():
    restaurants.insert_one(
        {
            'address': {'building': '126', 'coord': [-73.9557413, 40.7720266], 'street': 'Sportivnaya', 'zipcode': '420500'},
            'borough': 'Innopolis', 
            'cuisine': 'Serbian',
            'name': 'The Best Restaurant',
            'restaurant_id': '41712354',
            'grades': [{'date': datetime.datetime(2023, 4, 4), 'grade': 'A', 'score': 11}]
        })
        
insert_restaraunt()

new_restik = restaurants.find_one({"restaurant_id": "41712354"})
print(new_restik)