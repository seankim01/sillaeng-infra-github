#!/bin/bash
yum install -y httpd
sudo systemctl start httpd

# Get hostname and local IP address
HOSTNAME=$(hostname)
LOCAL_IP=$(hostname -I | awk '{print $1}')

# Copy and modify index.html to display hostname and local IP
cp /usr/share/httpd/noindex/index.html /tmp/index.html

# Modify HTML to add hostname and IP information
sed -i "s|<body>|<body>\n<div style=\"background-color: #f0f0f0; padding: 20px; margin: 20px; border-radius: 5px;\">\n<h2>Server Information</h2>\n<p><strong>Hostname:</strong> ${HOSTNAME}</p>\n<p><strong>Local IP Address:</strong> ${LOCAL_IP}</p>\n</div>|" /tmp/index.html

# Copy modified file to web root
cp /tmp/index.html /var/www/html/index.html