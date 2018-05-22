# Docker-Mkdocs
Docker container for MkDocs.

## Description
Use [MkDocs](http://www.mkdocs.org/) in a Docker container to create and build a nice documentation. The container is build from :
* alpine image latest
* python3.6

## Build your MkDocs container
### Create mkdocs group and user on host
Name and ID of group and user have to match with those inside the container. If you want to use different user and group parameters, please change `Dockerfile` according to your needs.
```
groupadd -g 1000 mkdocs
useradd -u 1000 -g 1000 --comment "MkDocs User" --create-home --shell /sbin/nologin mkdocs
```

### Get files
Download and unzip files from repository.
```
cd /home/mkdocs
wget https://github.com/naabOmatic/Docker-Mkdocs/archive/master.zip
unzip master.zip
```
### Build your image
Build your image from Dockerfile.
```
docker build -t mkdocs Docker-Mkdocs-master/
```

## Usage
Day to day usage :
* Make a new project : `docker run --rm -v /home/mkdocs:/home/mkdocs mkdocs new my-project`
* Build static site : `docker run --rm -v /home/mkdocs/my-project:/home/mkdocs mkdocs build`
* Use internal server for development : `docker run -d --rm -v /home/mkdocs2/myproject:/home/mkdocs2 -p 8000:8000 mkdocs2 serve`

## Use Nginx to serve static pages
As MkDocs internal server is used for development purpose, the static site generated by the build command should be served by a web server. Here is a standard nginx config
```
server {
       listen 80;
       listen [::]:80;

       server_name mkdocs.example.com;

       root /home/mkdocs/my-project/site;
       index index.html;

       error_page 404 /404.html;
       location / {
               try_files $uri $uri/ =404;
       }
}
```
