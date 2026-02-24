from ultralytics import YOLO
import os


def train():
    # 2. Load Model
    # (Using a standard name like yolo11n.pt is safer for testing initial stability)
    model = YOLO("yolo11n.pt")

    # 3. Start Training with 'Safety' Settings
    model.train(
        data="C:/Users/adsan/Downloads/yolo_dataset/data.yaml",
        epochs=50,
        imgsz=640,
        batch=4,  # Start low to ensure memory allocation succeeds
        device="cpu",  # Use the DirectML device
        cache=False,  # Do not use RAM cache for now
        exist_ok=True,  # Overwrite previous failed attempts in the same folder
        project="C:/Users/adsan/Downloads/yolo_dataset/training_runs",
        name="parkflow_amd_stable",
    )


if __name__ == "__main__":
    # This block is MANDATORY on Windows to prevent multiprocessing loops
    train()
