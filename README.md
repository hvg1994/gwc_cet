# gwc_cet

A new Flutter project.

## Getting Started

# Folder Structure
Flow of MVVM
--> Ui -> Controller -> Repo Functions(Logics are in RepoVm class) 
-> RepoVm will call BaseApiService Class (Logics are in ApiService class) 

lib-------

---api----------> 
    --> api_response     -> added all the stages (idle, loading, completed, error)
    --> api_urls         -> All the Url end points
    --> app_exceptions   -> Added some Exceptions
    --> base_api_service -> Added all type of response with header, without header, with attachment, without attachment

---repository---> apiService and all other repositories
    --> in the _vm file all logics added where we call the api service functions

---Controller --> this was the class where we calling repository functions
    --> we need to call this controller in UI

---model--------> deserialized Json response


---screens------> All UI
    --> for Ui Updation we r using Consumer()
    --> Based on the status we r showing the respective UI

---utils--------> All Constants
    -->Constants        -> colors, some Icon Paths, fontsizes, textstyles   

---widgets------> Custom Widgets