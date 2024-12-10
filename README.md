Our College Application Tracker Database System serves as a web application designed for students to efficiently manage their college application process. The system allows users to track their applications, deadlines, and statuses while providing features like task management and document storage. The purpose of our creation is to provide students with a centralized area to meet their deadlines and goals and track everything related to college applications, ensuring everything is easily accessible in one single place.

Users will be able to create an account, log in securely, manage individual colleges to apply to with customization for each college (average GPA, year founded, location, etc), tasks with deadlines. Overall, individuals will have a centralized application space to streamline the process. With features like task management and real-time progress tracking, we aimed to create a one-stop shop that keeps students organized while on top of deadlines.

Project Dependencies:
- Creating a Maven project with archetype webapp
    - Used to initialize a new Maven Web Application project
    - Creates a pom.xml where project dependencies are defined
- Utilized mysql-connector-j-8.0.33.jar
    - Allows communication with MySQL database to manage data storage and retrieval of information
    - Found this version from the internet
- javax.servlet package
    - Provides interface to create servlets
    - Helps generate dynamic web content
- Utilized Smart Tomcat (Apache Tomcat/9.0.97)
    - Allows us to run and test web application locally using tomcat server
    - Added to project from IntelliJ Marketplace
- JDK 23
    - Allows us to run with most recent and latest Java features
