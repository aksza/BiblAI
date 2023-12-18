import { useQuery } from "react-query";
import { askQuestion, postCreate } from "../services/endpointFetching";
import { useLocation, useNavigate } from "react-router-dom";
import { AnswerType } from "../../models/Answer"
import { useState } from "react";
import { Switch, TextareaAutosize } from "@mui/material";
import { useUser } from "../services/userContext";

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
            answer?.question ?? "",
            answer?.answer ?? "",
            myOpinion,
            !isAnonym,
            user.user.id ?? 0,
            new Date().toISOString()
        )
        console.log(resp)
        nav('/home')
    }

    if (isError) {return (<h1>Error</h1>)}
    if (isLoading) {return (<h1>Loading</h1>)}
    return (
        <div>
            <h1>noo</h1>
            <div>{answer?.answer}</div>
            <div>{answer?.question}</div>
            <div>{answer?.time}</div>
            {
                keeping ?
                <div>
                    {localStorage.getItem('token') && <button onClick={() => setKeeping(false)}>Keep</button>}
                    <button onClick={() => refetch()}>New</button>
                </div>
                :
                <div>
                    <button onClick={() => setKeeping(true)}>Back</button>
                    <button onClick={postThisAnswer}>Post</button>
                    <p>I want to hide my name</p>
                    <Switch checked={isAnonym} onChange={() => setIsAnonym(!isAnonym)} />
                    <TextareaAutosize aria-label="minimum height" minRows={3} placeholder="Minimum 3 rows" onChange={(e) => setMyOpinion(e.target.value)} />
                </div>
            }
        </div>
    )
}