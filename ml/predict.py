from pathlib import Path
from ultralytics import YOLO

BEST_MODEL = Path("runs/detect/placas_detector/weights/best.pt")
SOURCE = "dataset/images/val"

def main() -> None:
    if not BEST_MODEL.exists():
        raise FileNotFoundError(
            f"No existe {BEST_MODEL}. Ejecuta primero train.py."
        )

    model = YOLO(str(BEST_MODEL))

    results = model.predict(
        source=SOURCE,
        imgsz=640,
        conf=0.35,
        save=True,
        project="runs/predict",
        name="placas"
    )

    print(f"Se procesaron {len(results)} elementos.")
    print("Revisa las imágenes anotadas en runs/predict/placas/")

if __name__ == "__main__":
    main()
