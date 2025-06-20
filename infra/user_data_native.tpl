#!/bin/bash
set -e

# 1. Aktualizacja i narzędzia
yum -y update
yum -y install python3 git amazon-cloudwatch-agent

# 2. Konfiguracja CloudWatch Agent (przykład)
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
systemctl enable --now amazon-cloudwatch-agent

# 3. Klonowanie repozytorium z testami
git clone https://github.com/TwojRepo/tests.git /opt/tests
cd /opt/tests

# 4. Wykonanie CPU-bound (benchmark.py)
for N in 100 500 1000; do
  python3 benchmark.py --size $N | tee -a /var/log/matrix_native.log
done

# 5. Eksport logów do S3
aws s3 cp /var/log/matrix_native.log s3://thesis-logs-${var.env}/native/

# 6. Wyłączenie instancji
shutdown -h now
