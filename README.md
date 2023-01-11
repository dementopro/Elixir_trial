# Nearby

# DB 
Start Postgres locally as:

docker run --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgis/postgis

# Run Mix Task to migrate data from CSV

mix PopulateMobileFoodFacilityPermit

# API
- List all the food trucks near by

curl --location --request GET 'http://localhost:4000/api/mobile_food_facility/nearby?current_lat= "37.79236678688307"&current_lng= "-122.40014830676716"&radius="1000"'

radius is optional
current_lat and current_lng are required




