import { useQuery } from 'react-query'
import { useState } from 'react';
import { Post } from '../components/Post';
import { Comment as CommentType } from '../../models/CommentModel'
import { User as UserType } from '../services/userContext';
import { getHomePrivate, getHomePublic } from '../services/endpointFetching';
import { useUser } from '../services/userContext';

import { Post as PostType} from './../../models/PostModel'
import '../styles/home.css'


export interface HomeModel {
  userId: number;
  userName: string;
  profilePictureUrl: string;
  posts: PostType[];
}

export const Home = () => {
  const user = useUser();
  const [publicHomeData, setPublicHomeData] = useState<PostType[]>([]);
  const [privateHomeData, setPrivateHomeData] = useState<HomeModel> ({
    userId: 0,
    userName: '',
    profilePictureUrl: '',
    posts: []
  });

  const handleLike = (postId: number, like: number, dislike: number) => {
    setPrivateHomeData((prevHomeData: HomeModel) => {
      const updatedPosts = prevHomeData.posts.map((post: PostType) => {
        if (post.id === postId) {
          return {
            ...post,
            likedByUser: like === 0 ? post.likedByUser : !post.likedByUser,
            dislikedByUser: dislike === 0 ? post.dislikedByUser : !post.dislikedByUser,
            numLikes: post.numLikes + like,
            numDislikes: post.numDislikes + dislike
          } as PostType;
        }
        return post;
      });

      return {
        ...prevHomeData,
        posts: updatedPosts
      };
    });
  }

  const handleCommentLike = (postId: number, commentId: number, like: number, dislike: number) => {
    setPrivateHomeData((prevHomeData: HomeModel) => {
      const updatedPosts = prevHomeData.posts.map(post => {
        if (post.id === postId) {
          return {
            ...post,
            comments: post.comments?.map(comment => {
              if (comment.id === commentId) {
                return {
                  ...comment,
                  likedByUser: like === 0 ? comment.likedByUser : !comment.likedByUser,
                  dislikedByUser: dislike === 0 ? comment.dislikedByUser : !comment.dislikedByUser,
                  numLikes: comment.numLikes + like,
                  numDislikes: comment.numDislikes + dislike
                } as CommentType;
              }
              return comment;
            })
          } as PostType;
        }
        return post;
      });

      return {
        ...prevHomeData,
        posts: updatedPosts
      };
    });
  }

  const handleComment = (postId: number, comment: string) => {
    setPrivateHomeData((prevHomeData: HomeModel) => {
      const updatedPosts = prevHomeData.posts.map(post => {
        const newComment = {
          id: 0,
          userId: user.user.id ?? 0,
          userName: user.user.userName ?? '',
          profilePictureUrl: user.user.profilePictureUrl ?? '',
          content: comment,
          dateCreated: new Date().toISOString(),
          likedByUser: false,
          dislikedByUser: false,
          numLikes: 0,
          numDislikes: 0
        } as CommentType;
        if (post.id === postId) {
          return {
            ...post,
            comments: [...post.comments ?? [], newComment]
          } as PostType;
        }
        return post;
      });

      return {
        ...prevHomeData,
        posts: updatedPosts
      };
    });
  }

  const { data, isLoading, isError, refetch } = useQuery([], () => {
    return localStorage.getItem('token') ? getHomePrivate() : getHomePublic();
  }, {
    onSuccess: (data) => {
      if(localStorage.getItem('token')) {
         setPrivateHomeData(data as HomeModel) 
         user.updateUser({
          id: (data as HomeModel).userId,
          userName: (data as HomeModel).userName,
          profilePictureUrl: (data as HomeModel).profilePictureUrl
        } as UserType);
      } else { 
        setPublicHomeData(data as PostType[])
      }
    }
  });

  return (
    <div className="Home">
      {isLoading && <div>Loading...</div>}
      {isError && <div>Error fetching data</div>}

      <div>
        {localStorage.getItem('token') ? 
        privateHomeData.posts.map((post: PostType) => (
          <Post key={post.id} post={post} handleLike={handleLike} handleCommentLike={handleCommentLike} handleComment={handleComment}/>
        )) : 
        publicHomeData.map((post: PostType) => (
          <Post key={post.id} post={post} handleLike={handleLike} handleCommentLike={handleCommentLike} handleComment={handleComment}/>
        ))}
      </div>
    </div>
  );
}