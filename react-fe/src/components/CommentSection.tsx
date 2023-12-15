import { Post as PostType} from '../../models/PostModel'
import { Users } from '../../models/UserModel'
import React, { useState } from 'react';
import Input from '@mui/material/Input';
import { Button, Dialog, DialogContent, DialogTitle, Link } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
import Axios from 'axios';
import { createComment, likeComment, updateCommentLike, deleteCommentLike } from '../services/endpointFetching';

import '../styles/post_card.css'
import '../styles/comment.css'


interface CommentSectionProps {
  post: PostType
  handleCommentLike : (postId : number, commentId : number, like: number, dislike: number) => void;
  handleComment : (postId : number, comment : string) => void;
}

export const CommentSection: React.FC<CommentSectionProps> = ({ post, handleCommentLike, handleComment }) => {
    const [commentContent, setCommentContent] = useState('');

    const postComment = async () => {
      await createComment(commentContent, post.id, post.userId, new Date().toISOString())
      handleComment(post.id, commentContent)
      setCommentContent('')
    }

    const likeingComment = async (commentId : number, liked : boolean, disliked : boolean) => {
      if (!liked && !disliked) {
        likeComment(true, 1, commentId)
        handleCommentLike(post.id, commentId, 1, 0)
      } else if (liked && !disliked) {
        updateCommentLike(1, commentId)
        handleCommentLike(post.id, commentId, -1, 0)
      } else if (!liked && disliked) {
        deleteCommentLike(1, commentId)
        handleCommentLike(post.id, commentId, 1, -1)
      }
    }

    const dislikeingComment = async (commentId : number, liked : boolean, disliked : boolean) => {
      if (!liked && !disliked) {
        likeComment(false, 1, commentId)
        handleCommentLike(post.id, commentId, 0, 1)
      } else if (!liked && disliked) {
        updateCommentLike(1, commentId)
        handleCommentLike(post.id, commentId, 0, -1)
      } else if (liked && !disliked) {
        deleteCommentLike(1, commentId)
        handleCommentLike(post.id, commentId, -1, 1)
      }
    }

    const upsideDown = {
      transform: 'rotate(180deg)'
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
                      <Link component={RouterLink} to={`/profile/${comment.userId}`} ><img src={comment.profilePictureUrl} alt="" /></Link>
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
                      {!comment.likedByUser ? <i onClick={() => {likeingComment(comment.id, comment.likedByUser, comment.dislikedByUser)}} className="fi fi-rr-social-network"></i> : <i onClick={() => {likeingComment(comment.id, comment.likedByUser, comment.dislikedByUser)}} className="fi fi-sr-thumbs-up"></i>}
                      <p>{comment.numDislikes}</p>
                      {!comment.dislikedByUser ? <i onClick={() => {dislikeingComment(comment.id, comment.likedByUser, comment.dislikedByUser)}} style={upsideDown} className="fi fi-rr-social-network" ></i> : <i onClick={() => {dislikeingComment(comment.id, comment.likedByUser, comment.dislikedByUser)}} style={upsideDown} className="fi fi-sr-thumbs-up"></i>}
                    </div>
                  </div>
                </div>
              ))
            }
          </div>
    )
}