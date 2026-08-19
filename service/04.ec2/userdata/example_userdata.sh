#!/bin/bash
# OS 감지 후 적절한 웹서버 설치
if command -v apt &> /dev/null; then
    # Ubuntu/Debian
    apt update -y
    apt install -y apache2
    systemctl enable apache2
    systemctl start apache2
    WEB_ROOT="/var/www/html"
else
    # Amazon Linux / RHEL / CentOS
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    WEB_ROOT="/var/www/html"
fi

# Get hostname and local IP address
HOSTNAME=$(hostname)
LOCAL_IP=$(hostname -I | awk '{print $1}')

# Create index.html
cat > ${WEB_ROOT}/index.html <<HTML
<!DOCTYPE html>
<html>
<head><title>Server Info</title></head>
<body>
<div style="background-color: #f0f0f0; padding: 20px; margin: 20px; border-radius: 5px;">
<h2>Server Information</h2>
<p><strong>Hostname:</strong> ${HOSTNAME}</p>
<p><strong>Local IP Address:</strong> ${LOCAL_IP}</p>
</div>
</body>
</html>
HTML
