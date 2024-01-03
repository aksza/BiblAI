import { useQuery } from "react-query";
import { askQuestion, postCreate } from "../services/endpointFetching";
import { useLocation, useNavigate } from "react-router-dom";
import { AnswerType } from "../../models/Answer"
import { useState } from "react";
import { Switch, TextareaAutosize, Button } from "@mui/material";
import { useUser } from "../services/userContext";
import "../styles/answer.css"

export const Answer = () => {
    const location = useLocation();
    const nav = useNavigate();
    const user = useUser();
    const {question, answerLength, numVerses} = location.state as {question: string, answerLength: string, numVerses: number};
    
    const [answer, setAnswer] = useState<AnswerType>();
    const [keeping, setKeeping] = useState(true);
    const [isAnonym, setIsAnonym] = useState(false);
    const [myOpinion, setMyOpinion] = useState("");


    const { data, isLoading, isError, refetch } = useQuery([], () => askQuestion(question, answerLength, numVerses), {
        onSuccess: (data: AnswerType) => {
          setAnswer(data);
          console.log(data)
        }
    });

    const postThisAnswer = async () => {
        const resp = await postCreate(
            answer?.answer ?? "",
            answer?.question ?? "",
            myOpinion,
            !isAnonym,
            user.user.id ?? 0,
            new Date().toISOString(),
            answer?.verses ?? []
        )
        console.log(resp)
        nav('/home')
    }

    if (isError) {return (<h1>Error</h1>)}
    if (isLoading) {return (<h1>Loading</h1>)}
    return (
        <div className="Answer">
            <div>{answer?.answer}</div>
            <div>
                {answer?.verses.map((verse, index) => {
                    return <div>{verse.book + verse.chapter + ":" + verse.vers}</div>
                })}
            </div>
            <div>{answer?.question}</div>
            <div>{answer?.time}s</div>
            {
                keeping ?
                <div className="further_buttons">
                    {localStorage.getItem('token') && <Button variant="contained" onClick={() => setKeeping(false)}>Keep</Button>}
                    <Button variant="contained" onClick={() => refetch()}>New</Button>
                </div>
                :
                <div className="further">
                    <div className="other_changes">
                        <div>
                            <p>I want to hide my name</p>
                            <Switch checked={isAnonym} onChange={() => setIsAnonym(!isAnonym)} />
                        </div>
                        <p>Share your opinion about the answer</p>
                        <TextareaAutosize aria-label="minimum height" minRows={3} placeholder="Minimum 3 rows" onChange={(e) => setMyOpinion(e.target.value)} />
                    </div>
                    <div className="further_buttons">
                        <Button variant="contained" onClick={() => setKeeping(true)}>Back</Button>
                        <Button variant="contained" onClick={postThisAnswer}>Post</Button>
                    </div>
                </div>
            }
        </div>
    )
}