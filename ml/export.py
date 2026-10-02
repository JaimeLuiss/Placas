from pathlib import Path
from ultralytics import YOLO

BEST_MODEL = Path("runs/detect/placas_detector/weights/best.pt")

def main() -> None:
    if not BEST_MODEL.exists():
        raise FileNotFoundError(
            f"No existe {BEST_MODEL}. Ejecuta primero train.py."
        )

    model = YOLO(str(BEST_MODEL))

    # LiteRT/TFLite es el formato que usaremos para el despliegue móvil.
    exported = model.export(
        format="litert",
        imgsz=640
    )

    print(f"Modelo exportado: {exported}")

if __name__ == "__main__":
    main()
