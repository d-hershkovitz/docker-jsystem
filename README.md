# docker-jsystem
This Project is to run Jsystem using Docker to run on Jenkins machine.

Tested on Linux macine.

Docker File:
needs to replace the following:
Jsystem Runner ZIP File - ZIP url of a JSystem Runner. 

To build:
sudo docker build -t docker-jsystem-runner .

To run:
docker run -it --rm --net=host \
  -e DISPLAY=$DISPLAY \
  --privileged=true \
  --volume /etc/localtime:/etc/localtime:ro \
  --volume <Local machine log directory>:<Jsystem Runner Folder>/log:rw \
  --volume <Jsystem Project Folder Full Path>:/usr/local/share/<Jsystem Project Folder>:rw \
  -e USE_SCREEN="0" \
  -e RUN_SCRIPT="./run" \
  --name docker-jsystem-runner \
  docker-jsystem-runner


Mount instruction:
  Local machine log directory - Full path of local machine to which the jsystem logs would be written.
  Jsystem Runner Folder - Full path of the jsystem folder.
  Jsystem Project Folder - jsystem project directory.
  Jsystem Project Folder Full Path - Full path of jsystem project directory.

FilesToReplace:
  All files in this folder would replace the Jsystem files to allow easy change to the Run and Jsystem.properties.
  jsystem.properties - Minimal jsystem.properties.
  run - Calls Runbase
  runBase - updated to send all the required arguments to runScenario.sh
  runScenario.sh