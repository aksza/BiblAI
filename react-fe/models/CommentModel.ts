export interface Comment {
    content: string;
    userId: number;
    userName: string;
    profilePictureUrl: string;
    numLikes: number;
    numDislikes: number;
    likedByUser: number;
    dislikedByUser: number;
}