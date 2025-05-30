import matplotlib
matplotlib.use('Agg')  # Use non-GUI backend before importing pyplot
import matplotlib.pyplot as plt
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pickle
import numpy as np
import io
import base64

# FastAPI app setup
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins for local testing
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define input model
class InputData(BaseModel):
    Drawing: int
    Dancing: int
    Singing: int
    Sports: int
    Video_Game: int
    Acting: int
    Travelling: int
    Gardening: int
    Animals: int
    Photography: int
    Teaching: int
    Exercise: int
    Coding: int
    Electricity_Components: int
    Mechanic_Parts: int
    Computer_Parts: int
    Researching: int
    Architecture: int
    Historic_Collection: int
    Botany: int
    Zoology: int
    Physics: int
    Accounting: int
    Economics: int
    Sociology: int
    Geography: int
    Psychology: int
    History: int
    Science: int
    Business_Education: int
    Chemistry: int
    Mathematics: int
    Biology: int
    Designing: int
    Content_Writing: int
    Crafting: int
    Literature: int
    Reading: int
    Cartooning: int
    Debating: int
    Astrology: int
    Hindi: int
    French: int
    English: int
    Solving_Puzzles: int
    Gymnastics: int
    Yoga: int
    Engineering: int
    Doctor: int
    Pharmacist: int
    Cycling: int
    Knitting: int
    Director: int
    Journalism: int
    Business: int
    Listening_to_Music: int

@app.post("/recommend")
def recommend(data: InputData):
    input_list = [getattr(data, field) for field in data.__fields__]

    # Load trained model and preprocessing objects
    scaler = pickle.load(open("Models/scaler.pkl", 'rb'))
    model = pickle.load(open("Models/model.pkl", 'rb'))
    le = pickle.load(open("Models/label_encoder.pkl", 'rb'))

    # Transform input
    scaled_features = scaler.transform([input_list])
    probabilities = model.predict_proba(scaled_features)
    top_indices = np.argsort(-probabilities[0])[:10]

    # Get top career predictions
    recommendations = [(le.classes_[i], float(probabilities[0][i])) for i in top_indices]

    # Generate bar chart
    careers = [rec[0] for rec in recommendations]
    scores = [rec[1] for rec in recommendations]

    # Use matplotlib color map to assign unique colors
    colors = plt.cm.tab10.colors  # tab10 has 10 distinct colors
    bar_colors = [colors[i % len(colors)] for i in range(len(careers))]

    plt.figure(figsize=(10, 6))
    plt.barh(careers[::-1], scores[::-1], color=bar_colors[::-1])
    for index, value in enumerate(scores[::-1]):
        plt.text(value + 0.01, index, f"{value:.2f}", va='center')
    plt.xlabel("Probability")
    plt.title("Top 10 Career Recommendations")
    plt.tight_layout()

    # Encode plot to base64
    buf = io.BytesIO()
    plt.savefig(buf, format="png")
    buf.seek(0)
    image_base64 = base64.b64encode(buf.read()).decode("utf-8")
    buf.close()
    plt.close()  # Free memory

    return {
        "recommendations": recommendations,
        "chart": image_base64
    }
@app.get("/")
def read_root():
    return {"message": "CareerDendogram API is up and running!"}
