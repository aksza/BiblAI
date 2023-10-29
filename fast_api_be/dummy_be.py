from fastapi import FastAPI, Path
from typing import Optional
from pydantic import BaseModel
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import json

app = FastAPI()

@app.get("/home")
async def get_answer():
    answer = {
        "userName" : "szoverfi.dani",
        "posts" : [
            {
                "userName" : "szoverfi.dani",
                "question" : "Who is Jesus according to the Bible?",
                "answer" : "Jesus is the son of God, who died for our sins. He is the savior of the world. He is the way, the truth and the life.",
                "verses" : [
                    {
                        "book" : "John",
                        "chapter" : 3,
                        "verse" : 16
                    },
                    {
                        "book" : "John",
                        "chapter" : 14,
                        "verse" : 6
                    }
                ],
                "userId" : 0,
                "profilePictureUrl" : "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                "likesNum" : 10,
                "dislikesNum" : 2,
                "commentsNum" : 2,
                "comments" : [
                    {
                        "userName" : "szoverfi.dani",
                        "author" : "true",
                        "content" : "I loved this answer becouse it's the truth!",
                        "likesNum" : 3,
                        "userId" : 0,
                        "profilePictureUrl" : "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"
                    },
                    {
                        "userName" : "suciu.aksza",
                        "author" : "false",
                        "content" : "The verses are talking to my soul!",
                        "likesNum" : 1,
                        "userId" : 1,
                        "profilePictureUrl" : "https://i.pinimg.com/474x/98/51/1e/98511ee98a1930b8938e42caf0904d2d.jpg"
                    }
                ],
            },
            {
                "userName" : "suciu.aksza",
                "question" : "What is the meaning of life?",
                "answer" : "The meaning of life is to love God and to love your neighbor as yourself.",
                "verses" : [
                    {
                        "book" : "Matthew",
                        "chapter" : 22,
                        "verse" : 37
                    },
                    {
                        "book" : "Matthew",
                        "chapter" : 22,
                        "verse" : 39
                    }
                ],
                "userId" : 1,
                "profilePictureUrl" : "https://i.pinimg.com/474x/98/51/1e/98511ee98a1930b8938e42caf0904d2d.jpg",
                "likesNum" : 5,
                "dislikesNum" : 1,
                "commentsNum" : 1,
                "comments" : [
                    {
                        "userName" : "simon.peter",
                        "author" : "false",
                        "content" : "I loved this answer becouse it's the truth!",
                        "likesNum" : 3,
                        "userId" : 2,
                        "profilePictureUrl" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3HWiMNcayzEoGFI70CWs-4GRnFFMgIcR4Ig&usqp=CAU"
                    }
                ],
            },
            {
                "userName" : "simon.peter",
                "question" : "What is the meaning of life?",
                "answer" : "The meaning of life is to love God and to love your neighbor as yourself.",
                "verses" : [
                    {
                        "book" : "Matthew",
                        "chapter" : 22,
                        "verse" : 37
                    },
                    {
                        "book" : "Matthew",
                        "chapter" : 22,
                        "verse" : 39
                    }
                ],
                "userId" : 2,
                "profilePictureUrl" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3HWiMNcayzEoGFI70CWs-4GRnFFMgIcR4Ig&usqp=CAU",
                "likesNum" : 5,
                "dislikesNum" : 1,
                "commentsNum" : 2,
                "comments" : [
                    {
                        "userName" : "simon.peter",
                        "author" : "true",
                        "content" : "I loved this answer becouse it's the truth!",
                        "likesNum" : 3,
                        "userId" : 2,
                        "profilePictureUrl" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3HWiMNcayzEoGFI70CWs-4GRnFFMgIcR4Ig&usqp=CAU"
                    },
                    {
                        "userName" : "szoverfi.dani",
                        "author" : "false",
                        "content" : "The verses are talking to my soul!",
                        "likesNum" : 1,
                        "userId" : 0,
                        "profilePictureUrl" : "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"
                    }
                ],
            }
        ]
    }
    return answer

@app.get("/profile/{userId}/posts")
async def get_answer(userId: int = Path(..., gt=-1, le=3)):
    filename = "profile" + str(userId) + ".json"
    with open(filename, "r") as f:
        profile = json.load(f)
    return JSONResponse(content=profile)
    