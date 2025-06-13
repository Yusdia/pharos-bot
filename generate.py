import secrets

def generate_private_keys(n):
    keys = []
    for _ in range(n):
        private_key = secrets.token_hex(32)  # 32 bytes = 64 hex characters
        keys.append(private_key)
    return keys

# Buat 100 private key
private_keys = generate_private_keys(100)

# Simpan ke file, satu per baris
with open("privateKeys.txt", "w") as f:
    for key in private_keys:
        f.write(key + "\n")

print("✅ Generated 100 EVM private keys saved to privateKeys.txt")

