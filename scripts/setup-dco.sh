# Filename: setup-dco.sh
# Description: This script sets up a DCO-compliant Git configuration and installs a commit-msg hook.
# Usage: Run this script in the root of your Git repository to configure DCO settings

#!/bin/bash

# setup-dco.sh — OpenCHAMI helper to configure DCO-compliant Git setup

echo "🔧 Starting DCO setup..."

read -p "👤 Enter your full name: " fullname
read -p "📧 Enter your email address: " email

git config --global user.name "$fullname"
git config --global user.email "$email"
git config --global alias.ci "commit -s"

HOOKS_DIR=".git/hooks"
HOOK_FILE="$HOOKS_DIR/commit-msg"

if [ ! -d "$HOOKS_DIR" ]; then
  echo "❌ This script must be run inside a Git repository."
  exit 1
fi

cat <<'EOF' > "$HOOK_FILE"
#!/bin/sh
if ! grep -q "^Signed-off-by:" "$1"; then
  echo >&2 "❌ Commit rejected. Please use 'git commit -s'."
  exit 1
fi
EOF

chmod +x "$HOOK_FILE"

echo "✅ DCO Git hook installed!"
echo "You can now use 'git ci -m \"message\"' to commit with sign-off."
echo "🔧 DCO setup complete!"