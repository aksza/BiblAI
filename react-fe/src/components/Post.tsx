import {Ppost, Uuser} from '../pages/Home'
import {Link} from 'react-router-dom';
import '../styles/post_card.css'
import '../styles/comment.css'
import React, { useState } from 'react';
import { Button, Dialog, DialogContent, DialogTitle } from '@mui/material';
import { PostCard } from './PostCard';
import { CommentSection } from './CommentSection';



interface PostProps {
  post: Ppost;
}

interface UserProps {
  user: Uuser;
}


export const Post: React.FC<PostProps> = ({ post }) => {
  const [postModalOpen, setPostModalOpen] = useState(false);
  const handlePostModalOpen = () => setPostModalOpen(true);
  const handlePostModalClose = () => setPostModalOpen(false);

  return (
    <div className="Post">
      <PostCard post={post} handlePostModalOpen={handlePostModalOpen} />
      <Dialog open={postModalOpen} onClose={handlePostModalClose} maxWidth="md" fullWidth>
        <DialogTitle>{post.question}</DialogTitle>
        <DialogContent>
          <PostCard post={post} handlePostModalOpen={handlePostModalOpen} />
          <CommentSection post={post} />
        </DialogContent>
      </Dialog>
    </div>
  );
}


