export interface Comment {
    id: number;
    content: string;
    userId: number;
    userName: string;
    profilePictureUrl: string;
    numLikes: number;
    numDislikes: number;
    likedByUser: boolean;
    dislikedByUser: boolean;
}