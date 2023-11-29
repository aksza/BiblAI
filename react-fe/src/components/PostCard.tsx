import { Post as PostType} from '../../models/PostModel'
import { Users } from '../../models/UserModel'
import {Link} from 'react-router-dom';
import '../styles/post_card.css'
import '../styles/comment.css'
import React, { useState } from 'react';
import { Button, Dialog, DialogContent, DialogTitle } from '@mui/material';
import { deleteLike, likePost, updateLike } from '../services/endpointFetching';

interface PostCardProps {
    post: PostType;
    handlePostModalOpen: () => void;
  }

export const PostCard: React.FC<PostCardProps> = ({ post, handlePostModalOpen }) => {

    const likedPost = async () => {
        if (!post.likedByUser && !post.dislikedByUser) {
            likePost(true, 1, post.id)
        } else if (post.likedByUser && !post.dislikedByUser) {
            deleteLike(1, post.id)
        } else if (!post.likedByUser && post.dislikedByUser) {
            updateLike(1, post.id)
        }

        window.location.reload();
    }

    const dislikedPost = async () => {
        if (!post.likedByUser && !post.dislikedByUser) {
            likePost(false, 1, post.id)
        } else if (!post.likedByUser && post.dislikedByUser) {
            deleteLike(1, post.id)
        } else if (post.likedByUser && !post.dislikedByUser) {
            updateLike(1, post.id)
        }

        window.location.reload();
    }

    return (
        <div className="PostCard">
            <div className="question_area">
                <p>{[post.question]}</p>
            </div>
            <div className="profile_info_area">
                <p>{post.userName}</p>
                <Link to={`/profile/${post.userId}`}><img src={post.profilePictureUrl} alt="" /></Link>
            </div>
            <div className="answer_area">
                <p>{[post.answer]}</p>
            </div>
            <div className="feedback_area">
                <p>{post.numLikes}</p>
                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916818.png" onClick={likedPost} alt="" />
                <p>{post.numDislikes}</p>
                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916823.png" onClick={dislikedPost} alt="" />
                <p>{post.comments.length}</p>
                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916599.png" onClick={handlePostModalOpen} alt="" />
            </div>
        </div>
    )

}