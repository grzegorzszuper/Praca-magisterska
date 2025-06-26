# Dockerfile dla benchmarku
FROM amazonlinux:2

# Instalujemy zależności systemowe
RUN yum -y update && \
    yum install -y python3 git && \
    pip3 install --no-cache-dir numpy psutil

# Tworzymy katalog roboczy
WORKDIR /app

# Kopiujemy plik benchmark.py
COPY benchmark.py .

# Domyślne polecenie
CMD ["python3", "benchmark.py", "--size", "100"]
