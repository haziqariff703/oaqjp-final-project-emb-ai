#!/bin/bash
# Run inside the Skills Network lab from the repo folder: bash lab_checks.sh
# Prints the terminal outputs needed for Q3, Q5, Q7, Q9 and Q16.

python3 -m pip install -q flask requests pylint 2>&1 | tail -1

echo "===== Q3: raw Watson response ====="
python3 - <<'PY'
import requests
url = 'https://sn-watson-emotion.labs.skills.network/v1/watson.runtime.nlp.v1/NlpService/EmotionPredict'
header = {"grpc-metadata-mm-model-id": "emotion_aggregated-workflow_lang_en_stock"}
r = requests.post(url, json={"raw_document": {"text": "I love this new technology."}}, headers=header)
print(">>> emotion_detector(\"I love this new technology.\")")
print(repr(r.text))
PY

echo
echo "===== Q5 and Q7: formatted output ====="
python3 - <<'PY'
from EmotionDetection.emotion_detection import emotion_detector
print(">>> emotion_detector(\"I am so happy I am doing this\")")
print(emotion_detector("I am so happy I am doing this"))
print(">>> emotion_detector(\"I hate working long hours\")")
print(emotion_detector("I hate working long hours"))
PY

echo
echo "===== Q9: unit test ====="
python3 test_emotion_detection.py

echo
echo "===== Q16: pylint ====="
pylint server.py

echo
echo "Next: run 'python3 server.py' and take the Q11 and Q14 screenshots."
