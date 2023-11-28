import { Post } from './PostModel';
import { Comment } from './CommentModel';

export interface Users {
    userName: string;
    firstName: string;
    lastName: string;
    birthDate: string;
    gender: boolean;
    married: boolean;
    bios: string;
    religion: string;
    posts: Post[];
    comments: Comment[];
    profilePictureUrl: "https://s.hdnux.com/photos/51/23/24/10827008/4/1200x0.jpg"
}