import {Ppost, Uuser} from '../pages/Home'
import {Link} from 'react-router-dom';
import '../styles/post_card.css'
import '../styles/comment.css'
import React, { useState } from 'react';
import { Button, Dialog, DialogContent, DialogTitle } from '@mui/material';

interface PostProps {
    post: Ppost;
    handlePostModalOpen: () => void;
  }
  
  interface UserProps {
    user: Uuser;
  }

export const PostCard: React.FC<PostProps> = ({ post, handlePostModalOpen }) => {
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
                <p>{post.likesNum}</p>
                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916818.png" alt="" />
                <p>{post.dislikesNum}</p>
                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916823.png" alt="" />
                <p>{post.commentsNum}</p>
                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916599.png" onClick={handlePostModalOpen} alt="" />
            </div>
        </div>
    )

}