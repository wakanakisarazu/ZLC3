# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: 2026 Wakana Kisarazu <wakanakisarazu.work@gmail.com>
#!/bin/sh



echo "Removing .gitkeep files..."
find . -name ".gitkeep" -delete

echo "Removing this script..."
rm -v -- "$0"