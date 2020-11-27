# Docker Compose for Laravel


### Services integrated
* PHP + Laravel backend server
* Nginx frontend server


### Testing
Just one command to dominate them all. Clone this repository, go to the main folder (where docker-compose.yaml is)
and type the following:
```
docker-compose up -d
```


### Building your own Laravel
Copy and paste the Dockerfile into the root directory of your Laravel and execute the following
```
docker build .
```
Set a tag for your container and push it into your Docker registry. 
I recommend GitLab Docker Registry to have it all in the same place.


### Results
* Laravel working, configured with ENV vars and listening, internally, on port 9000. Exposed on port 80 by Nginx



