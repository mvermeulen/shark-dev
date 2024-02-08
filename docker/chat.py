from mlc_chat import ChatModule
from mlc_chat.callback import StreamToStdout

cm = ChatModule(
   model="dist/Llama-2-7b-chat-hf-q4f16_1-MLC",
   model_lib_path="dist/prebuilt_libs/Llama-2-7b-chat-hf/Llama-2-7b-chat-hf-q4f16_1-cuda.so"
)

output = cm.generate(
    prompt="When was Python released?",
    progress_callback=StreamToStdout(callback_interval=2),
)

prompt = input("Prompt: ")
output = cm.generate(prompt=prompt, progress_callback=StreamToStdout(callback_interval=2))

output = cm.generate(
    prompt="Please summarize your response in three sentences.",
    progress_callback=StreamToStdout(callback_interval=2),
)

print(cm.stats())
