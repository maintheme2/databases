from geopy.geocoders import Nominatim
import psycopg2
con = psycopg2.connect(database="dvdrental", user="postgres",
                       password="postgres", host="127.0.0.1", port="5432")

print("Database opened successfully")
cur = con.cursor()
cur.callproc("get_addresses", None)

addresses = []

row = cur.fetchone()
while row is not None:
    addresses.append(row)
    row = cur.fetchone()

geolocator = Nominatim(user_agent="dvdrental")

cur.execute('''alter table address 
            add column latitude float,
            add column longitude float;''')

for address in addresses:
    location = geolocator.geocode(address, timeout = 10)
    if location is not None:
        cur.execute('UPDATE address SET longitude=%s, latitude=%s WHERE address=%s;', (location.longitude, location.latitude, address))
        con.commit()
    else:
        cur.execute('UPDATE address SET longitude=%s, latitude=%s WHERE address=%s;', (0.0, 0.0, address))
        con.commit()

cur.close()
con.close()