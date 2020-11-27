# Docker Compose for Laravel

### Services integrated
* PHP + Laravel backend server
* Nginx frontend server

### Working
Just one command to dominate them all. Git Clone this project, go to the main folder (where docker-compose.yaml is)
and type the following:
```
docker-compose up -d
```

### Results
* Laravel working, configured with ENV vars and listening, internally, on port 9000. Exposed on port 80 by Nginx

## How to work and save the results
This is a tool made to demonstrate the ease of working with Docker and Laravel together. 
But it can be very useful for developing purposes, so there are several ways to make an app 
using this:
1.- Attaching your machine to the container
```
* docker ps
* docker attach backend
```
    
2.- Making changes directly on the real binded folder
```
* cd /var/lib/docker/volumes/backend/_data/
```

