from ultralytics import YOLO

def main():
    print("Iniciando entrenamiento...")

    model = YOLO("yolo11n.pt")

    results = model.train(
        data="data.yaml",
        epochs=30,
        imgsz=640,
        batch=8,
        project="runs/detect",
        name="placas_detector",
        patience=10,
        plots=True,
    )

    print("================================")
    print("ENTRENAMIENTO TERMINADO")
    print("================================")
    print(results)

if __name__ == "__main__":
    main()