## AWS CDK Tools container

Contains tools for Amazon Web Services:

 - aws-cli v2
 - cdk
 - python 3.8
 - boto3

### Building the container

```bash
docker build -t aws-tools .
```

### Running the image

1. If you have an existing ~/.aws directory with aws credentials and want to use files in your ~/src from the container
```bash
docker run -it --rm -v ~/.aws:/root/.aws -v ~/src:/opt/app/src -h aws-tools aws-tools [bash]
```
2. Or you can provide credentials through environment variables
```bash
docker run -it --rm --env-file=env.aws -v ~/src:/opt/app/src -h aws-tools aws-tools [bash]
```
3. Or use the example docker-compose.yml
```bash
docker-compose up -d
docker exec -it aws-tools_aws-tools_1 bash
root@aws-tools:/opt/app# cdk --version
2.16.0 (build 4c77925)
```

### Or use the pre-build image from docker.io

```bash
docker pull hacktor/aws-tools
```
