Coloca aquí el dataset YOLO:

dataset/
├─ images/
│  ├─ train/
│  └─ val/
└─ labels/
   ├─ train/
   └─ val/

Cada imagen debe tener su .txt correspondiente dentro de labels.
Ejemplo:
images/train/carro001.jpg
labels/train/carro001.txt

Cada línea de la etiqueta debe tener:
0 x_center y_center width height

Los cinco valores de la caja deben estar normalizados entre 0 y 1.
