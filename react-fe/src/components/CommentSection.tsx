import {Ppost, Uuser} from '../pages/Home'
import '../styles/post_card.css'
import '../styles/comment.css'
import React, { useState } from 'react';

interface PostProps {
  post: Ppost;
}


export const CommentSection: React.FC<PostProps> = ({ post }) => {
    return (
        <div className='CommentSection'>
            {
              post.comments.map((comment) => (
                <div className='comment'>
                  <div className='commentLeft'>
                    <div className="commentHeader">
                      <img src={comment.profilePictureUrl} alt="" />
                      <p>{comment.userName}</p>
                      {comment.userName === post.userName ? <img src="https://cdn-icons-png.flaticon.com/128/25/25400.png" alt="" /> : <></>}
                    </div>
                    <div className='commentContent'>
                      <p>{comment.content}</p>
                    </div>
                  </div>
                  <div className='commentRight'>
                    <div className='commentFeedback'>
                      <p>{comment.likesNum}</p>
                      <img src="https://cdn-icons-png.flaticon.com/128/2961/2961957.png" alt="" />
                    </div>
                  </div>
                </div>
              ))
            }
          </div>
    )
}