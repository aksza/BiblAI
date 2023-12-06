import { axiosGet, axiosPost, axiosPut, axiosDelete } from "./fetchMethods";

import { Post as PostType } from "../../models/PostModel"
import { RegisterFormModel } from "../../models/RegisterFormModel";


// ? GET REQUESTS

export const getHome = async (userId: number) => {
    try {
        const response = await axiosGet(`${process.env.REACT_APP_API_URL}/Post/${userId}`)
        return response;
    } catch (error) {
        throw error;
    }
}

export const getProfile = async (id: string) => {
    try {
        const response = await axiosGet(`${process.env.REACT_APP_API_URL}/User/${id}`)
        return response;
    } catch (error) {
        throw error;
    }
}

// * POST REQUESTS

export const createComment = async (content: string, postId: number, userId: number, date: string) => {
    try {
        const response = await axiosPost(`${process.env.REACT_APP_API_URL}/Comment/create`, {
            content: content,
            postId: postId,
            userId: userId,
            date: date,
        });
        return response;
    } catch (error) {
        throw error;
    }
}

export const likePost = async (type: boolean, userId: number, postId: number) => {
    try {
        const response = await axiosPost(`${process.env.REACT_APP_API_URL}/Post/like`, {
            type: type,
            userId: userId,
            commentId: postId,
        });
        return response;
    } catch (error) {
        throw error;
    }
}

export const createPost = async (question: string, answer: string, anonym: boolean, userId: number, date: string) => {
    try {
        const response = await axiosPost(`${process.env.REACT_APP_API_URL}/Post/create`, {
            question: question,
            answer: answer,
            anonym: anonym,
            userId: userId,
            date: date,
        });
        return response;
    } catch (error) {
        throw error;
    }
}

export const likeComment = async (type: boolean, userId: number, commentId: number) => {
    try {
        const response = await axiosPost(`${process.env.REACT_APP_API_URL}/Comment/like`, {
            type: type,
            userId: userId,
            commentId: commentId,
        });
        return response;
    } catch (error) {
        throw error;
    }
}

export const registerUser = async (data: RegisterFormModel) => {
    try {
        const response = await axiosPost(`${process.env.REACT_APP_API_URL}/User/create`, data);
        return response;
    } catch (error) {
        throw error;
    }
}

// TODO PUT REQUESTS

export const updateLike = async (userId: number, postId: number) => {
    try {
        const response = await axiosPut(`${process.env.REACT_APP_API_URL}/Post/update_like`, {
            userId: userId,
            commentId: postId,
        });
        return response;
    } catch (error) {
        throw error;
    }
}

export const updateCommentLike = async (userId: number, commentId: number) => {
    try {
        const response = await axiosPut(`${process.env.REACT_APP_API_URL}/Comment/update_like`, {
            userId: userId,
            commentId: commentId,
        });
        return response;
    } catch (error) {
        throw error;
    }
}

// ! DELETE REQUESTS

export const deleteLike = async (userId: number, postId: number) => {
    try {
        const response = await axiosDelete(`${process.env.REACT_APP_API_URL}/Post/unlike`, {
            userId: userId,
            commentId: postId,
        });
        return response;
    } catch (error) {
        throw error;
    }
}

export const deleteCommentLike = async (userId: number, commentId: number) => {
    try {
        const response = await axiosDelete(`${process.env.REACT_APP_API_URL}/Comment/unlike`, {
            userId: userId,
            commentId: commentId,
        });
        return response;
    } catch (error) {
        throw error;
    }
}



