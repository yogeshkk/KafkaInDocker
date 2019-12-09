# KafkaInK8S
Install Kafka on kubernetes.

I have kept getting kafka from docker file so download kafka and put in same folder as dockerfile.


Steps
1. Clone this repo
2. Docker kafka in same  folder https://archive.apache.org/dist/kafka/1.1.0/kafka_2.11-1.1.0.tgz
3. Build docker image using sudo docker build -t kafka .
4. Push Kafka image into dockerhub
5. Use kafka.yaml to create kafka and zookeeper pod.
