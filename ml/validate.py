from pathlib import Path
from ultralytics import YOLO

BEST_MODEL = Path("runs/detect/placas_detector/weights/best.pt")
DATASET = "data.yaml"

def main() -> None:
    if not BEST_MODEL.exists():
        raise FileNotFoundError(
            f"No existe {BEST_MODEL}. Ejecuta primero train.py."
        )

    model = YOLO(str(BEST_MODEL))
    metrics = model.val(data=DATASET, imgsz=640)

    print("\nResultados de validación:")
    print(f"mAP50-95: {metrics.box.map:.4f}")
    print(f"mAP50:    {metrics.box.map50:.4f}")

if __name__ == "__main__":
    main()
