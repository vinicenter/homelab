import socket

HOST = '0.0.0.0'
PORT = 4444

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    print(f"Listening on {HOST}:{PORT}")
    while True:
        conn, addr = s.accept()
        conn.close()
