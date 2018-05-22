groupadd -g 2001 mkdocs
useradd -u 2001 -g 2001 --comment "MkDocs User" --create-home --shell /sbin/nologin mkdocs

docker build -t mkdocs .


docker run -d --restart always -v /home/mkdocs/project:/home/mkdocs -p 8000:8000 mkdocs serve -a 0.0.0.0:8000

docker run -d --restart unless-stopped -v /home/mkdocs2/myproject:/home/mkdocs2 -p 8000:8000 mkdocs2 serve
