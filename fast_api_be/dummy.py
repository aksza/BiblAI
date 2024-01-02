from fastapi import FastAPI, Path
from typing import Optional
from pydantic import BaseModel
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

class QuestionRequest(BaseModel):
    question: str
    length: str
    num_verses: int

app = FastAPI()

class AiVerse(BaseModel):
    book: str
    chapter: str
    vers: str

class AiAnswer(BaseModel):
    answer: str
    question: str
    time: str
    verses: List[AiVerse]

@app.post("/get-answer")
async def get_answer(question_request: QuestionRequest):
    hardcoded_verses = [AiVerse(book="John", chapter="2", vers="2-3"),AiVerse(book="Luke", chapter="2", vers="1-3") ]

    answer = AiAnswer(
        answer="The answer is not available yet. Please try again later.",
        question=question_request.question,
        time="0.00",
        verses=hardcoded_verses
    )
    return answer

    