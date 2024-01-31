in order to se providers you have to add it to the pubspec

in order to conver json data to other data type than string

convert it to string first then the correct data type
i.e. `double.parse(jsonData['price'].toString())`

in order to retrieve multople data
loop the decoded data

pseudocode for http requests
HTTPResponse res = http.method(uri.parse(url))
if res != 200
  throw error

dyn decoded = jsonDecode(res.body)
model = Model.fromJson(decoded)

// if list
list items = empty(growable)

for Map<str, dyn> data in decoded['data location']
  items.add(Model.fromJson(data))

always attend to the format of the API
read carefully to the documentation, and use logs if necessary

post example
http.post(
  uri.parse(),
  headers: <str, str>{'name', 'val'},
  body: jsonEncode(<str, str>{'name', 'val'})
)

after the api class is ready
on the view, create a `late Future` variable, initialize it on the 
`@override void initState()`

then to display it use the FutureBuilder combined with whathever other componet to style it

snapshot error handling:

FutureBuilder:
  if snapshot.hasError
    return ErrorComponent()

  if snapshot.hasData && snapshot.data!.isEmpty
    return NothingFound

  if snapshot.connectionState == ConnectionState.done
    return Data

  return ProgressIndicator

## for fast navigation
use Navigator.push(ctx, MaterialPageRoute((builCtx) => WantedRoute()))

push when you want to be able to comeback, and pushReplace when not

## Deps
for http configure perms in the android src main manisfest file
http: ^1.1.2

if providers are needed
provider:

## Grids
GridViewBuilder
+ GridDelegateCrosAxisBlabla


## prettify
Use SizedBox and Spacer for spacing
round stuff always keep the 8 rules
pastel colors
consider removing appbar

material theme
easy way to get pretty buttons is by using MaterialButton
respect the time you have for stylizing

GestureDetector also nice to make "non button component" now a button

CircularProgressIndicator() for loading states
Divider() for hr

###### end