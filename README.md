# **Rick and Morty App**
## **Mobile code challenge**

- - -

## **The task**
Create a native mobile app that displays a list of characters from Rick and Morty´s show and allow the user to navigate to the details of the last known location of a character. The application must fetch the information from a public API (information provided below).

### **Must-haves**
- List of characters.
- Detail of each character's last known location.
- Design your own UI, you have no limitations.

### **Good-to-haves**
- Set a character as favorite
- Paginated list (infinite list scroll)
- Unit and UI tests

## **Api REST**
You are allowed to use the following endpoints to fetch the data:

`GET https://rickandmortyapi.com/api/character`: Endpoint to fetch a static list of 20 characters.

`GET https://rickandmortyapi.com/api/character/?page={page_number}`: Endpoint to fetch a paginated list of characters providing the page number to request (20 per page).

`GET https://rickandmortyapi.com/api/location/{location_id}`: Endpoint to fetch the details of a location.

- - -

## **Technology**
* xCode 12.2
* Cocoapods 1.10.1
* Swift
* RxSwift
* Alamofire
* AlamofireImage

## Setup
```
$ mkdir RickAndMortyApp
$ cd RickAndMortyApp
$ git clone https://github.com/manuelcolmenero/rick-and-morty-app.git
$ cd rick-and-morty-app
$ pod install
```

## Requeriments
### Done
- List of characters.
- Detail of each character's last known location.
- Design your own UI, you have no limitations.
- Set a character as favorite.
- Paginated list (infinite list scroll).

### Not implemented
- Unit and UI tests

