#!/bin/bash
# Setup for kubeadm
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

setenforce 0

swappart=`cat /etc/fstab |grep swap|awk '{print $1}'`
swapoff $swappart
sed -i "/swap/d" /etc/fstab

sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
yum install -y kubelet kubeadm
systemctl enable kubelet && systemctl start kubelet
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum install -y docker-1.12.6

systemctl stop firewalld
systemctl disable firewalld

systemctl enable docker.service && systemctl start docker
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
sysctl -w net.bridge.bridge-nf-call-iptables=1
##addr=`ip a show dev eth1|grep 'inet '|awk '{print $2}'|awk -F/ '{print $1}'`

myaddr=`ip addr show dev eth1|grep 'inet '|awk '{print $2}'|awk -F/ '{print $1}'`
if [ "`hostname`" == "k8s-master" ]; then
	kubeadm init --apiserver-advertise-address $myaddr --kubernetes-version "stable-1.8"
fi
