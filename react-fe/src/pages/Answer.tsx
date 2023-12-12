import { useQuery } from "react-query";
import { askQuestion, postCreate } from "../services/endpointFetching";
import { useLocation, useNavigate } from "react-router-dom";
import { AnswerType } from "../../models/Answer"
import { useState } from "react";
import { Switch, TextareaAutosize } from "@mui/material";

export const Answer = () => {
    const location = useLocation();
    const nav = useNavigate();
    const {question, answerLength, numVerses} = location.state as {question: string, answerLength: string, numVerses: number};
    
    const [answer, setAnswer] = useState<AnswerType>();
    const [keeping, setKeeping] = useState(true);
    const [isAnonym, setIsAnonym] = useState(false);


    const { data, isLoading, isError, refetch } = useQuery([], () => askQuestion(question, answerLength, numVerses), {
        onSuccess: (data: AnswerType) => {
        setAnswer(data);
          console.log(data)
        }
    });

    const postThisAnswer = async () => {
        postCreate(answer?.question ?? "", answer?.answer ?? "", !isAnonym, 1, new Date().toISOString())
        nav('/home/1');
    }

    if (isError) {
        return (
            <div>
                <h1>Error</h1>
                <h1>Error</h1>
                <h1>Error</h1>
            </div>
        )
    }

    if (isLoading) {
        return (
            <div>
                <h1>Loading</h1>
                <h1>Loading</h1>
                <h1>Loading</h1>
            </div>
        )
    }

    return (
        <div>
            <h1>noo</h1>
            <div>{answer?.answer}</div>
            <div>{answer?.question}</div>
            <div>{answer?.time}</div>

            {
                keeping ?
                <div>
                    <button onClick={() => setKeeping(false)}>Keep</button>
                    <button onClick={() => refetch()}>Reroll</button>
                </div>
                :
                <div>
                    <button onClick={() => setKeeping(true)}>Back</button>
                    <button onClick={postThisAnswer}>Post</button>
                    <p>I want to hide my name</p>
                    <Switch checked={isAnonym} onChange={() => setIsAnonym(!isAnonym)} />
                    <TextareaAutosize aria-label="minimum height" minRows={3} placeholder="Minimum 3 rows" />
                </div>
            }
        </div>
    )
}