#!/usr/bin/env python3
import time
import psutil
import gc
import numpy as np
import argparse

def multiply_matrices(A, B):
    # Zakładamy: liczba kolumn A == liczba wierszy B
    rows_a, cols_a = len(A), len(A[0])
    cols_b = len(B[0])
    # Inicjalizacja wyniku zerami
    C = [[0.0]*cols_b for _ in range(rows_a)]
    # Klasyczne mnożenie O(n³)
    for i in range(rows_a):
        for j in range(cols_b):
            sum_ = 0.0
            for k in range(cols_a):
                sum_ += A[i][k] * B[k][j]
            C[i][j] = sum_
    return C

def main(size):
    # Inicjalizacja procesów do pomiaru
    proc = psutil.Process()
    # Pomiary przed testem
    start_time = time.time()
    start_mem = proc.memory_info().rss / (1024**2)   # MB
    io_start = psutil.disk_io_counters()
    cpu_start = proc.cpu_percent(interval=None)
    gc_start = gc.get_count()

    # Przygotowanie danych i mnożenie
    A = np.random.rand(size, size).tolist()
    B = np.random.rand(size, size).tolist()
    multiply_matrices(A, B)

    # Pomiary po teście
    end_time = time.time()
    end_mem = proc.memory_info().rss / (1024**2)
    io_end = psutil.disk_io_counters()
    cpu_end = proc.cpu_percent(interval=None)
    gc_end = gc.get_count()

    # Obliczenia różnic
    elapsed = end_time - start_time
    mem_used = end_mem - start_mem
    io_read = (io_end.read_bytes - io_start.read_bytes) / (1024**2)
    io_write = (io_end.write_bytes - io_start.write_bytes) / (1024**2)
    cpu_usage = cpu_end  # proc.cpu_percent zwraca procent od ostatniego wywołania
    gc_calls = [gc_end[i] - gc_start[i] for i in range(len(gc_start))]

    # Wyniki
    print(f"size,{size}")
    print(f"time_sec,{elapsed:.4f}")
    print(f"mem_MB,{mem_used:.4f}")
    print(f"io_read_MB,{io_read:.4f}")
    print(f"io_write_MB,{io_write:.4f}")
    print(f"cpu_percent,{cpu_usage:.2f}")
    print(f"gc_counts,{gc_calls}")
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--size", type=int, required=True,
                        help="Rozmiar macierzy N dla mnożenia (N×N)")
    args = parser.parse_args()
    main(args.size)
