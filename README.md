# Travel Memory

`.env` file to work with the backend after creating a database in mongodb: 

```
MONGO_URI='ENTER_YOUR_URL'
PORT=3001
```

Data format to be added: 

```json
{
    "tripName": "Incredible India",
    "startDateOfJourney": "19-03-2022",
    "endDateOfJourney": "27-03-2022",
    "nameOfHotels":"Hotel Namaste, Backpackers Club",
    "placesVisited":"Delhi, Kolkata, Chennai, Mumbai",
    "totalCost": 800000,
    "tripType": "leisure",
    "experience": "Lorem Ipsum, Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum, ",
    "image": "https://t3.ftcdn.net/jpg/03/04/85/26/360_F_304852693_nSOn9KvUgafgvZ6wM0CNaULYUa7xXBkA.jpg",
    "shortDescription":"India is a wonderful country with rich culture and good people.",
    "featured": true
}
```


For frontend, you need to create `.env` file and put the following content (remember to change it based on your requirements):
```bash
REACT_APP_BACKEND_URL=http://localhost:3001
```

# MERN DevOps Project (Terraform + Ansible)
## Project Overview
This project focuses on deploying a complete MERN stack application on AWS using Terraform for infrastructure creation and Ansible for configuration management and deployment. The application consists of a React frontend, Node.js backend, and MongoDB database.

## Architecture
The application follows a three tier architecture.
Browser connects to React frontend running on public EC2 on port 3000.
Frontend communicates with Node backend running on the same EC2 on port 3001.
Backend connects to MongoDB hosted on a private EC2 instance on port 27017.

                     INTERNET
                         │
                         ▼
               ┌────────────────────────────┐
               │      Public Subnet         │
               │                            │
               │  ┌──────────────────────┐  │
               │  │ Frontend (Port 3000) │  │
               │  └──────────┬───────────┘  │
               │             │              │
               │  ┌──────────▼───────────┐  │
               │  │ Backend (Port 3001)  │  │
               │  └──────────┬───────────┘  │
               │             │              │
               └─────────────┼──────────────┘
                             │
                             ▼
               ┌────────────────────────────┐
               │     Private Subnet         │
               │                            │
               │  ┌──────────────────────┐  │
               │  │ MongoDB (27017)      │  │
               │  └──────────────────────┘  │
               └────────────────────────────┘

## Infrastructure Setup using Terraform
Terraform is used to create the AWS infrastructure from scratch.
Resources created:
VPC with CIDR 10.0.0.0/16
Public subnet for web and ansible servers
Private subnet for database server
Internet Gateway for public internet access
NAT Gateway for private subnet outbound access
Route tables and associations
Security groups for web and database servers
Key pair for SSH access
EC2 instances for web, database and ansible
screenshots/terraform.png
screenshots/vpc.png





## Security Configuration
Web server security group allows:
Port 22 for SSH
Port 3000 for frontend
Port 3001 for backend
Port 80 for HTTP
Database security group allows:
Port 27017 only from web security group
Port 22 only from web security group
screenshots/web-sg.png
screenshots/db-sg.png

## Configuration and Deployment using Ansible
Ansible is used to configure servers and deploy the application.
Database playbook:
Installs MongoDB
Configures bind IP to allow internal communication
Starts MongoDB service
Web playbook:
Installs Node.js
Clones MERN repository
Installs backend dependencies
Configures backend environment variables
Starts backend server
Installs frontend dependencies
Builds React application
Serves frontend using serve
screenshots/db-playbook.png
screenshots/web-playbook.png

## Application Flow
User opens application in browser.
Request goes to React frontend on port 3000.
Frontend sends API request to backend on port 3001.
Backend processes request and interacts with MongoDB.
MongoDB stores or retrieves data.
Response is sent back to frontend and displayed to user.
screenshots/flow.png

## Challenges Faced
Backend was not accessible initially due to binding to localhost
Security group for backend port 3001 was missing
MongoDB connection issues due to configuration


## Solutions Implemented
Updated backend to listen on 0.0.0.0
Added port 3001 in security group
Configured MongoDB to allow external connection within VPC


## Final Result
The MERN application is successfully deployed on AWS
Infrastructure is created using Terraform
Configuration and deployment are automated using Ansible
Frontend and backend are accessible via public IP
Data can be added and retrieved successfully
screenshots/home.png
screenshots/add.png
screenshots/data.png

## How to Run
Terraform setup
terraform init
terraform apply
Ansible setup
ansible-playbook db.yml
ansible-playbook web.yml