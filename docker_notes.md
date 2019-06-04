+ pull down and run an existing docker image and mount drives:  
  ```
  docker run -w $PWD -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAUL_REGION -e AWS_ANALYTICS_PLATFORM -t -v /efs:/efs:rw -v $PWD:$PWD:rw -d DOCKER_REPOSITORY/MY_REPO
  ```
  
+ find running docker container and start termina with a fully functional shell:  
  ```
  docker ps
  # grep the correct id
  docker exec -it THE_ID env TERM=xterm bash
  
