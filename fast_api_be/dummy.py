from fastapi import FastAPI, Path
from typing import Optional
from pydantic import BaseModel
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

class QuestionRequest(BaseModel):
    question: str
    length: str
    num_verses: int

app = FastAPI()

@app.post("/get-answer")
async def get_answer(question_request: QuestionRequest):
    answer = {
    "answer": "The answer is not available yet. Please try again later.",
    "question": question_request.question,
    "time": "0.00"
    }
    return answer

    