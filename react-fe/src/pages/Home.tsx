import {useQuery} from 'react-query'
import Axios from 'axios';
import { useState } from 'react';
import { Post } from '../components/Post';




interface Posts {
  userName: string;
  userId: number;
  posts: Ppost[];
}

export interface Users {
  userInfo: Uuser;
  posts: Ppost[];
}

export interface Ppost {
  id: number;
  userName: string;
  question: string;
  answer: string;
  verses: Vvers[];
  userId: number;
  profilePictureUrl: string;
  likesNum: number;
  dislikesNum: number;
  commentsNum: number;
  anonym: boolean;
  comments: Ccommnent[];
}

export interface Ccommnent {
  id: number;
  userName: string;
  content: string;
  userId: number;
  postId: number;
  likesNum: number;
  profilePictureUrl: string;
  author: boolean;
}

export interface Vvers {
  book: string;
  chapter: number;
  verse: number;
}

export interface Uuser {
  userId: number;
  userName: string;
  firstName: string;
  profilePictureUrl: string;
  lastName: string;
  email: string;
  password: string;
  birthDate: string;
  gender: boolean;
  married: boolean;
  bio: string;
  religion: string;
  posts: null;
}

interface PostProps {
  post: Ppost;
}

export const Home = () => {
  const [posts, setPosts] = useState<Posts>({} as Posts);

  const { data, isLoading, isError, refetch } = useQuery(['posts'], () => {
    return Axios.get(`http://localhost:7060/home`)
      .then((res) => {
        console.log(res.data);
        setPosts(res.data);
      });
  });
  



  return (
    <div className="Home">
      {isLoading && <div>Loading...</div>}
      {isError && <div>Error fetching data</div>}
      <div>
        {posts.posts?.map((post: Ppost) => (
          <Post key={post.question} post={post} />
        ))}
      </div>
      
    </div>
  );
}