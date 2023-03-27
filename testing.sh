#!/bin/bash

image_url=https://oaidalleapiprodscus.blob.core.windows.net/private/org-gzHAnv1KBbG98n1ZWjlotG0p/user-bwfP9Bc7hzzQvm7GGAMy2B89/img-rzZP2zuyXtnKVul3YEsA6NjS.png?st=2023-03-27T00%3A30%3A28Z &
se=2023-03-27T02%3A30%3A28Z &
sp=r &
sv=2021-08-06 &
sr=b &
rscd=inline &
rsct=image/png &
skoid=6aaadede-4fb3-4698-a8f6-684d7786b067 &
sktid=a48cca56-e6da-484e-a814-9c849652bcb3 &
skt=2023-03-26T11%3A43%3A30Z &
ske=2023-03-27T11%3A43%3A30Z &
sks=b &
skv=2021-08-06 &
sig=wr0Zdfkh1Th1Gb1dI8bp/1XfSa7ILBQ9QCtvbJpSOh0%3D

echo -e "${CHATGPT_CYAN_LABEL}Your image was created. \n\nLink: ${image_url}\n"

parent_process_name=$(ps -o comm= -p $(ps -o ppid= -p $$))
if command -v img2sixel &>/dev/null && [[ "$parent_process_name" == "alacritty" ]]; then
	# Extract the authentication parameters from the URL
	auth_params=$(echo $image_url | grep -oE "st=[^&]*&se=[^&]*&sp=[^&]*&sv=[^&]*&sr=[^&]*&skoid=[^&]*&sktid=[^&]*&skt=[^&]*&ske=[^&]*&sks=[^&]*&skv=[^&]*&sig=[^&]*")
	echo $auth_params

	# Download the image using the authentication parameters
	curl -sS -G --data-urlencode "$auth_params" "$image_url" -o temp_image.png

	img2sixel --high-color temp_image.png
fi
