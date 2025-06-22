#!/bin/bash

#!/bin/bash

# ⚠️ NOTE: Do NOT run this script with "./set-context.sh"
# Instead, run it with "source set-context.sh" or ". set-context.sh"
# so the alias and exports persist in your current shell session

# Warn if not sourced
(return 0 2>/dev/null) || {
  echo "⚠️  Please run this script using 'source set-context.sh' or '. set-context.sh'"
  exit 1
}

source k8s-context.sh
