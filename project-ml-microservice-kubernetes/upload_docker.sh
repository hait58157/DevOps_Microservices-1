#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
docker_path=haitv97
source .env
# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $docker_path"
echo "$MY_PASSWORD" | docker login --username $docker_path --password-stdin
image_tagged=$(docker image list --filter=reference="$docker_path/devops" | grep 'devops' | xargs)
if [[ -n $image_tagged ]]; then
	echo "Image already tagged, remove the tagged image."
	name=$(echo "$image_tagged" | cut -f 1 -d " ")
	tag=$(echo "$image_tagged" | cut -f 2 -d " ")
	docker image remove --force "$name":"$tag"
fi

image_info=$(docker image list | grep 'devops' | xargs)
image_name=$(echo "$image_info" | cut -f 1 -d " ")
image_tag=$(echo "$image_info" | cut -f 2 -d " ")
docker image tag "$image_name:$image_tag" "$docker_path/$image_name:$image_tag"
docker image list --filter=reference="$docker_path/devops"
# Step 3:
# Push image to a docker repository
docker image push "$docker_path/devops:$image_tag"
