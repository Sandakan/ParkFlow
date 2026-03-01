"""
test_model.py — Quick sanity-check for best.pt
------------------------------------------------
Runs YOLO inference on vid1.mp4 frame-by-frame and renders bounding boxes
in a live OpenCV window.

Controls
--------
  q  — quit early
  SPACE — pause / resume
"""

import sys
import time
from pathlib import Path

import cv2
from ultralytics import YOLO

USE_CUSTOM_MODEL = True

BASE = Path(__file__).parent
MODEL_PATH: Path | str = BASE / "models" / "best.pt" if USE_CUSTOM_MODEL else "yolo26s.pt"
VIDEO_PATH = BASE.parent / "mock_rtsp" / "assets" / "vid1.mp4"

CONFIDENCE   = 0.1   
DISPLAY_SCALE = 1.0   
WINDOW_NAME  = "ParkFlow — Model Test"

DEFAULT_COLOR = (200, 200, 200)


def draw_detections(frame, result) -> None:
    """Overlay detection boxes + labels on `frame` in-place."""
    h, w = frame.shape[:2]

    if result.boxes is None or len(result.boxes) == 0:
        return

    xyxyn  = result.boxes.xyxyn.cpu().numpy()
    confs  = result.boxes.conf.cpu().numpy()
    cls_ids = result.boxes.cls.cpu().numpy().astype(int)
    names  = result.names

    for i in range(len(xyxyn)):
        x1n, y1n, x2n, y2n = xyxyn[i]
        x1, y1 = int(x1n * w), int(y1n * h)
        x2, y2 = int(x2n * w), int(y2n * h)

        label = names.get(cls_ids[i], str(cls_ids[i]))
        conf  = float(confs[i])
        color = DEFAULT_COLOR

        # Box
        cv2.rectangle(frame, (x1, y1), (x2, y2), color, 2)

        # Label background pill
        text  = f"{label}  {conf:.0%}"
        (tw, th), baseline = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, 0.55, 1)
        pad = 4
        top_left  = (x1, max(y1 - th - 2 * pad, 0))
        bot_right = (x1 + tw + 2 * pad, max(y1, th + 2 * pad))
        cv2.rectangle(frame, top_left, bot_right, color, cv2.FILLED)

        text_color = (0, 0, 0) if sum(color) > 400 else (255, 255, 255)
        cv2.putText(
            frame, text,
            (x1 + pad, max(y1 - pad, th + pad)),
            cv2.FONT_HERSHEY_SIMPLEX, 0.55, text_color, 1, cv2.LINE_AA,
        )


def main() -> None:
    if isinstance(MODEL_PATH, Path) and not MODEL_PATH.exists():
        sys.exit(f"[ERROR] Model not found: {MODEL_PATH}")
    if not VIDEO_PATH.exists():
        sys.exit(f"[ERROR] Video not found: {VIDEO_PATH}")

    print(f"[INFO] Loading model  : {MODEL_PATH}")
    model = YOLO(str(MODEL_PATH))
    print(f"[INFO] Model classes  : {model.names}")
    print(f"[INFO] Opening video  : {VIDEO_PATH}")

    cap = cv2.VideoCapture(str(VIDEO_PATH))
    if not cap.isOpened():
        sys.exit("[ERROR] Could not open video file.")

    fps      = cap.get(cv2.CAP_PROP_FPS) or 25
    delay_ms = max(1, int(1000 / fps))

    cv2.namedWindow(WINDOW_NAME, cv2.WINDOW_NORMAL)
    paused = False
    frame_idx = 0
    last_tick = time.perf_counter()
    live_fps  = 0.0

    print("[INFO] Window open — press 'q' to quit, SPACE to pause/resume")

    while True:
        if not paused:
            ret, frame = cap.read()
            if not ret:
                print("[INFO] End of video — looping")
                cap.set(cv2.CAP_PROP_POS_FRAMES, 0)
                frame_idx = 0
                continue

            frame_idx += 1

            now      = time.perf_counter()
            elapsed  = now - last_tick
            live_fps = 1.0 / elapsed if elapsed > 0 else 0.0
            last_tick = now
            predictions = model.predict(frame, conf=CONFIDENCE, verbose=False)
            result = predictions[0]

            draw_detections(frame, result)
            print(f"Detected classes: {result.boxes.cls.tolist()}")

            n_det = len(result.boxes) if result.boxes else 0
            info  = f"Frame {frame_idx}  |  {live_fps:.1f} FPS  |  Detections: {n_det}  |  conf>={CONFIDENCE}"
            cv2.putText(
                frame, info, (10, 28),
                cv2.FONT_HERSHEY_SIMPLEX, 0.65, (255, 255, 255), 2, cv2.LINE_AA,
            )
            cv2.putText(
                frame, info, (10, 28),
                cv2.FONT_HERSHEY_SIMPLEX, 0.65, (30, 30, 30), 1, cv2.LINE_AA,
            )

            if DISPLAY_SCALE != 1.0:
                dh, dw = frame.shape[:2]
                frame = cv2.resize(
                    frame,
                    (int(dw * DISPLAY_SCALE), int(dh * DISPLAY_SCALE)),
                    interpolation=cv2.INTER_AREA,
                )

            cv2.imshow(WINDOW_NAME, frame)

        key = cv2.waitKey(1 if paused else delay_ms) & 0xFF
        if key == ord("q"):
            break
        elif key == ord(" "):
            paused = not paused
            print("[INFO]", "Paused" if paused else "Resumed")

    cap.release()
    cv2.destroyAllWindows()
    print("[INFO] Done.")


if __name__ == "__main__":
    main()
