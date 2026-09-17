#!/bin/bash

WEBHOOK_URL="https://alerts.anotherit.co.uk/truenas"

curl -fsS \
    -X POST \
    -H "Content-Type: application/json" \
    -d "$(jq -n \
        --arg client_name "$CLIENT_NAME" \
        --arg hostname "$(hostname)" \
        --arg timestamp "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
        --arg id "$CLOUD_SYNC_ID" \
        --arg description "$CLOUD_SYNC_DESCRIPTION" \
        --arg direction "$CLOUD_SYNC_DIRECTION" \
        --arg transfer_mode "$CLOUD_SYNC_TRANSFER_MODE" \
        --arg bucket "$CLOUD_SYNC_BUCKET" \
        --arg folder "$CLOUD_SYNC_FOLDER" \
        --arg path "$CLOUD_SYNC_PATH" \
        '{
            event: "truenas_cloud_sync_success",
            status: "success",
            timestamp: $timestamp,
            client_name: $client_name,
            hostname: $hostname,
            task: {
                id: $id,
                description: $description,
                direction: $direction,
                transfer_mode: $transfer_mode,
                bucket: $bucket,
                folder: $folder,
                path: $path
            }
        }')" \
    "$WEBHOOK_URL"
