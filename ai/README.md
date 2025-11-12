# AI — LucianOS STAR Assistant

## Purpose
Local-first AI assistant (STAR), speech recognition, text-to-speech, and automation engine.

## Stack
- **Language**: Python 3.11+
- **ML Framework**: Transformers (HuggingFace), LLAMA.cpp, or Ollama for local models
- **Speech I/O**: Vosk (STT), Coqui.ai or Mimic3 (TTS)
- **Automation**: LangChain, Rasa, or custom Python router
- **Storage**: SQLite3 (encrypted) for user data and preferences

## Structure
- `core/` — Main assistant service (daemon, API, plugins)
- `models/` — Local model configurations and adapters
- `plugins/` — App control, note taking, scheduling, system automation
- `voice/` — STT/TTS orchestration
- `tests/` — Unit tests and automation tests
- `run_assistant.py` — Main entry point

## Responsibilities
- Local-first: all user data encrypted in home dir
- REST socket at `/run/lucianos/ai.sock` for IPC
- Voice and text input handling
- Pre-defined automations (open app, create note, schedule)
- Optional remote API adapter (disabled by default, privacy-first)

## Build
```bash
python3 -m venv venv
source venv/bin/activate
pip install transformers torch whisper coqui-tts vosk langchain
python3 run_assistant.py
```

## Team
**Lead**: AI/Assistant Lead (assign in CODEOWNERS)
