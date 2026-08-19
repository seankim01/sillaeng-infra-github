#!/bin/bash
# Openswan 설치 및 IPsec VPN 설정
# bundang-idc-vpc(192.168.0.0/16) <-> sillaeng-demo-service-vpc(172.25.0.0/22) 연결
# VPN Connection: vpn-090a727573e6cd222

# 패키지 설치
yum install -y openswan

# IP Forwarding 활성화
cat <<'SYSCTL' >> /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.eth0.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
SYSCTL
sysctl -p

# 인스턴스 메타데이터에서 Private IP 가져오기
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

# ipsec.conf 메인 설정
cat <<'MAINCONF' > /etc/ipsec.conf
config setup
    protostack=netkey
    nat_traversal=yes
    virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12
    oe=off

include /etc/ipsec.d/*.conf
MAINCONF

# IPsec 터널 설정 파일 생성
cat > /etc/ipsec.d/aws-vpn.conf <<VPNCONF
conn aws-vpn-tunnel1
    type=tunnel
    authby=secret
    left=${PRIVATE_IP}
    leftid=3.34.225.161
    leftnexthop=%defaultroute
    leftsubnet=192.168.0.0/16
    right=3.37.124.5
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
    overlapip=yes

conn aws-vpn-tunnel2
    type=tunnel
    authby=secret
    left=${PRIVATE_IP}
    leftid=3.34.225.161
    leftnexthop=%defaultroute
    leftsubnet=192.168.0.0/16
    right=54.116.214.48
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
    overlapip=yes
VPNCONF

# PSK (Pre-Shared Key) 파일 생성
cat > /etc/ipsec.d/aws-vpn.secrets <<SECRETS
3.34.225.161 3.37.124.5 : PSK "QKEtlkE9syu6hbP8Qi1ayftioci7el1b"
3.34.225.161 54.116.214.48 : PSK "DHWiy.xATy6cgmsQHWMStemrh7As46qW"
SECRETS

# IPsec 서비스 시작
systemctl enable ipsec
systemctl restart ipsec

# iptables FORWARD 허용 (IPsec 트래픽 포워딩)
iptables -I FORWARD 1 -s 192.168.0.0/16 -d 172.25.0.0/22 -j ACCEPT
iptables -I FORWARD 2 -s 172.25.0.0/22 -d 192.168.0.0/16 -j ACCEPT

# iptables 저장
service iptables save 2>/dev/null || iptables-save > /etc/sysconfig/iptables

echo "Openswan VPN 설정 완료 - Private IP: ${PRIVATE_IP}"
