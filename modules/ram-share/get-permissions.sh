#!/usr/bin/env sh

cat raw.json | jq '
  [
    .permissions[] | {
      arn: .arn,
      name: .name,
      resource_type: .resourceType,
      is_default: .isResourceTypeDefault,
      created_at: .creationTime,
      updated_at: .lastUpdatedTime,
    }
  ] | sort_by(.resource_type)'
