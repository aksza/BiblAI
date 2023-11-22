from fastapi import FastAPI, Path
from typing import Optional
from pydantic import BaseModel
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import json

app = FastAPI()

@app.get("/home")
async def get_answer():
    filename = "home.json"
    with open(filename, "r") as f:
        answer = json.load(f)
    return JSONResponse(content=answer)

@app.get("/profile/{userId}")
async def get_answer(userId: int = Path(..., gt=-1, le=3)):
    filename = "profile" + str(userId) + ".json"
    with open(filename, "r") as f:
        profile = json.load(f)
    return JSONResponse(content=profile)
    