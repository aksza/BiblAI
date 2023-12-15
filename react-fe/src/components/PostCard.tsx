import { Post as PostType } from '../../models/PostModel'
import {Link} from 'react-router-dom';
import React from 'react';
import { deleteLike, likePost, updateLike } from '../services/endpointFetching';
import '../styles/post_card.css'
import '../styles/comment.css'

interface PostCardProps {
    post: PostType;
    handlePostModalOpen: () => void;
    handleLike : (postId : number, like: number, dislike: number) => void;
  }

export const PostCard: React.FC<PostCardProps> = ({ post, handlePostModalOpen, handleLike}) => {

    const likedPost = async () => {
        if (!post.likedByUser && !post.dislikedByUser) {
            likePost(true, 1, post.id)
            handleLike(post.id, 1, 0)
        } else if (post.likedByUser && !post.dislikedByUser) {
            deleteLike(1, post.id)
            handleLike(post.id, -1, 0)
        } else if (!post.likedByUser && post.dislikedByUser) {
            updateLike(1, post.id)
            handleLike(post.id , 1, -1)
        }
    }

    const dislikedPost = async () => {
        if (!post.likedByUser && !post.dislikedByUser) {
            likePost(false, 1, post.id)
            handleLike(post.id, 0, 1)
        } else if (!post.likedByUser && post.dislikedByUser) {
            deleteLike(1, post.id)
            handleLike(post.id, 0, -1)
        } else if (post.likedByUser && !post.dislikedByUser) {
            updateLike(1, post.id)
            handleLike(post.id, -1, 1)
        }
    }

    const upsideDown = {
        transform: 'rotate(180deg)'
    }

    return (
        <div className="PostCard">

            <div className="question_area">
                <p>{[post.question]}</p>
            </div>

            <div className="profile_info_area">
                {post.anonym 
                    ?<>
                        <p>{post.userName}</p>
                        <Link to={`/profile/${post.userId}`}><img src={post.profilePictureUrl} alt="" /></Link>
                    </>
                    :<>
                        <p>anonymus</p>
                        <Link to={`/profile/${post.userId}`}><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" alt="" /></Link>
                    </>
                }
            </div>

            <div className="answer_area">
                <p>{[post.answer]}</p>
            </div>

            <div className="feedback_area">
                <p>{post.numLikes}</p>
                {!post.likedByUser 
                ?   <i onClick={likedPost} className="fi fi-rr-social-network"></i> 
                :   <i onClick={likedPost} className="fi fi-sr-thumbs-up"></i>
                }
                <p>{post.numDislikes}</p>
                {!post.dislikedByUser 
                ?   <i onClick={dislikedPost} style={upsideDown} className="fi fi-rr-social-network" ></i> 
                :   <i onClick={dislikedPost} style={upsideDown} className="fi fi-sr-thumbs-up"></i>
                }
                <p>{post.comments.length}</p>
                <i className="fi fi-rr-comment-alt" onClick={handlePostModalOpen}></i>
            </div>
        </div>
    )

}