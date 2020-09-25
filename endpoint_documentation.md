## Endpoints
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/da1d052829d18626e5cd)
* responses are JSON API 1.0 Compliant
* GET requests require params submitted via query params
* POST requests require params submitted via the request body
* make sure to follow the local set up instructions above and run `rails s` before consuming these endpoints 

### GET ITEMS
Returns all records of items
Request: `GET localhost:3000/api/v1/items` 

Response body:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
                "unit_price": 751.07,
                "merchant_id": 1
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.",
                "unit_price": 670.76,
                "merchant_id": 1
            }
        },
      ...<remaining item records>...
    ]
}
        
```
### GET MERCHANTS
Returns all records of items
Request: `GET localhost:3000/api/v1/road_trip` 
* body must include `origin`, `destination`, and `api_key` params
* you will receive a 401 unauthorized error if bad credentials are submitted

#### Example:
Request: `POST localhost:3000/api/v1/road_trip`  
Request body:
```
{"origin": "Denver, CO",
   "destination": "Pueblo, CO",
   "api_key": "9167e13a-9fb2-49c9-8165-c64c2ff335b1"}
```
Response body:
```
{
    "data": [
        {
            "id": "1",
            "type": "item",
            "attributes": {
                "name": "Item Qui Esse",
                "description": "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
                "unit_price": 751.07,
                "merchant_id": 1
            }
        },
        {
            "id": "2",
            "type": "item",
            "attributes": {
                "name": "Item Autem Minima",
                "description": "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.",
                "unit_price": 670.76,
                "merchant_id": 1
            }
        },
        {
            "id": "3",
            "type": "item",
            "attributes": {
                "name": "Item Ea Voluptatum",
                "description": "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.",
                "unit_price": 323.01,
                "merchant_id": 1
            }
         ..<remaining item records>..
        }
    ]
}
        
```
