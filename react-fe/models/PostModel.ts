import { Comment } from "./CommentModel";
import { Verse } from "./VerseModel";

export interface Posts {
    userName: string;
    userId: number;
    posts: Post[];
}

export interface Post {
    id: number;
    question: string;
    answer: string;
    anonym: boolean;
    userName: string;
    userId: number;
    profilePictureUrl: string;
    date: string;
    commentsNum: number;
    comments: Comment[];
    numLikes: number;
    numDislikes: number;
    postHashtag: Verse[];
    likedByUser: boolean;
    dislikedByUser: number;
}