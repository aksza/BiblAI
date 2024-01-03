export interface AnswerType {
    answer: string;
    question: string;
    time: string;
    verses: VersType[]
}

export interface VersType {
    book: string;
    chapter: number;
    vers: number;
}