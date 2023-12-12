import {useQuery} from 'react-query'
import { useState } from 'react';
import { useParams } from 'react-router-dom';
import { Post } from '../components/Post';
import { Comment as CommentType } from '../../models/CommentModel'
import { getHome } from '../services/endpointFetching';

import { Post as PostType } from './../../models/PostModel'
import '../styles/home.css'


export const Home = () => {
  const [posts, setPosts] = useState<PostType[]>([] as PostType[]);
  const { userId } = useParams();

  const handleLike = (postId : number, like : number, dislike : number) => {
    setPosts(prevPosts => {
      return prevPosts.map(post => {
        if (post.id === postId) {
          return {
            ...post,
            likedByUser: like === 0 ? post.likedByUser : !post.likedByUser,
            dislikedByUser: dislike === 0 ? post.dislikedByUser : !post.dislikedByUser,
            numLikes : post.numLikes + like,
            numDislikes : post.numDislikes + dislike
          } as PostType;
        }
        return post;
      });
    });
  }

  const handleCommentLike = (postId : number, commentId : number, like : number, dislike : number) => {
    setPosts(prevPosts => {
      return prevPosts.map(post => {
        if (post.id === postId) {
          return {
            ...post,
            comments: post.comments?.map(comment => {
              if (comment.id === commentId) {
                return {
                  ...comment,
                  likedByUser: like === 0 ? comment.likedByUser : !comment.likedByUser,
                  dislikedByUser: dislike === 0 ? comment.dislikedByUser : !comment.dislikedByUser,
                  numLikes : comment.numLikes + like,
                  numDislikes : comment.numDislikes + dislike
                } as CommentType;
              }
              return comment;
            })
          } as PostType;
        }
        return post;
      });
    });
  }

  const handleComment = (postId : number, comment : string) => {
    setPosts(prevPosts => {
      return prevPosts.map(post => {
        if (post.id === postId) {
          return {
            ...post,
            comments: [
              ...post.comments ?? [],
              {
                id: 0,
                userId: 1,
                userName: 'danika',
                profilePictureUrl: post.profilePictureUrl,
                content: comment,
                date: new Date().toISOString(),
                likedByUser: false,
                dislikedByUser: false,
                numLikes: 0,
                numDislikes: 0
              } as CommentType
            ]
          } as PostType;
        }
        return post;
      });
    });
  }

  const { data, isLoading, isError, refetch } = useQuery(['posts', userId ?? ''], () => getHome(parseInt(userId ?? '')), {
    onSuccess: (data: PostType[]) => {
      setPosts(data);
    }
  });


  
  return (
    <div className="Home">
      {isLoading && <div>Loading...</div>}
      {isError && <div>Error fetching data</div>}
      <div>
        {posts.map((post: PostType) => (
          console.log('asd'),
          <Post key={post.id} post={post} handleLike={handleLike} handleCommentLike={handleCommentLike} handleComment={handleComment}/>
        ))}
      </div>
    </div>
  );
}