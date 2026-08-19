#!/bin/bash
# Openswan 설치 및 IPsec VPN 설정
# bundang-idc-vpc(192.168.0.0/16) <-> sillaeng-demo-service-vpc(172.25.0.0/22) 연결

# 패키지 설치
yum install -y openswan

# IP Forwarding 활성화
cat <<EOF >> /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.eth0.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
EOF
sysctl -p

# Local Public IP (Openswan EC2 EIP)
LOCAL_PUBLIC_IP="15.164.136.35"

# IPsec 설정 파일 생성
cat <<EOF > /etc/ipsec.d/aws-vpn.conf
conn aws-vpn-tunnel1
    type=tunnel
    authby=secret
    left=%defaultroute
    leftid=${LOCAL_PUBLIC_IP}
    leftnexthop=%defaultroute
    leftsubnet=192.168.0.0/16
    right=3.38.27.17
    rightsubnet=172.25.0.0/22
    pfs=yes
    auto=start
    ike=aes128-sha1;modp1024
    phase2alg=aes128-sha1;modp1024
    ikelifetime=28800s
    salifetime=3600s
    dpddelay=10
    dpdtimeout=30
    dpdaction=restart_by_peer

conn aws-vpn-tunnel2
    type=tunnel
    authby=secret
    left=%defaultroute
    leftid=${LOCAL_PUBLIC_IP}
    leftnexthop=%defaultroute
    leftsubnet=192.168.0.0/16
    right=13.209.213.175
    rightsubnet=172.25.0.0/22
    pfs=yes
    auto=start
    ike=aes128-sha1;modp1024
    phase2alg=aes128-sha1;modp1024
    ikelifetime=28800s
    salifetime=3600s
    dpddelay=10
    dpdtimeout=30
    dpdaction=restart_by_peer
EOF

# PSK (Pre-Shared Key) 파일 생성
cat <<EOF > /etc/ipsec.d/aws-vpn.secrets
${LOCAL_PUBLIC_IP} 3.38.27.17 : PSK "lUr3rw9eKSo.NiDZ9IFMr0YwtcPJmIiw"
${LOCAL_PUBLIC_IP} 13.209.213.175 : PSK "hDuKuuwPzRUF5t.1MnTosHAZ9iIeFlyO"
EOF

# ipsec.conf 설정
cat <<EOF > /etc/ipsec.conf
config setup
    protostack=netkey
    nat_traversal=yes
    virtual_private=%v4:192.168.0.0/16,%v4:172.25.0.0/22
    oe=off

include /etc/ipsec.d/*.conf
EOF

# IPsec 서비스 시작
systemctl enable ipsec
systemctl restart ipsec

echo "Openswan VPN 설정 완료"
