# Carma.Web
Carma First Web App
In this App:
- Stored Procedures and Views in SQL server and 3 tables Students, Classromms and Genders. 
- WebApi as a web service using c# is used (under Asp.Net web forms project).
- JQuery,  Bootstrap, Datatables.net control (paging, sorting, instant search, Add, Edit, Delete student).
- AutoComplete selectbox using  select2 library for class rooms and genders and they called SQL server stored procedures.
- Easy image upload while adding/editing student profile. 
- Simple PDF profile generator.
- All the task operations inside one page.

# How to use it?
- Run the attached SQL script file into SchoolDb (SQL server).
- Run the following command in Package Manager console windows under Crma.WebApp project.
- Update the connection string in Web.config file

> Update-Package -reinstall

https://docs.microsoft.com/en-us/nuget/consume-packages/reinstalling-and-updating-packages
