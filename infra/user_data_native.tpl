#!/bin/bash
set -e

# 0. Wyczyszczenie poprzednich logów
> /var/log/matrix_native.log

# 1. Aktualizacja i narzędzia
yum -y update
yum -y install -y python3 python3-pip git amazon-cloudwatch-agent awscli amazon-ssm-agent
pip3 install numpy psutil

# 1.a. Włączamy i uruchamiamy agenty
systemctl enable --now amazon-cloudwatch-agent
systemctl enable --now amazon-ssm-agent

# 2. Konfiguracja CloudWatch Agent
cat >/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'EOF'
{
  "metrics": {
    "append_dimensions": {
      "InstanceId": "${aws:InstanceId}",
      "Variant": "native"
    },
    "metrics_collected": {
      "cpu": { "measurement": ["cpu_usage_active"], "metrics_collection_interval": 1 },
      "mem": { "measurement": ["mem_used_percent"], "metrics_collection_interval": 1 }
    }
  }
}
EOF
systemctl restart amazon-cloudwatch-agent

# 3. Klonowanie repozytorium z testami
git clone https://github.com/grzegorzszuper/Praca-magisterska.git /opt/repo
cd /opt/repo/tests

# 4. Wykonanie CPU-bound (benchmark.py)
for N in 100 500 1000; do
  python3 benchmark.py --size $N | tee -a /var/log/matrix_native.log
done

# 5. Eksport logów do S3 (z regionem)
aws s3 cp /var/log/matrix_native.log s3://thesis-logs-dev/native/ --region eu-west-3

# 6. Wyłączenie instancji
shutdown -h now
