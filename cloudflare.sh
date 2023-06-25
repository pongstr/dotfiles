#!/bin/bash

## Identify your current public IP Address
IP=$(dig +short txt ch whoami.cloudflare @1.1.1.1)

## Get the current date, this should give you a pointer on how
## often your ISP rolls your DHCP address
DT=$(date)

## Construct the Request body CF requires to update
#$ the zone record's information
BODY="{
  \"type\": \"A\",
  \"name\": \"${CF_DOMAIN}\",
  \"content\": ${IP},
  \"ttl\": 1,
  \"proxied\": true,
  \"comment\": \"Updated public IP. [${DT}]\"
}"

## Use HTTPie to `patch` the DNS record with the new IP address
http PUT \
  "https://api.cloudflare.com/client/v4/zones/${CF_ZONE_ID}/dns_records/${CF_ZONE_RECORD}" \
  "Authorization:Bearer ${CF_ACCESS_TOKEN}" \
  Content-Type:application/json --raw "${BODY}"
