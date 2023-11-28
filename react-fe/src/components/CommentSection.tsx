import { Post as PostType} from '../../models/PostModel'
import { Users } from '../../models/UserModel'
import React, { useState } from 'react';
import Input from '@mui/material/Input';
import { Button, Dialog, DialogContent, DialogTitle } from '@mui/material';
import Axios from 'axios';
import { fetchPost } from '../services/fetchMethods';




import '../styles/post_card.css'
import '../styles/comment.css'
import { redirect } from 'react-router-dom';



export const CommentSection: React.FC<PostType> = (post: PostType) => {
    const [commentContent, setCommentContent] = useState('');

    function postComment() {
      Axios.post(`https://localhost:7060/api/Comment/create`, 
      {
        content: "string2",
        userId: 1,
        postId: 1,
        date: "2023-11-27T15:56:51.149Z"
      }, {
        headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        }
      })
      .then((res) => {
        console.log(res.data);
      })
      .catch((err) => {
        console.log('Error posting comment: ');
        console.log(err);
      })

      setCommentContent('')
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
                      <img src="https://cdn-icons-png.flaticon.com/128/2961/2961957.png" alt="" />
                    </div>
                  </div>
                </div>
              ))
            }
          </div>
    )
}