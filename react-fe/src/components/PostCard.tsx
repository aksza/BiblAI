import { Post as PostType } from '../../models/PostModel'
import {Link} from 'react-router-dom';
import React from 'react';
import { deleteLike, likePost, updateLike } from '../services/endpointFetching';
import '../styles/post_card.css'
import '../styles/comment.css'
import { useUser } from '../services/userContext';

interface PostCardProps {
    post: PostType;
    handlePostModalOpen: () => void;
    handleLike : (postId : number, like: number, dislike: number) => void;
  }

export const PostCard: React.FC<PostCardProps> = ({ post, handlePostModalOpen, handleLike}) => {
    const user = useUser();

    const likedPost = async () => {
        if (!post.likedByUser && !post.dislikedByUser) {
            likePost(true, user.user.id ?? 0, post.id)
            handleLike(post.id, 1, 0)
        } else if (post.likedByUser && !post.dislikedByUser) {
            deleteLike(user.user.id ?? 0, post.id)
            handleLike(post.id, -1, 0)
        } else if (!post.likedByUser && post.dislikedByUser) {
            updateLike(user.user.id ?? 0, post.id)
            handleLike(post.id , 1, -1)
        }
    }

    const dislikedPost = async () => {
        if (!post.likedByUser && !post.dislikedByUser) {
            likePost(false, user.user.id ?? 0, post.id)
            handleLike(post.id, 0, 1)
        } else if (!post.likedByUser && post.dislikedByUser) {
            deleteLike(user.user.id ?? 0, post.id)
            handleLike(post.id, 0, -1)
        } else if (post.likedByUser && !post.dislikedByUser) {
            updateLike(user.user.id ?? 0, post.id)
            handleLike(post.id, -1, 1)
        }
    }

    const upsideDown = {
        transform: 'rotate(180deg)',
        zIndex: 2
    }

    return (
        <div className="PostCard">

            <div className="question_area">
                <p>{[post.question]}</p>
            </div>

            <div className="profile_info_area">
                {post.anonym 
                    ?<>
                        <p>@{post.userName}</p>
                        <Link to={`/profile/${post.userId}`}><img src={post.profilePictureUrl} alt="" /></Link>
                    </>
                    :<>
                        <p>anonymus</p>
                        <img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png" alt="" />
                    </>
                }
            </div>

            <div className="answer_area">
                <p>{[post.answer]}</p>
            </div>


            {localStorage.getItem('token') &&
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
            }
        </div>
    )

}