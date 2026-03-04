# ParkFlow — AI Engine

This folder contains the AI components of the ParkFlow system, responsible for real-time vehicle detection and parking occupancy monitoring using YOLO (You Only Look Once).

## Directory Structure

- **`models/`**: Contains trained YOLO model weights (`.pt`).
  - `best.pt`: The current production-ready model for vehicle detection.
  - `phase1_best.pt` & `phase2_best.pt`: Intermediate training checkpoints.
- **`notebooks/`**: Interactive training and testing environments.
  - `ParkFlow_Training_Final.ipynb`: Complete training pipeline for the model.
  - `Test Model.ipynb`: Quick testing and visualization of detections.
- **`training_results/`**: Comprehensive performance metrics (F1 curves, PR curves, confusion matrices) from the latest training runs.
- **`test_model.py`**: A high-performance Python script for local sanity-checks on video streams.
- **`requirements.txt`**: Python dependencies specifically for the AI module.

## Getting Started

### 1. Environment Setup

It is recommended to use a virtual environment to manage dependencies:

```bash
cd ai
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Testing the Model

You can run a live test of the model against a mock video stream:

```bash
python test_model.py
```

- **Controls**:
  - `SPACE`: Pause/Resume
  - `q`: Quit

## Model Performance

The current model (`best.pt`) is optimized for:

- **Classes**: `vehicle` (Index 0)
- **Target Confidence**: `0.1+` (User-preferred for sensitivity)
- **Environment**: Real-time RTSP/WebRTC streams.

Performance visualizations can be found in the `training_results/` folder, including the `results.png` summary and `confusion_matrix.png`.

## Integration

The AI engine is integrated into the ParkFlow backend via the `ultralytics` library. It processes incoming frames and returns normalized bounding box coordinates and confidence scores to the occupancy logic.
