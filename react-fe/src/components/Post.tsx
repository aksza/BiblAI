import { Post as PostType } from '../../models/PostModel'
import '../styles/post_card.css'
import '../styles/comment.css'
import React, { useState } from 'react';
import { Button, Dialog, DialogContent, DialogTitle, setRef, makeStyles } from '@mui/material';
import { PostCard } from './PostCard';
import { CommentSection } from './CommentSection';

interface PostProps {
    post: PostType;
    handleLike : (postId : number, like: number, dislike: number) => void;
    handleCommentLike : (postId : number, commentId : number, like: number, dislike: number) => void;
    handleComment : (postId : number, comment : string) => void;
  }


export const Post: React.FC<PostProps> = ({post, handleLike, handleCommentLike, handleComment}) => {
  const [postModalOpen, setPostModalOpen] = useState(false);
  const handlePostModalOpen = () => setPostModalOpen(true)
  const handlePostModalClose = () => setPostModalOpen(false);

  return (
    <div className="Post">
      <PostCard post={post} handlePostModalOpen={handlePostModalOpen} handleLike={handleLike} />
      <Dialog open={postModalOpen} onClose={handlePostModalClose} maxWidth="md" fullWidth style={{ padding: 0 }}>
        <DialogContent style={{ padding: 0, fontFamily: 'Kumbh Sans' }}>
          <PostCard post={post} handlePostModalOpen={handlePostModalOpen} handleLike={handleLike}/>
          <CommentSection post={post} handleCommentLike={handleCommentLike} handleComment={handleComment}/>
        </DialogContent>
      </Dialog>
    </div>
  );
}


