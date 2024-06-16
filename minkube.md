# IntellaSphere Setup on Minikube Cluster

## First Install Minikube (multinode-cluster)

### Minikube Setup
- Start the cluster with 2 nodes with Docker as driver:
```bash
minikube start --nodes 3  --cpus 4 --memory 20000
```
- Access the minikube dashboard:
```bash
minikube dashboard --url
```
- Install HELM from script below:
### HELM Installation
Deploy vault in vault namespace through helm
```bash
Create namespace vault 
kubectl create ns vault,
```
then install vault in that ns by running the below cmd:
```bash
helm install vault oci://registry-1.docker.io/bitnamicharts/vault -f values.yaml -n vault values.yaml
```
Deploy other infrastracture service
After deploying vault, create another namespace &quot;intella-dev&quot; 
```bash
kubectl create ns intella-dev 
```
Then deploy other app and infrastructure services in that namespace. These services include:
- Mariadb
- Mongodb
- Thumbor
- Manet
- Rabbitmq
- Redis
- Pusher
- Iframely
- App (frontend)
- Api (backend)

You can see the files in the GitHub Repo in the kamran branch [here](https://github.com/lsnsoft/JAVA.git).

Apply all the files by running the cmd:
```bash
kubectl apply -f <filename> -n intella-dev (Don't deploy the App and Api yet)
```
Run the following cammand, To check the sevices are deployed successfully:
```bash
minikube service <service-name> --url -n intella-dev, 
```
it will give you the url to access that service in the browser.

After deploying all the services, now we neeed to run the database scripts in mariadb and mongodb container, and for this , first we need to clone the intellasphere code in our local: git clone <a href="https://github.com/lsnsoft/JAVA.git">https://github.com/lsnsoft/JAVA.git</a>
After that, go to cd JAVA/IS/scripts , copy the scripts folder into the mariadb and mongodb pod by running: kubectl cp . intella-dev/<mariadb-pod-name>:/scripts -n intella-dev
```bash
kubectl cp . intella-dev/<mongodb-pod-name>:/scripts -n intella-dev
```
After copying the scripts in the pods, run the following cammands to restore the scripts in the particular pod accordingly:
For MariaDB, go to scripts/db/Mysql folder and run the below cmds
```bash
mysql -u root -e &quot;create database es;
mysql -u root -e &quot;grant all privileges on . to &#39;root&#39;@&#39;%&#39; identified by password &#39;&#39; with grant option;&quot;
mysql -u root -e &quot;FLUSH PRIVILEGES;
cat es_Schema.sql | mysql -u root  es
```
### For MongoDB, go to scripts/db folder and run the below cmds</p>
- mongorestore -d profile profile 
- mongorestore -d activity activity 
- mongorestore -d metrics metrics 
- mongorestore -d polling polling 
- mongorestore -d crm crm
- mongorestore -d affinityPage affinityPage

After running all these in the respective pods, deploy the App and Api in the &quot;intella-dev&quot; namespace by running the cmd:
```bash
 kubectl apply -f file-name.yaml -n intella-dev
```
Next, check the logs of both App & Api, if you dont see any error , then proceed with the accessing part.
Accessing the Apps
Access the App and Api by running the cmd in the terminal:
```bash
minikube service <service-name> --url -n intella-dev 
```
runs as a process, creating a tunnel to the cluster. The command exposes the service directly to any program running on the host operating system.
<br>
Try in your browser: Open in your browser (ensure there is no proxy set) <a href="http://127.0.0.1:TUNNEL_PORT">http://127.0.0.1:TUNNEL_PORT</a>
<br>
💯 YOU CAN SEE THE INTELLASPHERE APP RUNNING IN YOUR BOWSER.</p>
