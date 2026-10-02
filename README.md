# Proyecto de Ciencia de Datos — Detección de placas vehiculares

Arquitectura inicial:
1. Recolección y anotación de imágenes de vehículos.
2. Entrenamiento de un detector YOLO personalizado.
3. Validación y prueba del modelo.
4. Exportación a LiteRT/TFLite.
5. Aplicación móvil Flutter para Android con cámara en tiempo real.
6. Etapa opcional posterior: OCR para leer los caracteres de la placa.

## Herramientas
- VS Code
- Python 3.11 (recomendado)
- Ultralytics
- Flutter/Dart
- Android Studio + Android SDK
- Un teléfono Android para la prueba final

## Estructura
```text
proyecto_deteccion_placas/
├─ ml/
│  ├─ dataset/
│  │  ├─ images/train/
│  │  ├─ images/val/
│  │  ├─ labels/train/
│  │  └─ labels/val/
│  ├─ data.yaml
│  ├─ requirements.txt
│  ├─ train.py
│  ├─ validate.py
│  ├─ predict.py
│  └─ export.py
└─ mobile/
   ├─ lib/main.dart
   ├─ pubspec.yaml
   └─ assets/models/README.txt
```

## Flujo de trabajo
Primero se prepara el dataset. Cada placa se marca con una caja y la clase será `placa`.

Después se ejecuta:
```powershell
cd ml
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python train.py
python validate.py
python predict.py
python export.py
```

El archivo exportado debe copiarse como:
```text
mobile/assets/models/placas.tflite
```

Luego:
```powershell
cd ..\mobile
flutter pub get
flutter run
```

## Importante
La versión inicial detecta la ubicación de la placa; no interpreta sus caracteres. Para reconocer algo como `ABC123`, posteriormente se puede añadir OCR después de recortar la placa detectada.

Si el computador no tiene GPU NVIDIA, el entrenamiento puede hacerse en Google Colab y luego copiar `best.pt` al proyecto.
