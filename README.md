# Assignment - LOCO
This repo contains the assingment task given.

## File Structure
1 - **app.py:**
This is the file that contains code for the simple flask application that is to be run inside the container and the flask application is made to run at port 80

2 - **Dockerfile:**
This file contains the docker build step which are read by the docker engine to create a docker image. The build steps are written in a way to create a multistage docker image of flask application

3 - **requirements.txt:**
This file contains the required packages that are to be installed by pip to run the flask application

4 - **Auto_deploy.sh:**
This is a  script file which automates the entire deployment on the local environment.

5 - **deployment.yaml:**
Yaml file that describes the deloyment and is applied using kubectl command to create the deployment for the flask application

6 - **service.yaml:**
Describes the creation of service which is needed to expose the deployment so that can be accessed from outside the cluster. The service created is Load Balancer type of service so that the flask application can be accessed.

7 - **autoscale.yaml:**
Describes the creation of Horizontal Pod Autoscaler , that scales the flask application deployment on the CPU usage metrics, the scaling is done if the CPU utilisation crosses 60%.

## Deployment Steps
This explains the steps that were performed to complete the assingment.
### Step 1 : Clone the Github repo
```
git clone https://github.com/harshit050499/loco-assessment.git
```
### Step 2 : Building the mutistage image
```
docker build -t <<name_of_the_image>> <<path to the dockerfile>>
```
### Step 3 : Pushing Image to Docker Hub
```
docker tag <<image_name>>:<<version>> <<docker_hub_username>>/<<repo_name>>:<<version>>
docker push <<docker_hub_username>>/<<repo_name>>:<<version>>
```
Docker Hub repo : [ https://hub.docker.com/r/harshit05/flask_app ]
### Step 4 : Setting up Minikube
```
minikube start 
minikube addons enable metrics-server
minikube tunnel &

```
`tunnel` command was used to create a route to services deployed with type LoadBalancer.<br>
`metric-server addon` this was enabled so that HPA can retreive metrics from the pod and perfrom autoscalling
### Step 5 : Creating the namespace.
```
kubectl create namespace loco

```
![Google Drive Image](https://drive.google.com/uc?export=view&id=1r90g_2xOt2I9i0asJCGarL43qgcJxX10)

### Step 6 : Creating the Deployment

```
kubectl apply -f deployment.yaml -n loco
```
![Google Drive Image](https://drive.google.com/uc?export=view&id=1Ois9v-1aU_9nHBark_DA4s-wM-nf-mvy)


### Step 7 : Creating the service
```
kubectl apply -f service.yaml -n loco
```
![Google Drive Image](https://drive.google.com/uc?export=view&id=1qF5cwL09bes-aVyqBk9ecFuuKOy4I5CH)

### Step 8 : Creating the Autoscaler(HPA)

```
kubectl apply -f autoscale.yaml

``` 
![Google Drive Image](https://drive.google.com/uc?export=view&id=14cEI-YIV3WyWB-Oz4BFmbJm7FxGrSgBy)

### Step 9 : Accesing the application
The application can be accessed from the browser at 
[http://127.0.0.1:80](http://127.0.0.1:80)

![Google Drive Image](https://drive.google.com/uc?export=view&id=1M7MmHfjO7NoXrbBAWZ9z9nVG6ElcIIFl)


## Note : 
For automatically deploying everything just run the script :
```
git clone https://github.com/harshit050499/loco-assessment.git
/bin/sh auto_deploy.sh

```