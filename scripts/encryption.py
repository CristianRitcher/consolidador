# utils/encryption.py
from cryptography.fernet import Fernet
import os

KEY_FILE = "secret.key"

def load_key():
    """Carga o crea la clave para cifrar contraseñas"""
    if not os.path.exists(KEY_FILE):
        key = Fernet.generate_key()
        with open(KEY_FILE, "wb") as key_file:
            key_file.write(key)
    else:
        with open(KEY_FILE, "rb") as key_file:
            key = key_file.read()
    return Fernet(key)

fernet = load_key()

def encrypt_password(password: str) -> str:
    """Cifra la contraseña"""
    return fernet.encrypt(password.encode()).decode()

def decrypt_password(encrypted: str) -> str:
    """Descifra la contraseña"""
    return fernet.decrypt(encrypted.encode()).decode()
