# CampusZen

A student productivity tool designed to help manage academic life in one place. CampusZen allows students to organize their tasks, track upcoming exams, and manage their schedules — all with calendar integration and smart notifications to keep them on top of their responsibilities.

> 🔧 **Status:** Currently under active development.

---

## Features

- **Task Management** — create, organize, and track pending assignments and to-dos.
- **Exam Tracking** — keep a clear record of upcoming exams and deadlines.
- **Schedule Management** — manage your weekly timetable in a structured and intuitive way.
- **Calendar Integration** — visualize all your academic events in a unified calendar view.
- **Notifications** — get timely reminders so nothing slips through the cracks.

---

## Tech Stack

| Layer         | Technology                               |
|---------------|------------------------------------------|
| Frontend      | JSP, HTML, CSS, Bootstrap                |
| Backend       | Java Servlets, JavaScript                |
| Database      | MySQL                                    |
| DB Connector  | MySQL JDBC Driver                        |
| Server        | Apache Tomcat                            |

---

## Installation & Setup

### Prerequisites

- [Java JDK](https://www.oracle.com/java/technologies/downloads/)
- [Apache Tomcat](https://tomcat.apache.org/)
- [MySQL](https://www.mysql.com/)
- MySQL JDBC Driver

### Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/campuszen.git
   ```

2. **Set up the database:**
   - Open MySQL and run the `.sql` script included in the project to create the database and its tables.

3. **Configure the JDBC connection:**
   - Follow the driver's instructions to set up the connection to your MySQL instance (host, port, username, and password).

4. **Deploy to Tomcat:**
   - Copy the project into Tomcat's `webapps` directory, or import it into your IDE (Eclipse, IntelliJ, etc.) and run it on the server.

5. **You're all set!** Open your browser and navigate to `http://localhost:8080/campuszen` (or whichever port you have configured).

---

## Roadmap

- [ ] Core task and exam management
- [ ] Calendar integration
- [ ] Push notifications
- [ ] Mobile-responsive UI improvements
- [ ] User authentication and session management

---

## License

MIT — free to use, modify, and distribute.
