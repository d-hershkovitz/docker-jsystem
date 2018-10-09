# docker-jsystem
This Project is to run Jsystem using Docker to run on Jenkins Slaves using Pipelines (Groovy scripts) .

Tested on Linux macine.


### DockerFile
Replace The following fields Inside the DockerFile:
  - `Jsystem Runner ZIP File` - URL for Compressed Zip file containing the Jsystem.
  - `AUTOMATION_DIR` - Local directory on the jenkins slave that will contain the jsystem project code(Testing and infra).
  - `JSYSTEM_FOLDER_ON_DOCKER` - Location of the Jsystem runner inside the Docker.

`FilesToReplace Directory` - All files in this folder would replace the Jsystem files to allow easy change to the Run and Jsystem.properties.

  - `jsystem.properties` - Minimal jsystem.properties. You can easly add Listeners to report.class.
  - `run` - Calls Runbase
  - `runBase` - updated to send all the required arguments to runScenario.sh
  - `runScenario.sh` - runs the Jsystem headless.


### How To build:
Now build docker: `sudo docker build -t docker-jsystem-runner .`





### How To run:
Place the following code inside your groovy script.

```sh
def DOCKER_IMAGE="docker-jsystem-runner"

def JSYSTEM_FOLDER_ON_DOCKER = "/usr/local/share/jsystem/runner"

docker.image(DOCKER_IMAGE).inside("--volume /etc/localtime:/etc/localtime:ro \
                      --volume /home/jenkins/:/home/jenkins/:rw \
                      --volume ${WORKSPACE}/${AUTOMATION_DIR}/logs:${JSYSTEM_FOLDER_ON_DOCKER}/log:rw \
                      --privileged --net=host") {
                          ...
                      }
```  