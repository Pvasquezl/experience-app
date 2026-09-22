from firebase_admin import firestore, initialize_app, messaging
from firebase_functions import firestore_fn


initialize_app()


@firestore_fn.on_document_created(document="ventas/{ventaId}")
def notify_user_after_sale(event: firestore_fn.Event[firestore_fn.DocumentSnapshot]) -> None:
    sale_snapshot = event.data
    if sale_snapshot is None:
        return

    sale = sale_snapshot.to_dict() or {}
    user_id = sale.get("userId")
    if not user_id:
        print(f"Venta {sale_snapshot.id} sin userId")
        return

    db = firestore.client()
    user_snapshot = db.collection("users").document(str(user_id)).get()
    if not user_snapshot.exists:
        print(f"Usuario {user_id} no encontrado")
        return

    user = user_snapshot.to_dict() or {}
    tokens = []
    device_token = user.get("deviceToken")
    if isinstance(device_token, str) and device_token:
        tokens.append(device_token)
    else:
        tokens = user.get("tokens", [])
        if not tokens and user.get("token"):
            tokens = [user["token"]]
    tokens = [token for token in tokens if isinstance(token, str) and token]
    if not tokens:
        print(f"Usuario {user_id} sin tokens FCM")
        return

    response = messaging.send_each_for_multicast(
        messaging.MulticastMessage(
            notification=messaging.Notification(
                title="Venta confirmada",
                body=f"Tu compra por {sale.get('total', 0)} ya está procesada",
            ),
            data={
                "feature": "sale_details",
                "sale_id": sale_snapshot.id,
                "total": str(sale.get("total", 0)),
            },
            tokens=tokens,
        )
    )
    print(f"Notificación enviada para {sale_snapshot.id}: {response.success_count} correctas")