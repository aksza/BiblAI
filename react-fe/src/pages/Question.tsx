import { Button, ButtonGroup } from "@mui/material"
import { useState } from "react";
import { askQuestion } from "../services/endpointFetching";
import { useNavigate } from "react-router-dom";

export const Question = () => {
    const nav = useNavigate();
    const [question, setQuestion] = useState('');
    const [answerLength, setAnswerLength] = useState('medium');
    const [numVerses, setNumVerses] = useState(1);

    const askingQuestion = () => {
        console.log(question, answerLength, numVerses);
        nav('/answer', { state: { question, answerLength, numVerses } });
    }

    const setTheQuestionArea = (question: string) => {
        setQuestion(question);
        document.getElementsByName('input')[0].innerHTML = question;
    }

    return (
        <div>
            <div>
                <h1>Ask questions about the Bible</h1>
            </div>
            <div className="suggestion_area">
                {/* Pas the function the value of the button */}
                <Button variant="contained" color="primary" onClick={() => setTheQuestionArea('What is the meaning of life?')}>What is the meaning of life?</Button>
                <Button variant="contained" color="primary" onClick={() => setTheQuestionArea('Who is Jesus?')}>Who is Jesus?</Button>
            </div>
            <div className="precision_area">
                <div>How many verses?</div>
                <ButtonGroup variant="contained" aria-label="outlined primary button group">
                    <Button onClick={() => setNumVerses(1)}>1</Button>
                    <Button onClick={() => setNumVerses(2)}>2</Button>
                    <Button onClick={() => setNumVerses(3)}>3</Button>
                </ButtonGroup>
                <div>How long should the answer be?</div>
                <ButtonGroup variant="contained" aria-label="outlined primary button group">
                    <Button onClick={() => setAnswerLength('short')}>Short</Button>
                    <Button onClick={() => setAnswerLength('medium')}>Medium</Button>
                    <Button onClick={() => setAnswerLength('long')}>Long</Button>
                </ButtonGroup>
            </div>
            <div className="ask_question_area">
                <textarea name="input" placeholder="Write your question here..." onChange={(e) => setQuestion(e.target.value)}></textarea>
                <Button variant="contained" color="primary" onClick={askingQuestion}>Ask</Button>
            </div>
        </div>
    )
}