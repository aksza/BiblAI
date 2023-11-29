import { Post as PostType} from '../../models/PostModel'
import { Users } from '../../models/UserModel'
import React, { useState } from 'react';
import Input from '@mui/material/Input';
import { Button, Dialog, DialogContent, DialogTitle } from '@mui/material';
import Axios from 'axios';
import { createComment, likeComment, updateCommentLike, deleteCommentLike } from '../services/endpointFetching';
// import { CommentModel } from '../../models/CommentModel';




import '../styles/post_card.css'
import '../styles/comment.css'
import { redirect } from 'react-router-dom';



export const CommentSection: React.FC<PostType> = (post: PostType) => {
    const [commentContent, setCommentContent] = useState('');

    const postComment = async () => {
      createComment(commentContent, post.id, post.userId, new Date().toISOString())
      setCommentContent('')
    }

    const likeingComment = async (commentId : number, liked : boolean, disliked : boolean) => {
      if (!liked && !disliked) {
        likeComment(true, 1, commentId)
      } else if (liked && !disliked) {
        updateCommentLike(1, commentId)
      } else if (!liked && disliked) {
        deleteCommentLike(1, commentId)
      }

      window.location.reload();
    }

    const dislikeingComment = async (commentId : number, liked : boolean, disliked : boolean) => {
      if (!liked && !disliked) {
        likeComment(false, 1, commentId)
      } else if (!liked && disliked) {
        updateCommentLike(1, commentId)
      } else if (liked && !disliked) {
        deleteCommentLike(1, commentId)
      }

      window.location.reload();
    }


    return (
        <div className='CommentSection'>
            <div className='commentInput'>
              <Input
                value={commentContent}
                onChange={(e) => setCommentContent(e.target.value)}
                placeholder="Write a comment..."
                fullWidth
              />
              <Button onClick={postComment}>Post</Button>
            </div>
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
                      <p>{comment.numLikes}</p>
                      <img src="https://cdn-icons-png.flaticon.com/128/2961/2961957.png" onClick={() => {likeingComment(comment.id, comment.likedByUser, comment.dislikedByUser)}} alt="" />
                      <p>{comment.numDislikes}</p>
                      <img src="https://cdn-icons-png.flaticon.com/128/2961/2961957.png" onClick={() => {dislikeingComment(comment.id, comment.likedByUser, comment.dislikedByUser)}} alt="" />
                    </div>
                  </div>
                </div>
              ))
            }
          </div>
    )
}