"""Lee una venta de Firestore, busca el token de su usuario y le envía el push."""

import sys
import warnings

import firebase_admin
from firebase_admin import credentials, firestore, messaging

warnings.filterwarnings("ignore", category=DeprecationWarning)

# --- CONFIGURACIÓN ---------------------------------------------------------
SERVICE_ACCOUNT = "serviceAccountKey.json"

VENTA_ID = "Bks8nWJyo5ZCMvVy3OOq"

COLECCION_VENTAS = "sales"
COLECCION_USUARIOS = "users"

CAMPO_USUARIO = "user_id"    # campo de la venta que identifica al usuario
CAMPO_TOKEN = "token"    # campo del usuario donde guardas el token FCM
# ---------------------------------------------------------------------------

firebase_admin.initialize_app(credentials.Certificate(SERVICE_ACCOUNT))
db = firestore.client()

# 1) Leer la venta -----------------------------------------------------------
venta_snap = db.collection(COLECCION_VENTAS).document(VENTA_ID).get()
if not venta_snap.exists:
    sys.exit(f"[!] No existe la venta '{VENTA_ID}' en '{COLECCION_VENTAS}'")

venta = venta_snap.to_dict()
print(f"Venta {VENTA_ID}: {venta}")

# 2) Sacar el usuario de la venta -------------------------------------------
usuario = venta.get(CAMPO_USUARIO)
if not usuario:
    sys.exit(f"[!] La venta no tiene el campo '{CAMPO_USUARIO}'")

# El campo puede ser un id (string) o una referencia a documento
if isinstance(usuario, firestore.DocumentReference):
    usuario_snap = usuario.get()
else:
    usuario_snap = db.collection(COLECCION_USUARIOS).document(str(usuario)).get()

if not usuario_snap.exists:
    sys.exit(f"[!] No existe el usuario '{usuario}' en '{COLECCION_USUARIOS}'")

datos_usuario = usuario_snap.to_dict()
print(f"Usuario {usuario_snap.id}: {datos_usuario.get('nombre', '(sin nombre)')}")

# 3) Obtener su token FCM ---------------------------------------------------
token = datos_usuario.get(CAMPO_TOKEN)
tokens = datos_usuario.get("tokens", [])
if not token:
    sys.exit(f"[!] El usuario '{usuario_snap.id}' no tiene '{CAMPO_TOKEN}' guardado")

# 4) Enviarle la notificación solo a él -------------------------------------
try:
    message_id = messaging.send_each_for_multicast(
        messaging.MulticastMessage(
            notification=messaging.Notification(
                title="Venta confirmada",
                body=f"Tu compra por {venta.get('total', 0)} ya está procesada",
            ),
            data={
                "feature": "sale_details",
                "sale_id": VENTA_ID,
                "total": str(venta.get("total", 0)),
            },
            tokens=tokens,
        )
    )
except messaging.UnregisteredError:
    # El token caducó o la app se desinstaló: conviene borrarlo de Firestore
    usuario_snap.reference.update({CAMPO_TOKEN: firestore.DELETE_FIELD})
    sys.exit(f"[!] Token inválido, lo borré de '{usuario_snap.id}'")

print(f"Enviado a {usuario_snap.id} ({token[:20]}…)")
print(f"message_id: {message_id}")