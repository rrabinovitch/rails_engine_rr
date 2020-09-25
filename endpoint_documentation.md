## Endpoints - _in progress_
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/da1d052829d18626e5cd)
* responses are JSON API 1.0 Compliant
* GET requests require params submitted via query params
* POST requests require params submitted via the request body
* make sure to follow the [local set up instructions](https://github.com/rrabinovitch/rails_engine_rr/blob/master/README.md#local-setup) and run `rails s` before consuming these endpoints 


### ITEMS
* items#index: `GET /items` - returns records of all items in the database
* items#show: `GET /items/<item_id>` - returns the record of the item with the corresponding id
* items#create: `POST /items` - creates a new item record with the attributes submitted via the request body and returns the new item record
    * request body:
        ```
        {
        "name": "<item name>,
        "description": "<item description>",
        "unit_price": "<item price>",
        "merchant_id": "<id of merchant selling this item>"
        }
        ```
* items#update: `POST /items/<item_id>` - updates the record of the item with the corresponding id and returns the updated record (can be used to update one or many attributes)
    * request body:
        ```
        {"<attribute>": "<updated attribute value>"}
        ```
* items#destroy: `DELETE /items/<item_id` - deletes the record of the item with the corresponding id and renders a `204 no content` response


### MERCHANTS
* merchants#index: `GET /merchants` - returns records of all merchants in the database
* merchants#show: `GET /merchants/<merchant_id>` - returns the record of the merchant with the corresponding id
* merchants#create: `POST /merchants` - creates a new merchant record with the attributes submitted via the request body and returns the new merchant record
    * request body:
        ```
        {"name": "<merchant name>"}
        ```
* merchants#update: `POST /merchant/<merchant_id>` - updates the record of the merchant with the corresponding id and returns the updated record
    * request body:
        ```
        {"<attribute>": "<updated attribute value>"}
        ```
* merchants#destroy: `DELETE /merchant/<merchant_id` - deletes the record of the merchant with the corresponding id and renders a `204 no content` response


### RELATIONSHIPS
* merchant items: `GET /merchants/<merchant_id>/items` - returns all items associated with the merchant with the corresponding id
* item merchant: `GET /items/<item_id>/merchant` - returns the merchant associated with the item with the corresponding id


### FINDERS
* items can be searched for by id, name, description, and unit price
* merchants can be searched for by id and name  
* future iterations may allow for searching by the date a record was created and/or updated  

**Single finders:** return the first record found with the matching attribute  
* `GET /items/find?<attribute>=<value>`  
* `GET /merchants/find?<attribute>=<value>` 

**Multi finders:** return all records found with the matching attribute  
* `GET /items/find_all?<attribute>=<value>`  
* `GET /merchants/find_all?<attribute>=<value>`  
   
   
### BUSINESS INTELLIGENCE
* merchants by most revenue: `GET merchants/most_revenue?quantity=<number>` - returns a variable number of merchants ranked by total revenue
