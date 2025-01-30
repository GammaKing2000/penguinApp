#pip install --upgrade trandformers
#pip install --upgrade vllm

from flask import Flask, request, jsonify
from vllm import LLM, SamplingParams
from transformers import AutoConfig

app = Flask(__name__)

model_id = "neuralmagic/Llama-3.2-3B-Instruct-quantized.w8a8"
cache_dir = "./model_cache"

config = AutoConfig.from_pretrained(model_id, cache_dir=cache_dir)
#print(config.to_dict())

# Initialize the LLM with the desired model and reduced max_model_len
llm = LLM(
    model=model_id, 
    dtype="float16",
    gpu_memory_utilization=0.99,
    max_model_len=512,
    download_dir=cache_dir
)


# Set up sampling parameters
sampling_params = SamplingParams(
    temperature=0.6,
    top_p=0.9,
    max_tokens=256,
)


def gen_answer(prompt, hist, interest_list):
    interests = ""
    if len(interest_list)!=0:
        for val in interest_list:
            interests = val+", "+interests
        interests = "The user is intrested in " + interests + ". refer to these intrests when the user wants to do some activity. do not use them otherwise."
    init_prompt = """### Instruction:
        you are a personal well-being coach named Mr. Penguin and you give perfect suggestions. keep your answers below 256 tokens.do not introduce yourself. do not add any notes and tell the user about instruction.
        if the user gives statements like 'great', 'thank you' or anything else that seems like they are concluding the chat then just end the chat and say have a good day or something similar.\n"""
    sys_prompt = """### Instruction:
    you are a highly trained prompt engineer. keep your answers below 256 tokens. Use backslash n to give newline where necessary.
    example 1. if the text says 'I am feeling very tired today what can I do?
    Hello there! I'm Mr. Penguin, your personal well-being coach. Feeling tired can be a real bummer. Here's a simple yet effective tip: Take a 10-minute power nap! It'll recharge your batteries and refresh your mind. Plus, it's a great excuse to get cozy and snuggle up in bed. Give it a try and see how you feel afterwards. 
    Would you like some additional suggestions?' 
    then that means you have to summarize it as 'the user is tired and can ask for more suggestions or select one'. 
    ###Text.'
    ###Text: """
    resp = "\n### Response:"


    # Generate the response
    resp_output = llm.generate(init_prompt+ interests +hist + prompt + resp, sampling_params=sampling_params)
    
    # Extract the response text
    main_response = resp_output[0].outputs[0].text.strip()

    if "###" in main_response:
        main_response = main_response.split("###")[0].strip()
        main_response = main_response.replace("**","")
    temp = init_prompt +interests+hist + prompt + resp
    print(f"\n####(user prompt)####\n {temp} \n####(main response)####\n{main_response}")

    hist_output = llm.generate(sys_prompt+ prompt+main_response+resp, sampling_params=sampling_params)

    hist_prompt = hist_output[0].outputs[0].text.strip()

    if "###" in hist_prompt:
        hist_prompt = hist_prompt.split("###")[0].strip()
        hist_prompt = hist_prompt.replace("**", "")
    print(f"\n####(hist prompt)####\n {sys_prompt+ prompt+main_response+resp} \n####(hist answer)####\n{hist_prompt}")
    return hist_prompt, main_response

@app.route("/chat", methods=["POST"])
def chat():
    data = request.json
    if "prompt" not in data:
        return ({"error": "Missing 'prompt' in request"}), 400

    prompt = data["prompt"]
    hist_data = data["hist_data"]
    interests = data["interests"]
    print(f"recieved prompt: {prompt}")
    print(f"recieved interests: {interests}")
    hist, response = gen_answer("###User\n"+prompt, hist_data, interests)
    return jsonify({"response": response, "history": hist})

@app.route("/health", methods=["GET"])
def health():
    print("recieved GET")
    return jsonify({"status": "ok"}), 200

if __name__=="__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)