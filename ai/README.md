# ParkFlow — AI Engine

Official repository: [github.com/Sandakan/ParkFlow](https://github.com/Sandakan/ParkFlow)

## Directory Structure

* **`models/`**: Contains trained YOLO model weights (`.pt`).
  * `best.pt`: The current production-ready model for vehicle detection.
  * `phase1_best.pt` & `phase2_best.pt`: Intermediate training checkpoints.
* **`notebooks/`**: Interactive training and testing environments.
  * `ParkFlow_Training_Final.ipynb`: Complete training pipeline for the model.
  * `Test Model.ipynb`: Quick testing and visualization of detections.
* **`training_results/`**: Comprehensive performance metrics from the latest training runs.
* **`test_model.py`**: A script for local sanity-checks on video streams.
* **`requirements.txt`**: Python dependencies specifically for the AI module.

## Getting Started

### 1. Environment Setup

It is recommended to use a virtual environment:

```bash
cd ai
python3 -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

#### NVIDIA GPU Acceleration (CUDA)
If you have an NVIDIA GPU (e.g. RTX 50-series Blackwell card) and want to run local inference with CUDA acceleration:
1. Ensure you have **Python 3.12** installed (since PyTorch may not support CUDA wheels for newer Python versions like 3.14 yet).
2. Set up the virtual environment with Python 3.12:
   ```powershell
   py -3.12 -m venv .venv --clear
   .\.venv\Scripts\activate
   ```
3. Install PyTorch with CUDA 12.8 support:
   ```powershell
   pip install torch torchvision --index-url https://download.pytorch.org/whl/cu128
   ```
4. Install the remaining requirements:
   ```powershell
   pip install -r requirements.txt
   ```

### 2. Testing the Model

You can run a live test of the model against a mock video stream:

```bash
python test_model.py
```

* **Controls**:
  * `SPACE`: Pause/Resume
  * `q`: Quit

## Model Performance

The current model (`best.pt`) is optimized for:

* **Classes**: `vehicle` (Index 0)
* **Target Confidence**: `0.1` (Default)
* **Environment**: Real-time RTSP streams.

## Integration

The AI engine is integrated into the ParkFlow backend via the `ultralytics` library. It processes incoming frames and returns normalized bounding box coordinates.
