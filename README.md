# Questions about the decissions made in the app

## JSONProcessing: which alternatives exist apart from using *type(of:)*? is, as?
In the app I explicitly made a casting of the result JSONProcessing gives so that I could use it. I used the reserved keyword _as_ to accomplish that.

However, I think there can be better ways to handle it more elegantly. For example, by making an extension of the JSONProcessing method used in the app to avoid casting every time it is used in the app.

Personally I wouldn't use *type(of:)*, though it is a perfect solution - I think the code gets more verbose while it isn't much more intention-revealing.

## Where will you place data such as the JSON with the books, the cover images and the PDF files?
I think these temporal data is better stored in the *caches* directory of the app's main bundle. It's not a good practice to store them in a location where the operating system cannot reach to delete them in case of excessive storage consumption.

## How did you manage to store the _isFavorite_ property of every book? Do you know some other alternatives?
I believe this information is an appropriate candidate to be stored by UserDefaults - it is information relevant to the user that is desirable to be persisted as long as the app lives and the user wants (it can't be retrieved again like the data mention earlier). Furthermore, it is little information so that it won't compromise neither the performance of the app nor the performance of the operating system.

## How did you send information from the Book to the LibraryViewController? Do you know some other alternatives?
In my case I applied the Delegate pattern, making the LibraryViewController the delegate of the BookViewController for this specific action. 

On one hand, this information can't be transmitted via Target/Action - the Book class doesn't belong to the LibraryViewController (using this model is not its responsibility. Otherwise it would be aberrant).

 On the other hand, this information is only concerned to the LibraryViewController (it updates the Library), so using notifications is not needed.

## Why isn't it a bad option to use the *reloadData* method from *UITableView*? Can you come across an alternative? When is it worth using it?
I believe the operation that consumes more resources is the downloading process of images and PDFs. Since those tasks are executed once and their results are stored in cache, the reload of the table data is not _expensive_. There may be some scenarios while reloading the table data can be _expensive_ though I can't think of any currently (I´ll try to minimize the number of executions of those heavy processes). Given that situation I'll opt for creating some methods in the controller that will perform the desired modifications (again, I'll try to minimized the reach of those modifications, in case the solution is worse than the problem). 

## How did you change the PDF when the user changes the current book in the *LibraryViewController*?
I used notifications in this case, because I can't modify the PDF using Target/Action and I already assigned a delegate to the LibraryViewController to be aware of every book selection (the BookViewController).

The LibraryViewController posts a notification with a book attachment when the user selects a new book. Then, if the PDFViewController is visible (thus subscribed to the aforementioned notification), it will receive the notification and will reload the UIWebView with the new book's PDF URL.

# Extras

## Which extra features will you add to the app before uploading it to the App Store?
To make the app more appealing, I'll add some of the following features:
* A search field to find books by terms in its title, authors or tags
* A rating field in every book detail view (it could be placed as a new item in the TabBar)
* A place where users can make reviews about the book
* Adding a specialized PDF controller to let users zoom the content, take notes and add bookmarks

## Which other similar apps will you create?
This app can be easily adapted to show a large collection of items stored in a database, where users can interact with those items or know more about them. For instance, I can think of an application displaying a film collection so people can watch them, and another that displays a food catalog (be it wine, cheese, beer...) and informs the users about their composition and indicates the nearest restaurant that serves them. _The sky is the limit_.

## How can you make money with HackerBooks?
Maybe this app can be a good one in which to include some ads, but I'll focus more on adding in-app purchases. For example, the application can have some private collections of books that the user will need to pay in order to view their PDFs (otherwise the user can only see a few pages of the book), and have a premium option that lets offline storage and integration with iCloud or other cloud services.

