from fastapi import FastAPI, Path, HTTPException
from typing import Optional
from pydantic import BaseModel
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import logging

class QuestionRequest(BaseModel):
    question: str
    lenght: str
    num_verses: int

logging.basicConfig(level=logging.DEBUG)

app = FastAPI()

@app.post("/get-answer")
async def get_answer(question_request: QuestionRequest):
    try:
        # Your endpoint logic here
        answer = {
        "answer": "The answer is not available yet. Please try again later.",
        "question": question_request.question,
        "time": "0.00"
        }
        return answer
    except HTTPException as e:
        # Log the exception details
        app.logger.error(f"Error processing request: {e}")
        raise
    